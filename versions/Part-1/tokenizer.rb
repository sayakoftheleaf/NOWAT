# Takes a character return and returns an AST
class Tokenizer
  def initialize(stream)
    @string_stream = stream
    @ast = {}
  end

  def lexer
    function_body = get_function_body(@string_stream)
    extract_number(function_body)
  end

  def get_function_body(portion_of_code)
    pos = 0
    function_body = ''
    while pos < portion_of_code.length
      character = portion_of_code[pos]
      pos += 1
      if character == '{'
        flag = true
      elsif flag == true
        if character == '}'
          return function_body # return when end of function is reached
        end
        function_body += character
      end
    end
  end

  def extract_number(function_body)
    words = function_body.split(' ')
    return_index = words.find_index('return')
    return_number = ''
    loop do
      return_number = words[return_index + 1]
      return_index += 1
      break if return_number != 0
    end
    return_number.to_i
  end

  # def parser
  # end
end
