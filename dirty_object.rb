# module DirtyObject
#   def self.included(base)
#     base.prepend(Extensions)
#     DirtyObject.create_methods(base)
#   end

#   module Extensions
#     def self.create_writer(attr)
#       define_method("#{attr}=") do |value|
#         define_attr_method(attr, value)
#         super(value)
#       end
#     end
#   end
  
#   def self.create_methods(base)
#     base.define_singleton_method('define_dirty_attributes') do |*attributes|
#       non_writers = attributes.reject { |attr| method_defined?("#{attr}=") }
#       raise "#{non_writers.inspect} not an accessor" unless non_writers.empty?
#       attributes.each do |attr|
#         define_method("#{attr}_was") { attribute_values[attr][0] }
#         Extensions.create_writer(attr)
#       end
#     end
#   end

#   def define_attr_method(attr, value)
#     attr_variable = "@#{attr}"
#     if attribute_values.key?(attr) && attribute_values[attr][0] == value
#         attribute_values.delete(attr)
#     elsif attribute_values.key?(attr)
#         attribute_values[attr][1] = value
#     end
#     attribute_values[attr] = [instance_variable_get(attr_variable), value] unless attribute_values.key?(attr)
#     # instance_variable_set(attr_variable, value)
#   end

#   def changed?
#     attribute_values.any?
#   end

#   def changes
#     attribute_values
#   end

#   def save
#     attribute_values.clear.empty?
#   end

#   def attribute_values
#     @__dirty_attribute ||= Hash.new { |hash, key| hash[key] = [nil, nil] }
#   end
# end

module DirtyObject
  def self.included(base)
    base.prepend(Extensions)
    base.define_singleton_method('define_dirty_attributes') do |*attributes|
      non_writers = attributes.reject { |attr| method_defined?("#{attr}=") }
      raise "#{non_writers.inspect} not an accessor" unless non_writers.empty?
      DirtyObject.create_methods(attributes)
    end
  end

  def self.create_methods(attributes)
    attributes.each do |attr|
      define_method("#{attr}_was") do
        attribute_values[attr][0]
      end
      Extensions.create_writer(attr)
    end
  end

  module Extensions
    def self.create_writer(attr)
      define_method("#{attr}=") do |value|
        prev_val = public_send(attr)
        super(value)
        define_attr_method(attr, public_send(attr), prev_val)
      end
    end
  end

  def define_attr_method(attr, value, prev_val)
    # attr_variable = "@#{attr}"
    if attribute_values.key?(attr) && attribute_values[attr][0] == value
        attribute_values.delete(attr)
    elsif attribute_values.key?(attr)
        attribute_values[attr][1] = value
    end
    attribute_values[attr] = [prev_val, value] unless attribute_values.key?(attr)
    # instance_variable_set(attr_variable, value)
  end

  def changed?
    attribute_values.any?
  end

  def changes
    attribute_values
  end

  def save
    attribute_values.clear.empty?
  end

  def attribute_values
    @__dirty_attribute ||= Hash.new { |hash, key| hash[key] = [nil, nil] }
  end
end

class User
  include DirtyObject

  attr_accessor :name, :age, :email
  define_dirty_attributes :name, :age

  # def name=(value)
  #   @name = value.upcase
  # end
  # def age=(value)
  #   # p value.upcase
  # end
end

class AnotherUser
  include DirtyObject

  attr_accessor :name, :age, :email
  define_dirty_attributes :name, :age

  def name=(value)
    # @name = value.upcase
  end
  def age=(value)
    # p 'calling age='
  end
end

au = AnotherUser.new

au.name = 'Shubham'
au.email = 'shubham@vinsol.com'
au.age   = 24

au.changed?
au.changes

u = User.new

u.name  = 'Akhil'
u.email = 'akhil@vinsol.com'
u.age   = 30

u.changed? #=> true

p u.changes  #=> { name: [nil, 'Akhil], age: [nil, 30] }

u.name_was #=> nil

# u.email_was  #=> undefined method.....
u.age_was

u.save       #=> true

u.changed?   #=> false

u.changes    #=> {}

u.name = 'New name'
u.age  = 31
p u.changes #=> {name: ['Akhil', 'New name'], age: [30, 31]}
u.name_was  #=> 'Akhil'

u.name = 'Akhil'
u.changes   #=> {age: [30, 31]}

u.changed?  #=> true

u.age = 30
u.changes   #=> {}

u.changed?
