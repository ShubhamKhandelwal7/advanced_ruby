module MyModule
  REGEX_SPECIAL_CHAR = /(?<k>[\?\=\!])$/
  
  def self.included(base)
    base.extend MyModule
  end

  def chained_aliasing(target_meth, alias_val)
    create_aliasing_methods(target_meth, alias_val)
    alias_methods(target_meth)
    check_access_specifier(target_meth)
  end
  
  def create_aliasing_methods(target_meth, alias_val)
    target_meth_without_schar = target_meth.to_s.gsub(REGEX_SPECIAL_CHAR, '')
    special_char = target_meth.to_s.match(REGEX_SPECIAL_CHAR)
    special_char = '' if special_char && alias_val[-1] == special_char[1]
    @with_method = "#{target_meth_without_schar}_with_#{alias_val}#{special_char}"
    @without_method = "#{target_meth_without_schar}_without_#{alias_val}#{special_char}"
  end

  def alias_methods(target_meth)
    alias_method @without_method, target_meth
    alias_method target_meth, @with_method
  end

  def check_access_specifier(target_meth)
    if protected_method_defined?(target_meth)
      protected @with_method
      protected @without_method
    elsif private_method_defined?(target_meth)
      private @with_method
      private @without_method
    else
      public @with_method
      public @without_method
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
# ------Output-------
# --logging start
# hello
# --logging end
say.greet
# ------Output-------
# --logging start
# hello
# --logging end

p '-------------------------------------'

say.a_with_b?
# ------Output-------
# --logging start
# Inside a? method
# --logging end
say.a_without_b?
# ------Output-------
# Inside a? method
say.a?
# ------Output-------
# --logging start
# Inside a? method
# --logging end

p '-------------------------------------'

say.c_with_d?
# ------Output-------
# --logging start
# Inside c method
# --logging end
say.c_without_d?
# ------Output-------
# Inside c method
say.c
# ------Output-------
# --logging start
# Inside c method
# --logging end

p '-------------------------------------'

say.e_with_f?
# ------Output-------
# --logging start
# Inside e? method
# --logging end
say.e_without_f?
# ------Output-------
# Inside e? method
say.e?
# ------Output-------
# --logging start
# Inside e? method
# --logging end