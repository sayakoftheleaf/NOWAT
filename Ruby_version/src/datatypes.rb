class Datatypes
  def initialize
    @datatype_symbols = define_symbols
  end

  def datatype_hash
    @datatype_symbols
  end

  # TODO: figure out how to represent union types
  def define_symbols
    # defines the primitive C types and the number of
    # Brainfuck memory units it needs to represent
    #
    # Memory units are 32 bits to be compatible with the
    # muppetlabs Brainfuck interpreter
    #
    # symbols allowed ->
    # :cint, :cchar, :cshort, :clong, :cfloat, :cdouble, :clongdouble,
    # :cpointer
  end
end