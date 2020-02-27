require 'CSV'

class String
  def singularize!
    chop! if self[-1] == 's'
    self
  end
end

class CsvReader
  def initialize(filename)
    @filename = filename
    @absolute_filepath = find_filepath
  end

  def parse_csv # make a different method of get_absolute_path
    CSV.read(@absolute_filepath + '/' + @filename, headers: true)
  end
  
  private

  def find_filepath
    file_path = File.expand_path(File.dirname(__FILE__))
  end

  # def create_dynamic_class
  #   class_name = filename_get
  #   DynamicClass.new(class_name, @input_file)  # should be present in dynamic class
  # end
end

class DynamicClass # should be dynamic class
  attr_accessor :dynamic_class_name, :input_file, :dynamic_class, :csv_objects
# make one method as "process" which includes create_class, create_object, create_methods
  def initialize(file_name)
    @file_name = file_name
    @dynamic_class_name = get_classname
    @input_file = CsvReader.new(file_name).parse_csv
    @csv_objects = [] # csv_objects
  end

  def process
    create_class
    create_object
  end

  private

  def get_classname # name should be class_name
    @file_name.chomp('.csv').capitalize.singularize!  # present in dynamic_class
  end

  def create_class # create_class
    @dynamic_class = Object.const_set(dynamic_class_name, Class.new)
  end

  def create_object # create_object
    input_file.each do |row|
      @dynamic_class_obj = @dynamic_class.new
      create_methods(row)
      @csv_objects << @dynamic_class_obj
    end
  end

  def create_methods(row) #create_methods
    row.to_h.each do |key, value|
      dynamic_class.define_method(key) do
        instance_variable_get("@#{key}")
      end
      @dynamic_class_obj.instance_variable_set("@#{key}", value)
    end
  end
end

if ARGV.empty?
  puts 'Please enter the filename'
else
  DynamicClass.new(ARGV[0]).process
end

























































# require 'CSV'

# class String
#   def singularize!
#     chop! if self[-1] == 's'
#     self
#   end
# end

# class CsvReader
#   def initialize(filename)
#     # get_file_nam
#     # parse_csv
#     @filename = filename
#     # read from anywhere
#     @input_file = parse_csv(filename)
#     # get_filename(filename)
#   end

#   def get_filename
#     @filename.chomp('.csv').capitalize.singularize!
#   end

#   def parse_csv(filename)
#     file_path = File.expand_path(File.dirname(__FILE__))
#     input_file = CSV.read(file_path + '/' + filename, headers: true)
#     # read from anywhere
#   end

#   def create_dynamic_class
#     class_name = get_filename
#     DynamicClassCreator.new(class_name, @input_file)
#   end
# end

# class DynamicClassCreator
#   attr_accessor :dynamic_class_name, :input_file, :dynamic_class

#   def initialize(dynamic_class_name, input_file)
#     @dynamic_class_name = dynamic_class_name
#     @input_file = input_file
#     @file_row = []
#     add_class
#     add_methods
#   end

#   private

#   def add_class
#     @dynamic_class = Object.const_set(dynamic_class_name, Class.new)
#   end

#   def add_methods
#     input_file.each do |row|
#       @dynamic_class_obj  = @dynamic_class.new
#       save_row_data(row)
#       @file_row << @dynamic_class_obj
#       p @file_row[0].name
#     end
#   end

#   def save_row_data(row)
#     row.to_h.each do |key, value|
#       # binding.eval("class #{class_name}; def #{key}; p @value; end; end")
#       # @class.class_eval("instance_variable_set('@#{key}', '#{value}')")
#       # @class.class_eval("define_method('#{key}=') { |val| instance_variable_set('@#{key}', val) }")
#       # dynamic_class.define_method("#{key}=") do |value|
#       #   instance_variable_set("@#{key}", value)
#       # end
#       dynamic_class.define_method("#{key}") do
#         instance_variable_get("@#{key}")
#       end
#       # @class.new.instance_eval("instance_variable_get('@#{key}')")
#       # p key
#       # @class.class_eval("define_method('#{key}') { instance_variable_get('@#{key}') }")

#       # dynamic_class_obj.public_send("#{key}=", value)
#       @dynamic_class_obj.instance_variable_set("@#{key}", value)
#       # obj.name = value
#       # p obj.name
#       end
#     end
# end

# if ARGV.empty?
#   puts 'Please enter the filename'
# else
#   csv_reader = CsvReader.new(ARGV[0]).create_dynamic_class
# end

# # make two classes one to read csv other to make objects
# # each object of array should have been called like arr[0].name
# # name of arr