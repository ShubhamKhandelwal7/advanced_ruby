module Concern
  # Write your code
  def self.included(klass)
    # def klass.included(subklass)
      # p "included called and used in #{klass}"
      # klass.my_instance_method
    # klass.extend(klass::ClassMethods)
      # klass.class_eval('def self.included(klas); klas.extend(ClassMethods); end')
      class << klass
        define_method("included") do |klas|
          # p self::const_get 'ClassMethods'
          klas.extend(self::ClassMethods) if self.const_defined?('ClassMethods')
        end
      end
      # class << klass
    # def klass.included(klas)
    #   klas.extend(klass::ClassMethods)
    # end
  # end
    # def klass.included(base)
    #   p base
    # end
  end
end

module Mixin
  include Concern
  # def self.included(klass)
  #   # p "included in #{klass}"
  # end
  module ClassMethods
    # All class methods go here

    def my_class_method
      puts "my_class_method"
    end
  end

  # All instance methods go here
  def my_instance_method
    puts "my_instance_method"
  end
end

class MyClass
  include Mixin

  # my_class_method is available as class method
  # my_instance_method is available as instance method
end

# module Concern
#   extend Mixin
# end

MyClass.new.my_instance_method
MyClass.my_class_method
# p MyClass::ClassMethods.my_class_method
# p Concern::ClassMethods.my_class_method
