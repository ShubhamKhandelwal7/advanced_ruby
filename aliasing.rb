REGEX_SPECIAL_CHAR = /(?<k>[\?\=\!])$/
module MyModule
  def self.extended(base)
    define_method('chained_aliasing') do |target_meth, alias_val|
      create_aliasing_methods(target_meth, alias_val)
      alias_methods(target_meth)
      check_access_specifier(target_meth)
    end
  end
  
  def create_aliasing_methods(target_meth, alias_val)
    target_meth_without_schar = target_meth.to_s.gsub(REGEX_SPECIAL_CHAR, '')
    special_char = $1
    special_char = '' if alias_val[-1] == special_char
    @with_method = "#{target_meth_without_schar}_with_#{alias_val}#{special_char}"
    @without_method = "#{target_meth_without_schar}_without_#{alias_val}#{special_char}"
  end

  def alias_methods(target_meth)
    class_eval("alias #{@without_method} #{target_meth}")
    class_eval("alias #{target_meth} #{@with_method}")
  end

  def check_access_specifier(target_meth)
    if protected_method_defined?(target_meth)
      protected @with_method
      protected @without_method
    elsif private_method_defined?(target_meth)
      private @with_method
      private @without_method
    end
  end
end

class Hello
  extend MyModule

  def greet
    puts 'hello'
  end

  def greet_with_logger
    puts '--logging start'
    greet_without_logger
    puts '--logging end'
  end

  def a?
    puts 'Inside a? method'
  end

  def a_with_b?
    puts '--logging start'
    a_without_b?
    puts '--logging end'
  end

  def c
    puts 'Inside c method'
  end

  def c_with_d?
    puts '--logging start'
    c_without_d?
    puts '--logging end'
  end

  def e?
    puts 'Inside e? method'
  end

  def e_with_f?
    puts '--logging start'
    e_without_f?
    puts '--logging end'
  end

  chained_aliasing :greet, :logger
  chained_aliasing :a?, :b
  chained_aliasing :c, :d?
  chained_aliasing :e?, :f?
end

say = Hello.new

say.greet_with_logger
say.greet

p '-------------------------------------'

say.a_with_b?
say.a_without_b?
say.a?

p '-------------------------------------'

say.c_with_d?
say.c_without_d?
say.c

p '-------------------------------------'

say.e_with_f?
say.e_without_f?
say.e?