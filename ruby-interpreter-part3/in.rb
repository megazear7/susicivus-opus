require "./id_list.rb"
require "./prog.rb"

class In

  attr_accessor :id_list

  def initialize tokens
    tokens.skip "read"
    @id_list = IdList.new(tokens)
    tokens.skip ";"
  end

  def execute variables
    @id_list.ids.each do |id|
      variables[id] = STDIN.gets.chomp.to_i
    end
  end

  def print_out spaces
    Prog.indent spaces, "read "
    @id_list.print_out
    puts ";"
  end

end
