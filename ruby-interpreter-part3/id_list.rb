require "./id.rb"

class IdList

  attr_accessor :id
  attr_accessor :id_list

  def initialize tokens
    @id = Id.new(tokens)
    if tokens.current_token_string == ","
      tokens.skip ","
      @id_list = IdList.new(tokens)
    end
  end

  def print_out
    @id.print_out
    if @id_list
      print ", "
      @id_list.print_out
    end
  end

end
