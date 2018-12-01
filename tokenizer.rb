# Takes a character return and returns an AST
class Tokenizer
  def initialize(stream)
    @string_stream = stream
    @ast = {}
    @symbol_tokens = /{}\(\);/ # these are simple defined symbols
  end

  def lexer
    token_list = []
    lexer_pos = 0

    while lexer_pos < @string_stream.length
      puts token_list
      current_word, lexer_pos = next_token(lexer_pos)
      puts 'lexer pos is ' + lexer_pos.to_s
      puts 'current word is' + current_word
      puts
      token_list.push(current_word)
    end

    token_list # return
  end

  # find the next token in the stream
  def next_token(lexer_pos)
    # ignore whitespace preceding next token
    lexer_pos += 1 while @string_stream[lexer_pos] =~ /\s/

    puts 'escaped whitespace'
    character = @string_stream[lexer_pos]

    # any letter followed 0 or more letters/digits
    if character =~ /[a-zA-Z]\w*/
      current_word, lexer_pos = parse_word(lexer_pos)
      puts 'returning from word is ' + current_word.to_s + ' ' + lexer_pos.to_s
      return current_word, lexer_pos
    end

    # numbers
    return parse_number(lexer_pos) if character =~ /[0-9]\d*/

    return character, lexer_pos + 1 if character =~ @symbol_tokens

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

    puts 'word is' + current_word
    return current_word, lexer_pos # return
  end

  def parse_number(lexer_pos)
    number = ''
    loop do
      break unless @string_stream[lexer_pos] =~ /[0-9]/

      number += @string_stream[lexer_pos]
      lexer_pos += 1
    end

    return number, lexer_pos # return
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
