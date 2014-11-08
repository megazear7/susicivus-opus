require "./decl_seq.rb"
require "./stmt_seq.rb"

class Prog

  attr_accessor :decl_seq
  attr_accessor :stmt_seq

  def initialize tokens
    tokens.skip "program"
    @decl_seq = DeclSeq.new(tokens)
    tokens.skip "begin"
    @stmt_seq = StmtSeq.new(tokens)
    tokens.skip "end"
  end

  def print_out
    puts "program"
    @decl_seq.print_out
    puts "begin"
    @stmt_seq.print_out
    puts "end"
  end

end
