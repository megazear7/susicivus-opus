require "./trm.rb"

class Exp

  attr_accessor :trm
  attr_accessor :exp
  attr_accessor :add
  attr_accessor :sub

  def initialize tokens
    @trm = Trm.new(tokens)
    if    tokens.current_token_string == "+"
      @add = true
      @sub = false
      tokens.skip # +
      @exp = Exp.new(tokens)
    elsif tokens.current_token_string == "-"
      @add = false
      @sub = true
      tokens.skip # -
      @exp = Exp.new(tokens)
    end
  end

  def print_out
    @trm.print_out
    if @add
      print " + "
      @exp.print_out
    elsif @sub
      print " - "
      @exp.print_out
    end
  end

end
