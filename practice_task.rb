# def infinite_series
#   range = (1..Float::INFINITY)
#   enum = range.each.lazy
#   yield(enum)
# end

#   infinite_series {|y| puts y.next}


# int_range = (1..Float::INFINITY)
# char_range = ('A'..'Z')
# a = int_range.each.lazy do |int_yield|
# e = char_range.each.lazy do |yielder|
#   yield(yielder + int_yield)
# end
# int_yield.next
# end


# def method_name
#   begin
#     p "method"
#     raise ArgumentError, "arg error"
#     raise NoMethodError, "No meth"
    
#   rescue StandardError => e
#     p e.message
#   end
  
# end

# method_name





































# def infinite_series(start_num = 1, upto)
#   # characters = Enumerator.new(start_char..'Z')
#   # number = (start_num..Float::INFINITY).lazy.each
#   # yield number
#   e = (start_num..Float::INFINITY).lazy do |y|
#     yield(e.next)
#   end
  
#   # upto.times { yield number.next}
#   # yield(characters.next, numbers.next)
#   # yield(characters.next, numbers.next)
#   # (start_char..'Z').each do |char|
#   #   (start_num..Float::INFINITY).lazy.each do |num|
#   #     yield(char.next,num.next)
#   #     break if num == 50
#   #   end
#   # end
# end

# infinite_series( 0, 50) {|num| print num}







# class Convertor
#   attr_accessor :newarr, :arr
#   def initialize
#     # cube_each(newarr)
#   end

#   def square_each(arr)
#     arr.each_with_object({}) do |element, acc|
#       acc[element] = "The square of #{element} is #{element.to_i**2}"
#       acc
#     end
#       # acc[element] << "The square of #{element} is #{element.to_i**2}"
    
#     # @arr = arr.drop(arr.length-1)
#     # p arr[0]
#     # p newarr
#   end

#   def cube_each(arr)
#     square_each(arr).inject(square_each(arr)) do |acc, (key, val)|
#       acc[key]= "The cube of #{key} is #{key.**3}"
#       acc
#     end
#   end
# end

#  convertor = Convertor.new
# p convertor.cube_each([1,2,3,4])
#  p convertor.cube_each

  

# class C
#   def meth
#     @a = 9
#     binding
#   end
# end
# c= C.new
# c.meth.eval("@a+=1")
# p c



# def meth
#   string_ip = "he gave 15 dollars to by a gift of worth 15 dollars"
#   string_ip.gsub!(/(\d+)\sdollars/, '$\1')
#   # md = string_ip.match(/([\d]+)\sdollars/)
#   # string_ip.gsub!(/[\d]+\sdollars/, "$#{md[1]}")
#   p string_ip
# end

# meth


# A[:x] => nil
# A[:x] = 6
# A[:x] => 6


# class A
#   @@hash = Hash.new
#   def self.[]=(x, y)
#     @@hash[x] = y
#   end

#   def self.[](x)
#     @@hash[x]
#   end
# end

#  A['x'] = 6
#  p A['x']
#  p A[:y]

#  class A=9


# def meth
#   arr = ARGV[0].split(',').map(&:to_i)
#     newarr = arr.inject({}) do |acc, curr|
#      acc[curr] = curr**2
#      acc
#    end
#    p newarr
# end

# meth

















# struct_obj = Struct.new :name, :age, :gender, :address do
#   def initialize(*args)
#     # self.name = name
#     # self.age = age
#     # self.gender = gender
#     super
#     self.address = "new delhi"
#   end
# end
# details = struct_obj.new(0,0)
# p details
# p details
# require 'ostruct'
# open_struct = OpenStruct.new(name: "", age: 0, gender: "")
# p open_struct



# def multiplier(value)
#  p yield.collect {|h| h*value}
# end
# multiplier(3){[1,2,3]}

















# def infinite_series(start_num = 1, upto)
#   characters = Enumerator.new(start_char..'Z')
#   number = (start_num..Float::INFINITY).lazy.each
#   yield number
#   e = (start_num..Float::INFINITY).lazy do |y|
#     yield(e.next)
#   end

# character_series = ('A'..'Z')
#   e = character_series.lazy.each do |yielder|
#     number_series = (1..99)
#     yielder.yield()
#   end
  # character_series.next

  # e = Enumerator.new do |yielder|
  #   ('A'..'Z').each do |char|
  #     (1..99).each do |num|
  #        yielder.yield("#{char}#{num} ")
  #        num.next
  #     end
  #     char.next
  #   end
  # end

  # # 199.times { print e.next}


