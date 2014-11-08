require "./op.rb"

class Trm

  attr_accessor :op
  attr_accessor :trm

  def initialize tokens
    @op = Op.new(tokens)
    if tokens.current_token_string == "*"
      tokens.skip "*"
      @trm = Trm.new(tokens)
    else
    end
  end

  def print_out
    @op.print_out
    if @trm
      print " * "
      @trm.print_out
    end
  end

end
