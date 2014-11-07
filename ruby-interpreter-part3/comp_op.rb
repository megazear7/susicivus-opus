class Comp

  attr_accessor :type

  def initialize tokens
    @type = tokens.current_token_string
  end

  def print_out 
    @type.print_out
  end

end
