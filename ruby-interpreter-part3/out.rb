require "./id_list.rb"

class Out

  attr_accessor :id_list

  def initialize tokens
    tokens.skip "write"
    @id_list = IdList.new(tokens)
    tokens.skip ";"
  end

  def print_out
    print "write "
    @id_list.print_out
    puts ";"
  end

end
