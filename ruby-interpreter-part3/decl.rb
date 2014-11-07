require "./id_list.rb"

class Decl

  attr_accessor :id_list

  def initialize tokens
    tokens.skip # int
    @id_list = IdList.new(tokens)
    tokens.skip # ;
  end

  def print_out
    print "int "
    @id_list.print_out
    puts ";"
  end

end
