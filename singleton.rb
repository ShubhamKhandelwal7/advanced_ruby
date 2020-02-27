# class Singleton
#   def initialize  
@string_instance = String.new
@other_instance = String.new
  # end

class << @string_instance
  def singleton_meth
    puts 'Singleton method of instance of class string'
  end
end

def @string_instance.singleton_meth2
  puts 'Singleton method 2 of instance of class string'
end
  
@string_instance.singleton_meth
@string_instance.singleton_meth2
@other_instance.singleton_meth
# end

# obj = Singleton.new



