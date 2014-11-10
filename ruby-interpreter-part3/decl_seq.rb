require "./decl.rb"
require "./prog.rb"

class DeclSeq

  attr_accessor :decl
  attr_accessor :decl_seq

  def initialize tokens
    @decl = Decl.new(tokens)
    if tokens.current_token != 2
      @decl_seq = DeclSeq.new(tokens)
    end
  end

  def print_out spaces
    @decl.print_out spaces
    if @decl_seq
      @decl_seq.print_out spaces
    end
  end

  def declared_list
    Decl.declared_list
  end

end
