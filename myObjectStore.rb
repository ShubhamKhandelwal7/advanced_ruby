module MyObjectStore
  def self.included(base)
    base.extend(Extensions)
  end

  module Extensions
    def attr_accessors
      @__attribs ||= []
    end

    def my_objects
      @__my_objects ||= []
    end

    def error_logs
      @__error_messages ||= Hash.new {|hash, key| hash[key] = [] }
    end

    def validations
      @__all_validations ||= {}
    end

    def validate_presence_attr
      @__validate_presence_attr ||= Hash.new { |hash, key| hash[key] = {} }
    end

    def validate_format_attr
      @__validate_format_attr ||= Hash.new { |hash, key| hash[key]=[] }
    end

    def validate_format_of(*validate_attribute, **check_method)
      check_for_non_existing_attributes(validate_attribute)
      validate_attribute.each do |attr|
        validate_format_attr[attr] << check_method[:format]
      end
    end

    def validate_presence_of(*validate_attribute, **check_method)
      check_for_non_existing_attributes(validate_attribute)
      validate_attribute.each do |attr|
        validate_presence_attr[attr] = check_method
      end
      # p validate_presence_attr
    end

    def check_for_non_existing_attributes(attributes_to_check)
      missing_attrs = attributes_to_check.reject { |missing| attr_accessors.include?(missing) }
      raise "attribute #{missing_attrs} not present here" unless missing_attrs.empty?
    end

    def attr_accessor(*parameters)
      super
      parameters.uniq!
      attr_accessors.concat(parameters)
      # define_dynamic_finders
    end

    # def define_dynamic_finders
    #   attr_accessors.each do |param|
    #     define_singleton_method("find_by_#{param}") do |value|
    #       (my_objects.select { |obj| obj.public_send(param) == value}).to_enum
    #     end
    #   end
    # end

    def method_missing(*meth_name)
      if meth_name[0].to_s.include?('find_by')
        attr_name = meth_name[0].to_s.rpartition('_').last
        create_method(attr_name)
        public_send("find_by_#{attr_name}", meth_name[1])
      end
    end

    def create_method(attr_name)
      define_singleton_method("find_by_#{attr_name}") do |value|
        (my_objects.select { |obj| obj.public_send(attr_name) == value}).to_enum
      end
    end

    def collect
      my_objects.to_enum
    end

    def count
      my_objects.count
    end

    def validator
      validations['presence'] = attr_accessors.select { |attr| validate_presence_attr.include?(attr) }
      validations['format'] = attr_accessors.select { |attr| validate_format_attr.include?(attr) }
      validations
    end
  end

  def check_validations
    if self.class.validate_presence_attr
      self.class.validate_presence_attr.each { |attr| return false, attr[0] unless check_presence?(attr) }
    end
    if self.class.validate_format_attr
      self.class.validate_format_attr.each { |attr| return false, attr[0] unless check_format?(attr) }
    end
  return true, nil
  end

  def check_presence?(attr)
    method_check = self.public_send(attr[0])
    # p respond_to?(attr[1][:if])
    if (attr[1][:if] && respond_to?(attr[1][:if]) && !self.public_send(attr[1][:if]) ||
       (attr[1][:unless] && respond_to?(attr[1][:unless]) && self.public_send(attr[1][:unless])))
      return false
    end
    # if (attr[1][0] && self.public_send(attr[1][0])) || !attr[1][0]
      return false if method_check.nil? || method_check.to_s.empty?  
    # end
    true
  end

  private def check_format?(attr)
    return false unless attr[1][0].match(self.public_send(attr[0]))
    true
  end

  def save
    if respond_to?("validate") && validate && check_validations[0]
      self.class.my_objects << self
      true
    else
      self.class.error_logs[self] << "Could not be saved: The validate method does not exists"  unless respond_to?("validate")
      self.class.error_logs[self] << "Could not be saved: The validate method returned false"  unless respond_to?("validate") && validate
      self.class.error_logs[self] << "#{check_validations[1]} is empty/invalid" unless check_validations[0]
    end
  end
end

class Play
  include MyObjectStore

  attr_accessor :age, :fname, :email, :age

  validate_presence_of :fname, :email, if: :some_method
  validate_format_of :email, format: /^[\S]+@[\S]+$/#/^[\s]+@[\s]+\.[\.\s]+$/
  validate_presence_of :age

  def validate
    # ....
    true
  end

  def some_method
    true
  end
end

p2 = Play.new;
p2.fname = "abc" ; 
p2.email = "def@gmail.com" ; 
p2.age = 24
p2.save ; 
# p1 = Play.new
# p1.save

Play.find_by_fname("abc") ; 
Play.find_by_email("abcd") ; 
p Play.collect ; 
Play.count
Play.validator