module MyModule
  def self.extended(base)
    base.prepend(FilterModule)
  end

  def self.included(base)
    base.extend(MyModule)
    base.prepend(FilterModule)
  end

  def before_filter(*methods, **options)
    validate_methods(methods)
    collect_methods(before_methods, methods, options)
  end

  def after_filter(*methods, **options)
    validate_methods(methods)
    collect_methods(after_methods, methods, options)
  end

  def collect_methods(filter_method, methods, options)
    methods.each do |meth|
      filter_method[meth][:only].concat(options[:only] ||= [])
      filter_method[meth][:except].concat(options[:except] ||= [])
    end
  end

  def before_methods
    @before_methods ||= Hash.new { |hash, key| hash[key] = { only: [], except: [] } }
  end

  def after_methods
    @after_methods ||= Hash.new { |hash, key| hash[key] = { only: [], except: [] } }
  end

  def validate_methods(methods)
    methods.each do |meth|
        raise "#{meth} is not private" if !meth.is_a?(Proc) && method_defined?(meth)
    end
  end

  def action_method
    @action_method ||= []
  end

  def action_methods(*arguments)
    action_method.concat(arguments)
  end

  def method_added(name)
    if action_method.include?(name)
      FilterModule.execute_method(name)
    end
  end

  module FilterModule
    def self.execute_method(action_meth)
      define_method(action_meth) do
        self.class.before_methods.each_pair do |meth, option|
          call_methods(meth, option, action_meth)
        end
        super()
        self.class.after_methods.each_pair do |meth, option|
          call_methods(meth, option, action_meth)
        end
      end

      def call_methods(meth, option, action_meth)
        if meth.is_a?(Proc) && check_condition(action_meth, option)
          meth.call
        elsif check_condition(action_meth, option)
          method(meth).call
        end
      end

      def check_condition(action_meth, option)
        ((option[:only].include?(action_meth) || option[:only].empty?) &&
                               !option[:except].include?(action_meth))
      end
    end
  end
end

class MyClass
  extend MyModule

  action_methods :your_method

  before_filter :foo, :bar, only: [:your_method]
  before_filter proc { puts 'Test Proc' }
  before_filter :baz
  action_methods :my_method

  private def foo
    puts 'inside foo'
  end

  private def bar
    puts 'inside bar'
  end

  private def baz
    puts 'inside baz'
  end

  private def maz
    puts 'inside maz'
  end

  def my_method
    puts 'inside my_method'
  end

  def your_method
    puts 'inside your_method'
  end

  action_methods :our_method
  after_filter :maz, except: [:my_method]

  def our_method
    puts 'inside our_method'
  end

  def fake_method
    puts 'inside fake_method'
  end
end

m = MyClass.new
m.my_method
# ---Output----
# Test Proc
# inside baz
# inside my_method

p '-----------------------'

m.your_method
# ---Output----
# inside foo
# inside bar
# Test Proc
# inside baz
# inside your_method
# inside maz

p '-----------------------'

m.fake_method
# ---Output----
# inside fake_method

p '-----------------------'

m.our_method
# ---Output----
# Test Proc
# inside baz
# inside our_method
# inside maz