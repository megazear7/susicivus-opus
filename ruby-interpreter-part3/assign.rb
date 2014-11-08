require "./id_list.rb"

class Assign

  attr_accessor :id_list

  def initialize tokens
    @id = Id.new(tokens)
    tokens.skip "="
    @exp = Exp.new(tokens)
    tokens.skip ";"
  end

  def print_out
    @id.print_out
    print " = "
    @exp.print_out
    puts ";"
  end

end
