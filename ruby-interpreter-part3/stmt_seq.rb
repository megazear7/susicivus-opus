require "./stmt.rb"

class StmtSeq

  attr_accessor :stmt
  attr_accessor :stmt_seq

  def initialize tokens
    @stmt = Stmt.new(tokens)
    if tokens.current_token != 3 and tokens.current_token != 7
      @stmt_seq = StmtSeq.new(tokens)
    end
  end

  def print_out
    @stmt.print_out
    @stmt_seq.print_out if @stmt_seq
  end

end
