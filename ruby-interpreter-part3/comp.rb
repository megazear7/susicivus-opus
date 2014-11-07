require "./op.rb"
require "./comp_op.rb"

class Comp

  attr_accessor :op1
  attr_accessor :op2
  attr_accessor :comp_op

  def initialize tokens
    tokens.skip # (
    @op1 = Op.new(tokens)
    @comp_op = CompOp.new(tokens)
    @op2 = Op.new(tokens)
    tokens.skip # )
  end

  def print_out 
    print "("
    @op1.print_out
    @comp_op.print_out
    @op2.print_out
    print ")"
  end

end
