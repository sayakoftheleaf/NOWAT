# rubocop: disable Metrics/LineLength, Style/RedundantReturn
# rubocop: disable Metrics/CyclomaticComplexity, Metrics/AbcSize

# #####################################################################
#                               LEXER
#
#                  Takes source code and transforms
#                  it into a hash table of tokens.
#
# #####################################################################
class Lexer
  def initialize(stream)
    @string_stream = stream
  end

  def lexer
    token_list = []
    lexer_pos = 0

    while lexer_pos < @string_stream.length
      current_word, lexer_pos = find_next_token(lexer_pos)
      token_list.push(current_word) if lexer_pos < @string_stream.length
    end

    return token_list 
  end

  def find_next_token(lexer_pos)
    # ignore whitespace preceding next token
    lexer_pos += 1 while @string_stream[lexer_pos] =~ /\s/

    # guards against computing beyond EOF
    return [{}, lexer_pos] unless lexer_pos < @string_stream.length

    character = @string_stream[lexer_pos]

    # any letter followed by 0 or more letters/digits
    return tokenize_word(lexer_pos, "[a-zA-Z]\w*", :cword) if character =~ /[a-zA-Z]\w*/

    # integer numbers / shorts / longs
    return tokenize_word(lexer_pos, "[0-9]\d*", :cint) if character =~ /[0-9]\d*/

    # special strings
    return [{ value: character, ctype: :csymbol }, (lexer_pos + 1)] if character =~ /[{}();]/

    return tokenize_string(lexer_pos + 1) if character =~ /"/

    # TODO: parse chars
    # TODO: parse C strings
  end

  # tokenize words based on given regex
  # (can handle names, integers)
  def tokenize_word(lexer_pos, regex, ctype)
    current_word = ''
    loop do
      character = @string_stream[lexer_pos]
      break unless character =~ /#{regex}/

      current_word += character
      lexer_pos += 1
    end

    # special case for pointers
    # TODO: handle multiple pointers
    return [{ value: current_word, ctype: :cpointer }, lexer_pos + 1] if @string_stream[lexer_pos] == '*'

    # TODO: differentiate between names and keywords
    return [{ value: current_word, ctype: ctype }, lexer_pos]
  end

  def tokenize_string(lexer_pos)
    current_word = ''
    loop do
      character = @string_stream[lexer_pos]

      # This increment needs to be before break because this
      # method deals with the ending " character too
      # The next token needs to start from the char after that
      # Otherwise, this function will be called again
      lexer_pos += 1

      break if character =~ /"/

      current_word += character
    end

    return [{ value: current_word, ctype: :cstring }, lexer_pos]
  end

end
