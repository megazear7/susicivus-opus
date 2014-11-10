require "./stmt.rb"
require "./prog.rb"

class StmtSeq

  attr_accessor :stmt
  attr_accessor :stmt_seq

  def initialize tokens
    @stmt = Stmt.new(tokens)
    if tokens.current_token != 3 and tokens.current_token != 7
      @stmt_seq = StmtSeq.new(tokens)
    end
  end

  def execute variables, prog
    @stmt.execute variables, prog
    @stmt_seq.execute variables, prog if @stmt_seq
  end

  def print_out spaces
    @stmt.print_out spaces
    @stmt_seq.print_out spaces if @stmt_seq
  end

end
