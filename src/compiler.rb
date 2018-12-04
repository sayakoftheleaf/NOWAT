require_relative 'generator'
require_relative 'lexer'

# Main class that compiles the C source code
# into the BrainFuck code
class Compiler 

  def initialize(filepath, compiled_filename)
    @source_code = File.read(filepath)
    @compiled_filename = compiled_filename
  end

  def compile
    my_tokenizer = Lexer.new(@source_code)
    tokens = my_tokenizer.lexer

    puts tokens
   # write_code(my_generator.generate_code)
  end

  def write_code(code)
      File.write('./../Compiled' + @compiled_filename + '.bfck', code)
  end
end