#   def multiplier(value)
#     p yield(10).collect {|x| x*value}
#   end

#   # multiplier(3) {|c| arr = []; [1,2,3,4, c]}
# multiplier(3) {|c| arr = []; c.times{|i| arr<<i+=1}; arr;}

# class Animal
#   @@sound = ""
# end

# class Dog < Animal
#   @@sound = "Bark"

#   def its_voice
#     @@sound
#   end
# end

# class Cat < Animal
#   @@sound = "Meow"

#   def its_voice
#     @@sound
#   end
# end

# p Dog.new.its_voice
# p Cat.new.its_voice


# class Animal
#   @sound = ""
# end

# class Dog < Animal
#   @sound = "Bark"

#   def self.its_voice
#     @sound
#   end
# end

# class Cat < Animal
#   @sound = "Meow"

#   def self.its_voice
#     @sound
#   end
# end

# p Dog.its_voice
# p Cat.its_voice


# def count_with_increment(start, inc)
#   start -= inc
#   pr = Proc.new {start+= inc}
# end

# counter = count_with_increment(10, 3)
# p counter.call
# p counter.call

# module Attr_extended
#   def my_attr_accessor(name)
#     ivar_name = "@#{name}"
#     define_method(name) do
#       instance_variable_get(ivar_name)
#     end
#     define_method("#{name}=") do |var|
#       instance_variable_set(ivar_name, var)
#       puts "name = #{name} and value = #{var}"
#     end
#   end
# end
# class Example
#   extend Attr_extended
#   my_attr_accessor :var

# end

# e = Example.new
# e.var = 55
# puts e.var

# Fred = Struct.new(:name, :age)

# class Animal
#   def meth
#     @inst = 'var'
#     vtp =5
#     binding
#   end
# end

# p Animal.new.meth.eval("instance_variable_get('@inst')")



# class A
#   @children = []
#   @@chi = 99
#   def self.inherited(child_class)
#     p "#{self} wass inherited by #{child_class}"
#     @children << child_class
#   end
#   def self.all_inherited
#     p @children
#   end

#   def meth
#     # p @children
#     # p @@chi
#   end
# end

# class B < A
# end
# class C < A
# end
# A.all_inherited
# A.new.meth


# class Struct
#   @children = []
#   class << self
#     attr_accessor :children
#   def inherited(klass)
#     @children << klass
#   end
# end
# end

# Fred = Struct.new(:val1, :val2)
# Bret = Struct.new(:val3)

# p Struct.children

# class Module
#   def self.const_missing(name)
#     p "Missing #{name}"
#   end
#   FAs
# end

# Object.const_get('FAs')



# class Person
#   class << self
#     attr_accessor :hair_colors
#   end
# end

# Person.hair_colors = [:brown, :black, :blonde, :red]
# p Person.hair_colors 
# ------------------------------------------------------------
# module A
#   C1 = 5
#   def display
#     p C1
#   end
#   module B
#     C1 = 10
#     def display
#       p C1
#     end
#   end
# end
# # p A::B::C1

# class Abc
#   # prepend A
#   # prepend A::B
#   C1 = 15
#   def display
#     p C1
#   end
# end
# # p Abc::B::C1
# Abc.new.display

# # # ---------------------------------------------------------------------

# class C
# end

# module M
#   refine C do # other way to define refinement
#     def meth
#       p "Its meth method"
#     end
#   end
# end
# using M
# def call_meth(obj)
#   obj.meth
# end

# # C.new.meth
# using M

# C.new.meth
# call_meth(C.new)

# ---------------------------------------------------------------------------------------------

# class A   #if this class is module, then we can bind method with class B object 
#   def self.test_bind
#     puts "Shubham"
#   end
# end

# class B
# end

# um = A.instance_method('test_bind')
# um.bind(A.new).call
# # um.call

# um = B.method(:new)
# um.unbind
# um.bind()

# class A
#   X = 9
#   def meth1
#     m = 8
#   end
# end

# class A
#   z = 7

#   def meth1
#     # p 
#     p m
#   end
# end

# A.new.meth1

# module Batting
#   def hit_six
#     p 'SIX'
#   end
# end

