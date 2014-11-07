require "./id_list.rb"

class In

  attr_accessor :id_list

  def initialize tokens
    tokens.skip # read 
    @id_list = IdList.new(tokens)
  end

  def print_out 
    print "read "
    @id_list.print_out
  end

end
