require "./if.rb"
require "./loop.rb"
require "./in.rb"
require "./out.rb"
require "./assign.rb"

class Stmt

  attr_accessor :if
  attr_accessor :loop
  attr_accessor :in
  attr_accessor :out
  attr_accessor :assign

  def initialize tokens
    if    tokens.current_token_string == "if"
      @if = If.new(tokens)
    elsif tokens.current_token_string == "while"
      @loop = Loop.new(tokens)
    elsif tokens.current_token_string == "read"
      @in = In.new(tokens)
    elsif tokens.current_token_string == "write"
      @out = Out.new(tokens)
    else
      @assign = Assign.new(tokens)
    end
  end

  def print_out
    if    @if
      @if.print_out
    elsif @loop
      @loop.print_out
    elsif @in
      @in.print_out
    elsif @out
      @out.print_out
    elsif @assign
      @assign.print_out
    end
  end

end
