
class Interactive
  def begin_prog(binding)
    input, arr = '', []
    # arr = []
    # p input.empty?
    puts "Please provide input to execute: "
    while input != 'q'
      input = gets.strip
      # puts "input: #{input}"
      # arr << input
      # puts "arr: #{arr}"
      # p input.empty?
      # p input != 'q'
      if input.empty?
        binding.eval(arr.join(';'))
        arr = []
      else
        arr << input
      end
    end
    # p arr.join(';')
    # binding.eval(arr.join(';')) if input.empty?
  end
end

interact = Interactive.new
interact.begin_prog(TOPLEVEL_BINDING)