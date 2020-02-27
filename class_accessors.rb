module MacroAccessors
  def cattr_accessor(*attributes, **instance_state)
    raise ArgumentError, 'Invalid Instance state given.' unless passed_options_valid?(instance_state)
    define_class_accessors(attributes)
    define_instance_accessors(attributes, instance_state)
  end

private
  def define_class_accessors(attributes)
    attributes.each do |params|
      define_singleton_method(params) do
        class_variable_get("@@#{params}")
      end
      define_singleton_method("#{params}=") do |value|
        class_variable_set("@@#{params}", value)
      end
    end
  end

  def define_instance_accessors(attributes, instance_state)
    attributes.each do |params|
      if can_create_instance_reader?(instance_state)
        define_method(params) do
          self.class.class_variable_get("@@#{params}")
        end
      end
      if can_create_instance_writer?(instance_state)
        define_method("#{params}=") do |value|
          self.class.class_variable_set("@@#{params}", value)
        end
      end
    end
  end

  def can_create_instance_reader?(instance_state)
    instance_state[:instance_accessors] || instance_state[:instance_reader]
  end

  def can_create_instance_writer?(instance_state)
    instance_state[:instance_accessors] || instance_state[:instance_writer]
  end

  def passed_options_valid?(instance_state)
    !(instance_state.key?(:instance_accessors) &&
       (instance_state.key?(:instance_writer) ||
       instance_state.key?(:instance_reader)))
  end
end

class Person
  extend MacroAccessors
  cattr_accessor :hair_colors, :height, instance_accessors: true
end

Person.hair_colors = [:brown, :black, :blonde, :red]
p Person.hair_colors

per = Person.new
per.hair_colors = [:brown, :black, :blonde]
p per.hair_colors

class Male < Person
end

Male.hair_colors << :blue
p Person.hair_colors
Person.define_instance_accessors
