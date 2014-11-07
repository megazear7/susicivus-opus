require "./exp.rb"
require "./no.rb"
require "./id.rb"

class Op

  attr_accessor :exp
  attr_accessor :no
  attr_accessor :id

  def initialize tokens
    if tokens.current_token_string == "("
      tokens.skip # (
      @exp = Exp.new(tokens)
      tokens.skip # )
    else
      if    digit? tokens.current_token_string[0]
        @no = No.new(tokens)
      else
        @id = Id.new(tokens)
      end
    end
  end

  def print_out
    if @exp
      print "("
      @exp.print_out
      print ")"
    elsif @no
      @no.print_out
    elsif @id
      @id.print_out
    end
  end

  def digit? char = @char
    char =~ /[0-9]/
  end

end
