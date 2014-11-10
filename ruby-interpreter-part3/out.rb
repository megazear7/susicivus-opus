require "./id_list.rb"
require "./prog.rb"

class Out

  attr_accessor :id_list

  def initialize tokens
    tokens.skip "write"
    @id_list = IdList.new(tokens)
    tokens.skip ";"
  end

  def execute variables
    @id_list.ids.each do |id|
      puts id + " = " + variables[id].to_s
    end
  end

  def print_out spaces
    Prog.indent spaces, "write "
    @id_list.print_out
    puts ";"
  end

end