# module Bowling
#   def self.included(klass)
#     bat = ''
#     klass.class_eval() { include Batting }
#     Batting.module_eval() { def met; p "inside met"; end }
#   end
#   def yorker
#     p "Yorker"
#   end
# end

# class Cricket
#   include Bowling
# end
# Cricket.new.hit_six
# Cricket.new.yorker
# Cricket.new.met


# var = 'meth'

# # Cricket.class_eval("def #{var};p 'inside method'; end")


# Cricket.class_eval("CONST = 7")
# p Cricket::CONST

# class Cricket
#   define_method var do
#     puts "inside method0"
#   end
# end

# Alls.class_eval() {}


# Observer
# Threads & Forks
# Benchmark
# Reflections & ObjectSpace


# threads---------------------------------------------------------------------

# Thread.abort_on_exception = true # does not gets killed on excep but raises it
# t1 = Thread.new do
#   10.times do |i|
#     if i < 5
#       p "#{i} t1 | #{t1.status}"
#       # raise "thread exception"
#       sleep 0.1
#       Thread.pass
#     else
#       Thread.exit # alias of kill
#     end
#   end
# end

# t2 = Thread.new do
#   10.times do |i|
#     p "#{i} t2"
#     sleep 0.1
#   end
# end

# t1.join # pauses execution of main thread and completes its exec

# t2.join

# Observable---------------------------------------------------------------------

# require 'Observer'

# include Observable
# has a subject whose value is to be observed obj.add_observer(obj)
# changed
# final_change
# notify_observers(params)
# checks for update method in obj for callback


# Benchmarking---------------------------------------------------------
# used to test efficiency 
# require 'benchmark'

# # input = (1..100).reduce(&:+)

# # puts Benchmark.measure {
# #   (1..10000000).reduce(&:+)
# # }
# Benchmark.bmbm do |bench|
#   bench.report("one_rep") do
#     (1..100_00000).reduce(&:+)
#   end

#   bench.report("two_rep") do 
#     (1..100_00000).reduce(&:+)
#   end
# end

# Comparable---------------------------------------------------------------

# exists in numeric and string class
# used to compare values by implementing <=>

# class Person
#   include Comparable
#   attr_accessor :name, :age
#   def initialize(name, age)
#     @name = name
#     @age = age
#   end

#   def <=>(obj)
#     @age<=>obj.age
#   end
# end

# person1 = Person.new('sam', 25)
# person2 = Person.new('tim', 28)
# person3 = Person.new('niel', 30)

# p person1 < person2
# p person2.between?(person1, person3)

# pers = []
# pers.push(person1, person2, person3)
# p pers.sort.reverse

# Reflections - to examine parts of program which we cannot access from where we stand
# p ObjectSpace.each_object(String).to_a
# String.methods
# 'str'.respond_to?('frozen?')
# 'str'.instance_of? String
# Class.instance_methods
# obj.send(meth, arg)
# Class.ancestors



#------------------------------------------------------------------



# module MyObjectStore
#   def self.included(base)
#     base.extend(SubModule)
#   end

#   module SubModule
#     def my_objects
#       @__my_objects ||= []
#     end

#     def attr_accessors
#       @attr_accessors ||= []
#     end

#     def attr_accessor(*attributes)
#       attr_accessors.concat(attributes)
#       super
#       attributes.each do |attr|
#         define_singleton_method("find_by_#{attr}") do |value|
#           my_objects.select do |obj|
#             obj.instance_variable_get("@#{attr}") == value
#           end
#         end
#       end 
#     end

#     def validate_presence_of(*validate_attr)
#       missing_attrs = validate_attr.select { |missing| !attr_accessors.include?(missing) }
#       raise "attribute #{missing_attrs} not present here" if !missing_attrs.empty?
#       self.instance_variable_set("@validate_attr", validate_attr)
#       # p self.instance_variable_get("@validate_attr")
#     end


#     def count
#       my_objects.count
#     end
  
#     def collect
#       my_objects.to_enum
#     end
#   end

#   def save
#     # p self.instance_variable_get("@fname")
#     # self.check_presence_of
#     if check_presence_of
#       self.class.my_objects << self 
#       true
#     else 
#       false
#     end
#   end

#   def check_presence_of
#     if self.class.instance_variable_get("@validate_attr")
#       self.class.instance_variable_get("@validate_attr").each do |attr|
#         if self.instance_variable_get("@#{attr}").nil?
#           # raise "#{attr} is empty" 
#            return false
#         end
#       end
#     end
#     true
#   end
# end





