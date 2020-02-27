class Calculator
  attr_accessor :digit_one, :digit_two, :operator

  def initialize(arithmetic_val)
    @digit_one = arithmetic_val[0].to_i
    @digit_two = arithmetic_val[2].to_i
    @operator = arithmetic_val[1].tr(':','')
  end

  def calculate
    digit_one.send(operator, digit_two)
  end
end

if ARGV.empty?
  puts 'Please provide an input'
else
  calc = Calculator.new(ARGV[0].split(','))
  puts calc.calculate
end
