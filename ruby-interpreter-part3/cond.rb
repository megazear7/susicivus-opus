require "./comp.rb"

class Cond
  
  attr_accessor :false
  attr_accessor :cond
  attr_accessor :cond1
  attr_accessor :or
  attr_accessor :and
  attr_accessor :cond2
  attr_accessor :comp

  def initialize tokens
    if tokens.current_token_string == "!"
      @false = true
      @cond = Cond.new(tokens)
    elsif tokens.current_token_string == "["
      @false = false
      tokens.skip "["
      @cond1 = Cond.new(tokens)
      if    tokens.current_token_string == "&&"
        @or  = false
        @and = true
      elsif tokens.current_token_string == "||"
        @or  = true
        @and = false
      end
      @cond2 = Cond.new(tokens)
      tokens.skip "]"
    else
      @comp = Comp.new(tokens)
    end
  end

  def value variables
    if @false
      not @cond.value variables
    elsif @cond2
      if @and
        @cond1.value variables and @cond2.value variables 
      elsif @or
        @cond1.value variables or @cond2.value variables 
      end
    else
      @comp.value variables
    end
  end

  def print_out
    if @false
      print "!"
      @cond.print_out
    elsif @cond2
      print " [ "
      @cond1.print_out
      print " && " if @and
      print " || " if @or
      @cond2.print_out
      print " ] "
    else
      @comp.print_out
    end
  end

end
