require "./cond.rb"
require "./stmt_seq.rb"

class If

  attr_accessor :cond
  attr_accessor :stmt_seq1
  attr_accessor :stmt_seq2

  def initialize tokens
    tokens.skip # if
    @cond = Cond.new(tokens)
    tokens.skip # then
    @stmt_seq1 = StmtSeq.new(tokens)

    if tokens.current_token_string == "end"
      tokens.skip # end
    else
      tokens.skip # else
      @stmt_seq2 = StmtSeq.new(tokens)
      tokens.skip # end
    end
    tokens.skip # ;
  end

  def print_out
    print "if "
    @cond.print_out
    puts "then"
    @stmt_seq1.print_out
    if not stmt_seq2
      print "end" 
    else
      puts "else"
      stmt_seq2.print_out
      print "end"
    end
    puts ";"
  end

end
