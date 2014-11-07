require "./decl.rb"

class DeclSeq

  attr_accessor :decl
  attr_accessor :decl_seq

  def initialize tokens
    @decl = Decl.new(tokens)
    if tokens.current_token != 2
      @decl_seq = DeclSeq.new(tokens)
    end
  end

  def print_out
    @decl.print_out
    if @decl_seq
      @decl_seq.print_out
    end
  end

end
