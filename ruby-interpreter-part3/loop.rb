require "./cond.rb"
require "./prog.rb"
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

  def execute variables
    while cond.value variables
      @stmt_seq.execute variables 
    end
  end

  def print_out spaces
    Prog.indent spaces, "while"
    @cond.print_out
    puts "loop"
    @stmt_seq.print_out spaces + 2
    Prog.indentLn spaces, "end;"
  end

end
