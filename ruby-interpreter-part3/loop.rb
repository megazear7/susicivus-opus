require "./cond.rb"
require "./stmt_seq.rb"

class Loop

  attr_accessor :cond
  attr_accessor :stmt_seq

  def initialize tokens
    tokens.skip "while"
    @cond = Cond.new(tokens)
    tokens.skip "loop"
    @stmt_seq = StmtSeq.new(tokens)
    tokens.skip "end"
    tokens.skip ";"
  end

  def print_out
    print "while"
    @cond.print_out
    puts "loop"
    @stmt_seq.print_out
    puts "end;"
  end

end
