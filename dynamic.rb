class Dynamic < String
    def exclude?( value_to_check)
      !self.include?(value_to_check)
    end

  def append_and_inverse(arg1, *argn)
    # "#{self} #{arg1} #{argn.to_s.tr('["] ,','')}".swapcase
    "#{self} #{arg1} #{argn.join('')}".swapcase
  end
end

  # class << self
  #   def create_object
  #     puts "Enter name of the object:"
  #     @@object = gets.strip
  #   end

    # def method_prompt
    #   class_obj = self.new
    #   puts "call any of the methods:"
    #   method_name = gets.strip
    #   # puts "enter the arguments #{method(class_obj.method_name).parameters}"
    #   class_obj.instance_eval do
    #     puts "enter the arguments #{method(method_name).parameters}"
    #     args = gets.strip.split(',')
    #     required_arg = args[0]
    #     args.shift
    #     send(method_name, required_arg, *args)
    #   end
    # end
  # end

# Dynamic.create_object
# puts "Availaible methods - #{Dynamic.instance_methods(false)}"
# Dynamic.method_prompt
String.new('das')
puts 'Enter the string:'
dynamic = Dynamic.new gets.chomp
p dynamic
puts "Availaible methods - #{Dynamic.instance_methods(false)}"
puts 'call any of the methods:'
method_name = gets.strip
dynamic.instance_eval do
  puts "enter the arguments #{method(method_name).parameters}"
end
args = gets.strip.split(',')
required_arg = args[0]
args.shift
puts dynamic.public_send(method_name, required_arg, *args)




















































# class Dynamic < String
#   def exclude?(value_to_check)
#     puts !@@object.include?(value_to_check)
#   end

#   def append_and_inverse(arg1, *argn)
#     puts "#{@@object} #{arg1} #{argn.to_s.tr('["] ,', '')}".swapcase
#   end

#   class << self
#     def create_object
#       puts 'Enter name of the object:'
#       @@object = gets.strip
#     end

#     def method_prompt
#       puts 'call any of the methods:'
#       method_name = gets.strip
#       new.instance_eval do
#         puts "enter the arguments #{method(method_name).parameters}"
#         args = gets.strip.split(',')
#         required_arg = args[0]
#         args.shift
#         send(method_name, required_arg, *args)
#       end
#     end
#   end
# end

# Dynamic.create_object
# puts "Availaible methods - #{Dynamic.instance_methods(false)}"
# Dynamic.method_prompt


























# class Dynamic < String
#   def initialize
#   end

#     def exclude?( value_to_check)
#       puts !@@object.include?(value_to_check)
#     end

#   def append_and_inverse(arg1, *argn)
#     puts "#{@@object} #{arg1} #{argn.to_s.tr('["] ,','')}".swapcase
#   end

#   class << self
#     def create_object
#       puts "Enter name of the object:"
#       @@object = gets.strip
#     end

#     def method_prompt
#       class_obj = self.new
#       puts "call any of the methods:"
#       method_name = gets.strip
#       # puts "enter the arguments #{method(class_obj.method_name).parameters}"
#       class_obj.instance_eval do
#         puts "enter the arguments #{method(method_name).parameters}"
#         args = gets.strip.split(',')
#         required_arg = args[0]
#         args.shift
#         method_name required_arg, *args
#       end
#     end
#   end
# end

# Dynamic.create_object
# puts "Availaible methods - #{Dynamic.instance_methods(false)}"
# Dynamic.method_prompt