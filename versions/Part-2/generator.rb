# generates a Brainfuck program from a symbol table
class Generator
  def initialize(symbol_table)
    @symbol_table = symbol_table
  end

  # generates the BrainFuck equivalent of that number
  def generate_number(some_num)
    return_expression = ''
    some_num.times do
      return_expression += '+'
    end
    return_expression
  end

  # takes the current number and returns the BrainFuck
  # equivalent of transforming it into the desired number
  def transform_number(current, desired)
    return_expression = ''
    if (current < desired)
      (desired - current).times { return_expression += '+' }
    elsif (current > desired)
      (current - desired).times { return_expression += '-'}
    end
  end

  def generate_code
    output_code = '' 
    @symbol_table.each do |key, value|
      output_code += generate_number(value)
    end
    output_code
  end
end 