# class Play
#   include MyObjectStore

#   attr_accessor :age, :fname, :email, :lname

#   validate_presence_of :fname, :email

#   def validate
#     true
#   end
# end

# p2 = Play.new
# p2.fname = "abc"
# p2.lname = "def"
# p2.email = "abc"
# x= p2.save
# p x
# p1 = Play.new
# p1.lname = "dedsaf"
# y=p1.save
# p y

# Play.find_by_fname("xyz")
# Play.find_by_email("abc")
# y=Play.collect
# p y
# x=Play.count
# p x

#------------------------------------------------------------------


# module M
#   def start_engine_exp
#     'method start'
#   end
#   def expensive_method
#     # 'expensive'
#     @@operate ||=start_engine_exp
#     p @@operate
#   end
# end

# class Vehicle
#   extend M
#   def self.start_engine_exp
#     'method start'
#   end

#   def self.expensive_method_call
#     # p 'expensive 2'
#     @@operate ||= start_engine_exp
#     p @@operate
#   end
#   def meth
#     self.class.expensive_method
#   end
#   class << self
#     @
# end

# class Animal
#   extend M
#   def move
#     p 'method move'
#   end
# end

# # Vehicle.expensive_method_call
# # Vehicle.expensive_method
# Vehicle.new.meth
# exp ||= Vehicle.expensive_method2


# class TestClass
# end

# module TestModule
#   def test_method
#     'test'
#   end
# end
# TestClass.class_eval { include TestModule }
# p TestClass.new.test_method


# module Mod
#   @@cls_var = 55

#   def self.meth
#     @@cls_var
#   end
# end
# # p Mod.meth

# class A
#   def meth
#   class << A
#     p self
#     #  self.inst_meth
#     def self.metho
#       'inside eigen'
#     end
#   end
#   p A.singleton_class.metho
# end
#   def inst_meth
#     p 'inst'
#   end
#   def self.metho
#     'inside A'
#   end
#   def self.metho
#     'inside As'
#   end
# end
#  A.new.meth

# p A.singleton_class.ancestors
# # p BasicObject.singleton_class
# #  pp A.ancestors
#  pp A.ancestors



# module M
#   @operate
#   def start_engine_exp
#     'method start'
#   end
#   def expensive_method
#     # 'expensive'
#     # p start_engine_exp
#     @operate ||= start_engine_exp
#     p @operate
#   end
# end

# class Vehicle
#   extend M
#   def self.start_engine_exp
#     'method start'
#   end
# end

# class Animal
#   extend M
#   def move
#     p 'method move'
#   end
# end

# # Vehicle.expensive_method_call
# Vehicle.expensive_method
# Animal.expensive_method
# # Vehicle.new.meth

# Delegation
# NetHTTP and NetSSh
# removing and undefining methods
# ENV and CLA
# number = 1

# def add_to(number)
#   number + 2
# end

# puts add_to(3)
# p number


# class Food
#   def create_alias
#     # alias print_on_screen puts
#     p 'create_alias clalled'
#   end
# end
# class Apple < Food
#   # self.new.create_alias
#   # print_on_screen 99

# end
# # Apple.new.
# # print_on_screen 88
# set_trace_func proc {|event, file, line, id, binding, classname|
#   p id if event == 'call'
# }
# Food.new.create_alia



# class Abc
#   # alias method1 'meth1'
  
#   def meth1
#     p 'meth1 called'
#   end
#   def self.create_alias
#     # alias method1 meth1
#     p 'create_alias'
#   end
# end
# abc = Abc.new
# # Abc.create_aliass
# # abc.method1
# p Abc.private_method_defined?('method1')
# Abc.new.send('meth1')


# v0 = 0
# SomeClass = Class.new do
#   v1 = 1
#   p local_variables

#   define_method(:some_method) do
#     v2 = 2
#     p v1
#     p local_variables
#   end

#   define_method(:other_method) do
#     p v0
#   end
#   def self.meth
#     # p v0
#   end
# end

# some_class = SomeClass.new
# some_class.some_method
# 
# some_class.other_method
# # some_class.meth
# p SomeClass.method_defined?('meth')



# module PracticeModule
#   def self.included(base)
#     base.extend(self)
#     def base.special_people(*args)
#       args.each do |name|
#         define_method("#{name}=") do |val|
#           # p self
#           self.instance_variable_set("@#{name}", val)
#           if !people_names.key?(name)
#             people_names[name][1] = instance_variable_get("@#{name}")
           
