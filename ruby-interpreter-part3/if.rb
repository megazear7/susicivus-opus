require "./cond.rb"
require "./prog.rb"
require "./stmt_seq.rb"

class If

  attr_accessor :cond
  attr_accessor :stmt_seq1
  attr_accessor :stmt_seq2

  def initialize tokens
    tokens.skip "if"
    @cond = Cond.new(tokens)
    tokens.skip "then"
    @stmt_seq1 = StmtSeq.new(tokens)

    if tokens.current_token_string == "end"
      tokens.skip "end"
    else
      tokens.skip "else"
      @stmt_seq2 = StmtSeq.new(tokens)
      tokens.skip "end"
    end
    tokens.skip ";"
  end

  def execute variables, prog
    if cond.value variables
      @stmt_seq1.execute variables, prog
    else
      @stmt_seq2.execute variables, prog
    end
  end

  def print_out spaces
    Prog.indent spaces, "if"
    @cond.print_out
    puts "then"
    @stmt_seq1.print_out spaces + 2
    if not stmt_seq2
      Prog.indentLn spaces, "end;" 
    else
      Prog.indentLn spaces, "else"
      @stmt_seq2.print_out spaces + 2
      Prog.indentLn spaces, "end;"
    end
  end

end
