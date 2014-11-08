class CompOp

  attr_accessor :type

  def initialize tokens
    @type = tokens.current_token_string
    tokens.skip false
    case @type
    when "!="
    when "=="
    when "<"
    when ">"
    when "<="
    when ">="
    else
      puts "ERROR expected a comparison operator but got #{@type}"
    end
  end

  def print_out 
    print " " + @type + " "
  end

end
