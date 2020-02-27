# $glo = 90
# module Album
#   @album_count = 5                                                            # youll get class_var in class also from module but not class instance var
#   @@cls_var = 88
#   p "#{self} at class-level"

#   def initialize
#     # @album_count += 1
#     @pete = 33
#     p "#{self} at init"
#   end

#   def count
#     @pete = 33
#     p "#{self} at class-method"
#     p @@cls_var
#     p @album_count
#   end

#   def meth
#     p @@cls_var
#     # p @album_count
#     p "#{self} at inst_meth"
#   end
  
# end

# class Abc
#   @@class_var = 99
#   @malibu = 5
#   extend Album
#   def self.metho
#     p @@cls_var
#     p @malibu
#   end
#   def meth
#     p @@class_var
#     p @malibu
#   end
# end

# # p Album.count
#  Abc.new.meth
# p $glo
# instance_variable - 
# declared in 











# class A
#   @class_inst_var = 44
#   def initialize
#     @instance_meth = 88
#   end

#   class << self
#     p 'das'
#     attr_accessor :class_inst_var, :instance_meth                                                      #attr_accessor under singleton class are created for class methods
#   end
# end
# # p A.new
# p A.class_inst_var




# module M
#   @cv = 88
#   def boomer
#     p 'boomer'
#   end
#   class Mclass
#     extend M                                                                              #class can extend/include its own module where its present
#   # p self
#   def meth
#     p self                                                                           # self inside class inside module is Module::Class
#   end
#   end
# end

# class Bmc
#   include M
#   def self.bsa
#     p @cv
#   end
# end

# Bmc.bsa

# # obj = M::Mclass.new.meth
# p Bmc::Mclass.boomer


# require 'thread'
# # puts “ProAndCon”
  
# queue = Queue.new
# #  – use queue to synchronize threads
  
# producer = Thread.new do
#     10.times do |i| 
#       sleep rand(i) 
# # allows a thread to sleep for a period of time
#         queue << i 
#         puts "#{i} produced"
#     end
# end
  
# consumer = Thread.new do
#     10.times do |i| 
#         value = queue.pop 
#         sleep rand(i/2) 
#         puts "consumed #{value}"
#     end
# end

# consumer.join



class Foo
  # pts 'das'
  attr_accessor :kaka
  def initialize
    @kaka = 'forward'
  end
  alias pts puts
  # pts 'after'
  def self.meth
    pts 'heu'
  end
end

class Boo < Foo                                                      #in both alias/alias_meth teh access specifier of source iscarreid to target
  def meth2                                                     #if target is instance, innst is created
    show                        
    pts 'pts in boo'
  end
  def meth
    pts 'heu'
  end
  alias_method :show, :meth
end
class << Foo
attr_accessor :kaka
end

Boo.new.meth2
p self.private_methods('print')
p Foo.kaka
# # system('cls')
# # p system("ls")
# p __FILE__


# PROC and LAMBDA examples

# def multiplier(x)
#   yield(10).map { |c| c*x}
#   # pro.call(3)
# end

# # lm = -> (z) {arr = []; z.times {|i| arr<< i; i+=1}; arr}
# # pr = Proc.new {p 'kkooll'}
# # lm.call(3)
# # pr.call
# p multiplier(3) {|z| arr = []; z.times {|i| arr<< i; i+=1}; arr}


# ------------anonymous-class-------------------------------------------------------------------



# anon_class = Class.new
#   # p anon_class
#  Object.const_set('Kla', anon_class)
#  p  anon_class
#  def anon_class.meth
#   p 'das', self
#  end
# # end
#   p Kla.meth

# person = Class.new do
#   def meth
#     'das'
#   end
# end
# # Person = person
# Object.const_set('Person', person)
# person = 1
# # p person.object_id === Person.object_id

# p person.object_id == Person.object_id

# -------------------------Delegation---------------------------------------------------------------------------

# class A
#   def initialize
#     @b_obj = B.new
#   end
#   def meth1
#     @b_obj.meth1
#   end
# end

# class B
#   def meth1
#     p "meth1 of B having self: #{self}"
#   end
# end

# A.new.meth1

# ---------------------removing-method---------------------------------------------------------------------------
# class Abc
#   def self.meth1
#     p 'meth1 of Abc class'
#   end
# end

# class Z < Abc
#   def self.meth2
#     p 'meth2 of Z class'
#   end
#   # class << self    
#   # remove_method :meth2 #removes method from current class if present
#   undef_method :meth1  #removes method from heirarchy if not present in curr class
#   # end
# end

# Z.meth1

# -----------------------------module-calls-using-hooks-----------------------------------------------------------

# module M1
#   def self.included(base)
#     class << base
#       define_method('included') do |base_class|
#         base_class.extend(M1)
#         p self
#         base_class.extend(self::M3)
#       end
#     end
#   end

#   def meth1
#     p 'meth1 of module M1'
#   end
#   def class_meth1
#     p 'class meth1 of module M1'
#   end
# end

# module M2
#   include M1
  
#   Konst = 99
#   def meth2
#     p 'meth2 of module M2'
#   end
#   def self.class_meth2
#     p 'class meth2 of module M2'
#   end

#   module M3
#     def meth3
#       p 'meth3 of module M3'
#     end
#   end
# end

# class Abc
#   include M2
# end

# Abc.meth1
# Abc.new.class_meth1
# Abc.meth3

# M2.class_meth2


# -----------------------------------------------------------------------------------------------------


# confusing = "This Is Confusing"
# confusing.concat('baua')
# num3 = 3
# num3.instance_eval do
#   def lowercase
#     self
#   end
# end   


# singleton class objects == class objects
# class C
#   class << self
#     self.instance_eval{
#       def m
#         p self
#       end
#     }
#   end
# end

# # class << C
# C.singleton_class.m
# m
# end



# class C
#   p self
#   class << self
#     p self ==C.singleton_class
#     nam = 'kam'
#     define_method(:m){
#       p self, nam
#     }
#   end
# end
# C.m


# class C
# class << self
#   p self
#   def m
#     p self
#     def self.meth1
#       p "meth1 called self: #{self}"
#     end
#     define_method(:me) {
#       p 'me called'
#     }
#     # p self
#   end
# end
# end

# # C.m
# # C.new.me
# # C.m
# C.singleton_class.meth1
# C.me

# class C
#   class << self
#     def self.m
#       p self
#       def self.meth2
#         p self
#       instance_eval{    # default self is present
#         def meth4 ; p self; end
#         instance_eval {
#           def meth5 ; p self; end 
#         }
#       define_method(:b) {  # you have to take care of self (default self is present)
#         p self
#       }}
#       end
#     end
#     self.define_method(:per) {
#       p self
#       define_singleton_method(:rem) {
#         p "in defined singleton : #{self}"
#       }
#     }
#     self.class_eval{
#         def meth3
#           puts self
#         end
#       }
#       self.instance_eval{   #instance_eval creates class methods/ class_eval creates instance methods
#       def meth1
#         p self
#       end
#     }
#   end
# end

# C.singleton_class.m      
# C.singleton_class.meth2
# C.singleton_class.meth5
# C.meth3
# C.singleton_class.meth1
# C.singleton_class.meth4
# C.b
# C.per
# C.rem


# class Z
#   def meth1   
#     p 'meth1'
#     def meth2
#       p 'meth2'
#     end
#   end
# end
# Z.new.meth1
# Z.new.meth2










class C
p self
def self.method_added(name)
  p "#{name} is added"
end
def self.meth2
  p 'meth2 called'
  def meth3
    p 'meth3 called'
  end
end
end
C.meth2
C.new.meth3
# C.new.meth4

