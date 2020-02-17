module MyModule
  def self.extended(base)
    base.prepend(FilterModule)
  end

  def self.included(base)
    base.extend(MyModule)
    base.prepend(FilterModule)
  end

  def before_filter(*methods, **options)
    # methods.each do |meth|
      validate_methods(methods)
      # check_if_private?(meth) if new.respond_to?(meth, true)
    # end
    # @before_methods = methods
    # p methods
    # p filter_methods
    filter_methods['before_methods'] << methods
    # p filter_methods
    filter_options['before_options'] << options
  end

  def after_filter(*methods, **options)
    # methods.each do |meth|
      validate_methods(methods)
      # check_if_private?(meth) if new.respond_to?(meth, true)
    # end
    # @after_methods = methods
    filter_methods['after_methods'] << methods
    filter_options['after_options'] << options
  end

  def filter_methods
    @filter_methods ||= {'before_methods' => [], 'after_methods' => []}
  end

  def filter_options
    @filter_options ||= {'before_options' => [], 'after_options' => []}
  end

  # def before_option
  #   @before_option
  # end

  # def before_methods
  #   @before_methods
  # end

  # def after_methods
  #   @after_methods
  # end

  # def after_option
  #   @after_option
  # end
  def validate_methods(methods)
    methods.each do |meth|
    if new.respond_to?(meth, true)
      raise "#{meth} is not private" unless private_method_defined?(meth)
    end
  end
  end

  # def check_if_private?(meth)
  #   raise "#{meth} is not private" unless private_method_defined?(meth)
  # end

  def action_methods(*arguments)
    @action_methods = arguments
    # p filter_methods['before_methods'][0]
    FilterModule.execute_method(arguments)
  end

  def method_added(name)
    # p self
    if  defined?(filter_methods['before_methods'][0][0])#(@before_methods) respond_to?('before_filter', true) &&
      # p defined?(filter_methods['before_methods'][0][0])
      validate_methods(filter_methods['before_methods'][0]) unless filter_methods['before_methods'][0].include?(name)
      # self.filter_methods['before_methods'][0].each do |before_method|
        # break if name == before_method
        # validate_method(before_method)
        # check_if_private?(before_method) if new.respond_to?(before_method, true)
      # end
    end
    if defined?(filter_methods['after_methods'][0][0])#(@after_methods)
      # self.filter_methods['after_methods'][0].each do |after_method|
        # break if name == after_method
        validate_methods(filter_methods['after_methods'][0]) unless filter_methods['after_methods'][0].include?(name)
        # check_if_private?(after_method) if new.respond_to?(after_method, true)
      # end
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
        filter_methods = self.class.filter_methods
        # p filter_methods
        filter_options = self.class.filter_options
        update_methods(action_meth, filter_methods, filter_options)
        # p @before_methods
        @before_methods.each { |meth| method(meth).call }
        super()
        @after_methods.each { |meth| method(meth).call }
      end
    end

    def update_methods(action_meth, filter_methods, filter_options)
      @before_methods = filter_methods['before_methods'][0]
      # p filter_methods['before_methods'][0]
      @after_methods = filter_methods['after_methods'][0]
      before_option = filter_options['before_options'][0]
      after_option = filter_options['after_options'][0]
      @before_methods = [] if before_option[:only] && before_option[:only][0] != action_meth ||
                                                  before_option[:except] && before_option[:except][0] == action_meth
      @after_methods = [] if after_option[:only] && after_option[:only][0] != action_meth ||
                                                 after_option[:except] && after_option[:except][0] == action_meth
    end
  end
end

class MyClass
  extend MyModule

  action_methods :your_method

  before_filter :foo , only: [:your_method]

  action_methods  :my_method

  private def foo
    puts 'inside foo'
  end

  private def bar
    puts 'inside bar'
  end

  private def baz
    puts 'inside baz'
  end

  def my_method
    puts 'inside my_method'
  end

  def your_method
    puts 'inside your_method'
  end
  
  action_methods  :our_method
  after_filter :baz, :bar, except: [:my_method]

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
# inside my_method

p '-----------------------'

m.your_method
# ---Output----
# inside foo
# inside your_method
# inside baz
# inside bar

p '-----------------------'

m.fake_method
# ---Output----
# inside fake_method

p '-----------------------'

m.our_method
# ---Output----
# inside our_method
# inside baz
# inside bar
































































# module MyModule

#   def self.extended(base)
#     base.prepend(FilterModule)
#   end

#   def self.included(base)
#     base.extend(MyModule)
#     base.prepend(FilterModule)
#   end

#     def before_filter(*methods, **options)
#       methods.each do |meth|
#         if self.new.respond_to?(meth, true)
#           # p private_method_defined?("foo")
#           check_if_private?(meth)
#         end
#       end
#       @before_methods = methods
#       @before_option = options
#     end

#     def after_filter(*methods, **options)
#       methods.each do |meth|
#         if self.new.respond_to?(meth, true)
#           check_if_private?(meth)
#         end
#       end
#       @after_methods = methods
#       @after_option = options
#     end
    
    
#     def before_option
#       @before_option
#     end
#     def before_methods
#       @before_methods
#     end
#     def after_methods
#       @after_methods
#     end
#     def after_option
#       @after_option
#     end

