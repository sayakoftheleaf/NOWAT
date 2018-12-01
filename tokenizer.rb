# Takes a character return and returns an AST
class Tokenizer
  def initialize(stream)
    @string_stream = stream
    @ast = {}
  end

  def lexer
    token_list = []
    lexer_pos = 0

    while lexer_pos < @string_stream.length
      # print token_list
      # puts
      current_word, lexer_pos = next_token(lexer_pos)
      token_list.push(current_word) if lexer_pos < @string_stream.length
    end

    token_list # return
  end

  # find the next token in the stream
  def next_token(lexer_pos)
    # ignore whitespace preceding next token
    lexer_pos += 1 while @string_stream[lexer_pos] =~ /\s/

    # guards against the cases where EOF is reached
    return 'dummy', lexer_pos unless lexer_pos < @string_stream.length

    character = @string_stream[lexer_pos]

    # any letter followed 0 or more letters/digits
    return parse_word(lexer_pos) if character =~ /[a-zA-Z]\w*/

    # numbers
    return parse_number(lexer_pos) if character =~ /[0-9]\d*/

    if character =~ /[{}();]/
      return {:value => character, :ctype => :csymbol}, (lexer_pos + 1)
    end

    # TODO: parse chars
    # TODO: parse C strings
  end

  def parse_word(lexer_pos)
    current_word = ''
    loop do
      character = @string_stream[lexer_pos]
      break unless character =~ /[a-zA-Z]\w*/

      current_word += character
      lexer_pos += 1
    end

    # TODO: differentiate between names and keywords
    return {:value => current_word, :ctype => :cword}, lexer_pos
  end

  def parse_number(lexer_pos)
    number = ''
    loop do
      break unless @string_stream[lexer_pos] =~ /[0-9]/

      number += @string_stream[lexer_pos]
      lexer_pos += 1
    end

    return {:value => number, :ctype => :cint}, lexer_pos # return
  end

  # def parse_string(pos)
  #   return_string = ''
  #   until @string_stream[pos] == '\"'
  #     return_string += @string_stream[pos]
  #     pos += 1
  #   end
  #   return_string # return
  # end

  # def parse_function
  # end

  # def get_function_body(portion_of_code)
  #   pos = 0
  #   function_body = ''
  #   while pos < portion_of_code.length
  #     character = portion_of_code[pos]
  #     pos += 1
  #     if character == '{'
  #       flag = true
  #     elsif flag == true
  #       if character == '}'
  #         return function_body # return when end of function is reached
  #       end
  #       function_body += character
  #     end
  #   end
  # end

end
