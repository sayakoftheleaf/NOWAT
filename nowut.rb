require_relative 'generator'
require_relative 'tokenizer'

# Main class that compiles the C source code
# into the BrainFuck code
class Nowut

  def initialize(filepath, bf_filename)
    @source_code = File.read(filepath)
    @bf_filename = bf_filename
  end

  def compile
    my_tokenizer = Tokenizer.new(@source_code)
    tokens = my_tokenizer.lexer
    puts tokens

    # my_generator = Generator.new(:number => c_number)

    # write_code(my_generator.generate_code)
  end

  def write_code(code)
    File.write('./' + @bf_filename + '.bfck', code)
  end
end

run_this = Nowut.new(ARGV[0], ARGV[1])
run_this.compile
 
