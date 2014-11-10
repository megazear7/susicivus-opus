require "./id_list.rb"
require "./prog.rb"

class Assign

  attr_accessor :id

  def initialize tokens
    @id = Id.new(tokens)
    tokens.skip "="
    @exp = Exp.new(tokens)
    tokens.skip ";"
  end

  def execute variables
    variables[@id.value] = @exp.value variables
  end

  def print_out spaces
    Prog.indent spaces, ""
    @id.print_out
    print " = "
    @exp.print_out
    puts ";"
  end

end