#           elsif val != people_names[name][1] && val != people_names[name][0]
#             people_names[name][1] = people_names[name][0]
#             people_names[name][0] = instance_variable_get("@#{name}")
#           end
#           p people_names
#         end
#       end
#       # args.each do |name|
#       #   people_names[name] = instance_variable_get("@#{name}")
#       #   # p people_names
#       # end
#     end
#   end

#   def people_names
#     @people_names ||= Hash.new { |hash, key| hash[key] = [nil,nil]}
#   end
# end

# class RandomClass
#   include PracticeModule
#   attr_accessor :mans, :pans
#   special_people :mans, :pans
# end

# ran = RandomClass.new
# ran.mans = 55
# ran.mans = 99

# ran.mans = 11
# ran.mans = 11
# p ran.mans
# p RandomClass.send("people_names")












# module Mod
#   def self.included(base)
#     base.extend(SubMod)
#   end

#   module SubMod
#     def attr_accessor(*args)
#       super
#       p args
#     end

#   end

# end


# class Abc
#   include Mod


#   attr_accessor :pal
#   # def self.attr_accessor(*args)
#   #   super
#   #   p 'inside class'
#   # end


# end
# abc = Abc.new
# abc.pal = 7
# p abc.pal
# Abc.find_by_name



# def increase_by
#   start = 0
#   lambda { start += 1 }
# end

# # increase = increase_by(3)
# start = 453534534 # won't affect anything
# # p increase.call # 3
# # p increase.call # 6
# obj = increase_by
# p obj.call
# p obj.call


# class Addition
#   attr_accessor :a
#   def add
#     @a = 7
#     binding
#     # TOPLEVEL_BINDING.eval("@a += 1")
#   end
# end

# k=Addition.new
# k.add.eval("@a += 1")

# p TOPLEVEL_BINDING.receiver # => main
# p k.a 


# class Z
#   def self.meth
#     p 'meth'
#   end
#   class << self
    
#     def metho
#       meth
#     end
#     p self.instance_methods(false)
#   end
# end
# Z.meth


# class Geeks 
   
#   # public method 
#   def method_1 
  
#       p "Public Method of class Geeks"
   
#   end
 
#   # defining the protected method 

#   # protected 
 
#   protected def method_2 
        
#       p "Protected Method of class Geeks"
#    end
 
#   # defining the private method    
#   # private 
 
#   private def method_3 
        
#       p "Private Method of class Geeks"
        
#    end
#    geek = Geeks.new
#   #  geek.method_2
# end
# class Beek < Geeks
#   def meth
#   beek = Beek.new
#   beek.method_3
#   end
# end
# Beek.new.meth


# class Point
#   include Comparable
#   attr_accessor :x, :y
  
#   def initialize(x, y)
#       @x = x
#       @y = y
#   end
  
#   def <=>(obj)
#       x <=> obj.x && y <=> obj.y
#   end
# end

# p1 = Point.new(2,3)
# p2 = Point.new(2,3)

# p p1 == p2  # should return true if x1 == x2 and y1 == y2
# p p1 > p2  # should return true if x1 > x2 and y1 > y2

class Point
  include Enumerable

  attr_accessor :x, :y

  @objects ||= []

  def initialize(x, y)
    p @objects
    @objects << self
      @x = x
      @y = y
  end

  def each(&block)
    @objects.each do |obj|
      block.call(obj)
    end
  end
end

p1 = Point.new(2,3)
p2 = Point.new(2,3)


# Point.each/collect
# Point.each {|point| p point.x}

p3 = Point.new(2,3)
p1.each {|point| p point}
p1.collect {|point| p point}
# p ObjectSpace.each_object(Point).to_a

# Point.collect {|point| p point.y}


# module A
#   module B
#     CONST = 88
#       module C
#           class D
#               def xyz
#                   p Module.nesting, CONST
#               end
#           end
#       end
#   end
# end


# module A::B::C
#   class D
#       def abc
#           2
#           p Module.nesting, CONST #CONST wont be accessible here as its looking as A::B::C::D::CONST
#           p A::B::CONST #accessible as it checks as per lexical scope and not by parent-child behaviour
#       end
#   end
# end


# A::B::C::D.new.xyz
# A::B::C::D.new.abc