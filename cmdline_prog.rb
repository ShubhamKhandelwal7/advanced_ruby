class DynamicClass
  attr_accessor :new_class, :class_name

  def initialize(class_name)
    @class_name = class_name
    # p eval("class #{class_name}; end")
    # p class_name.new
  end

  def dynamic_creator(method_name, method_body)
    @new_class = Object.const_set(class_name, Class.new)
    # new_class.instance_eval()
    # p @new_class
    # @new_class.instance_variable_set("@method_name", method_name)
    # @new_class.instance_variable_set("@method_body", method_body)
    # @new_class.class_eval do 
    #   # meth_bdy = method_body
    #   # p @str
    # def method_name
    #   # self.class.class_eval("puts #{method_body}")
    #   puts method_body
    #   end
    # end
    new_class.class_eval("def #{method_name}; puts #{method_body}; end")
    # new_class.new.method_name

  end
  # def call(meth)
  #   # @new_class.new.send(meth)
  #   @new_class.new.instance_eval(meth)
    
  # end
  
end

puts "Please enter the class name: "
class_name = gets.strip
puts "Please enter the method name you wish to define: "
method_name = gets.strip
puts "Please enter the method's code: "
method_body = gets.strip

myclass = DynamicClass.new(class_name)
myclass.dynamic_creator(method_name, method_body)
# myclass.call(dynamic_creator)
# p Kobe.new

# myclass.call(method_name)
myclass.new_class.new.public_send(method_name)