#     def check_if_private?(meth)
#       raise "#{meth} is not private" unless private_method_defined?("#{meth}")
#     end

#     def action_methods(*args, **options)
#       @action_methods = args
#       # args.each do |action_meth|
#         # p @before_option
#         # if @before_option[:except]
#         FilterModule.execute_method(args)
#       # end
#     end

#     def method_added(name)
#       if self.respond_to?('before_filter', true) && defined?(@before_methods)
#         @before_methods.each do |before_method|
#           break if name == before_method
#           self.check_if_private?(before_method) if self.new.respond_to?(before_method, true)
#         end
#       end

#       if self.respond_to?('after_filter', true) && defined?(@after_methods)
#         @after_methods.each do |after_method|
#           break if name == after_method
#           self.check_if_private?(after_method) if self.new.respond_to?(after_method, true)
#         end
#       end
#   end
  
  
#   module FilterModule
#     def self.prepended(base)
#       @base = base
#     end

#     # define_method()
#     def self.execute_method(action_methods)
#       action_methods.each do |action_meth|
#         create_dynamic_method(action_meth)
#         # define_method(action_meth) do
#         #   before_methods = self.class.before_methods
#         #   before_option = self.class.before_option
#         #   after_option = self.class.after_option
#         #   after_methods = self.class.after_methods
#         #   # check_options(action_meth)
#         # #   # self.instance_eval do
#         #   # p before_option
#         # #   self.class.class_eval do
#         # before_methods = [] if before_option[:only] && before_option[:only][0] != action_meth
#         # before_methods = [] if before_option[:except] && before_option[:except][0] == action_meth
#         # # end
#         # after_methods = [] if after_option[:only] && after_option[:only][0] != action_meth
#         # after_methods = [] if after_option[:except] && after_option[:except][0] == action_meth
#         #   # p 
#         #   # end
#         #   # p self.class.before_methods
#         #   before_methods.each{|meth| method(meth).call}
#         #   super()
#         #   after_methods.each{|meth| method(meth).call}
#         #   # end
#         # end
#       end
#       # define_method('foo') do
#       #   p 'foo from new mod'
#     end

     
#     def self.create_dynamic_method(action_meth)
#       define_method(action_meth) do
#         before_methods = self.class.before_methods
#         before_option = self.class.before_option
#         after_option = self.class.after_option
#         after_methods = self.class.after_methods
#         # check_options(action_meth)
#       #   # self.instance_eval do
#         # p before_option
#       #   self.class.class_eval do
#       before_methods = [] if before_option[:only] && before_option[:only][0] != action_meth
#       before_methods = [] if before_option[:except] && before_option[:except][0] == action_meth
#       # end
#       after_methods = [] if after_option[:only] && after_option[:only][0] != action_meth
#       after_methods = [] if after_option[:except] && after_option[:except][0] == action_meth
#         # p 
#         # end
#         # p self.class.before_methods
#         before_methods.each{|meth| method(meth).call}
#         super()
#         after_methods.each{|meth| method(meth).call}
#         # end
#       end
#     end
    
#       def check_options(action_meth)
#         @kal = 'das'
#         # self.class.class_eval do
#           # before_methods = self.class.before_methods
#           # before_option = self.class.before_option
#           # after_option = self.class.after_option
#           # after_methods = self.class.after_methods
#           # check_options()
#           # self.instance_eval do
#           # p self
#           # self.class.class_eval do
#           # p action_meth
#         before_methods = [] if before_option[:only] && before_option[:only][0] != action_meth
#         before_methods = [] if before_option[:except] && before_option[:except][0] == action_meth
#         # end
#         after_methods = [] if after_option[:only] && after_option[:only][0] != action_meth
#         after_methods = [] if after_option[:except] && after_option[:except][0] == action_meth
#           # p before_methods
#         # end
#       end
#   end
  
#   # FilterModule.execute_method
# end




# class MyClass

#   extend MyModule

#   # before_filter: Proc.new {}
#   before_filter :foo, :bar
#   after_filter :baz

#   action_methods :your_method, :my_method

#   private def foo
#     p 'inside foo'
#   end

#   private def bar
#     p 'inside bar'
#   end

#   private def baz
#     p 'inside baz'
#   end

#   def my_method
#     p 'inside my_method'
#   end

#   def your_method
#     p 'inside your_method' 
#   end

#   def fake_method
#     p 'inside fake_method' 
#   end
#   # before_filter :baz, except: [:your_method]

# end


# m = MyClass.new
# m.my_method
# p ''
# m.your_method
# p ''
# m.fake_method
# # p MyClass.new.respond_to?("fake_method", true)





# @args = args
# @args.each do |method|
#   @method = method
#   define_method("#{method}_hook") do
#     @@before_methods.each {|before_meth| send(before_meth)}
#      self.send("#{method}_without_hook")
#      @after_methods.each {|after_meth| send(after_meth)}
#   end
# end
#   def self.method_added(name)
#     @args.each do |method|
#    @method = method
#     if /hook/.match(name.to_s) or method_defined?("#{name}_without_hook")
#       # p @method
#       return
#     end
#     # p @method
#     if @method == name
#       # p "#{@method}_without_hook"
#       class_eval("alias #{@method}_without_hook #{@method}")
#       class_eval("alias #{@method} #{@method}_hook")
#   end
