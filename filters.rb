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
    collect_before_methods(methods, options)
  end

  def after_filter(*methods, **options)
    validate_methods(methods)
    collect_after_methods(methods, options)
  end

  def collect_before_methods(methods, options)
    methods.each do |meth|
      before_methods[meth]
      before_methods[meth][:only].concat(options[:only]) if options[:only]
      before_methods[meth][:except].concat(options[:except]) if options[:except]
    end
  end

  def collect_after_methods(methods, options)
    methods.each do |meth|
      after_methods[meth]
      after_methods[meth][:only].concat(options[:only]) if options[:only]
      after_methods[meth][:except].concat(options[:except]) if options[:except]
    end
  end

  def before_methods
    @before_methods ||= Hash.new { |hash, key| hash[key] = { only: [], except: [] }}
  end

  def after_methods
    @after_methods ||= Hash.new { |hash, key| hash[key] = { only: [], except: [] }}
  end

  def validate_methods(methods)
    methods.each do |meth|
      if new.respond_to?(meth, true)
        raise "#{meth} is not private" unless private_method_defined?(meth)
      end
    end
  end

  def action_methods(*arguments)
    @action_methods = arguments
    FilterModule.execute_method(arguments)
  end

  def method_added(name)
    if defined?(filter_methods[:before_methods][0][0])
      validate_methods(filter_methods[:before_methods][0]) unless filter_methods[:before_methods][0].include?(name)
    end
    if defined?(filter_methods[:after_methods][0][0])
      validate_methods(filter_methods[:after_methods][0]) unless filter_methods[:after_methods][0].include?(name)
    end
  end

  module FilterModule
    def self.execute_method(action_methods)
      action_methods.each do |action_meth|
        create_dynamic_method(action_meth)
      end
    end

    def self.create_dynamic_method(action_meth)
      define_method(action_meth) do
        self.class.before_methods.each_pair do |meth, option|
          method(meth).call if check_condition(action_meth, option)
        end
        super()
        self.class.after_methods.each_pair do |meth, option|
          method(meth).call if check_condition(action_meth, option)
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
  after_filter  :maz, except: [:my_method]

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
# inside baz
# inside my_method

p '-----------------------'

m.your_method
# ---Output----
# inside foo
# inside bar
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
# inside baz
# inside our_method
# inside maz
