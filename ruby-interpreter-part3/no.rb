class No

  attr_accessor :value

  def initialize tokens
    @value = tokens.current_token_string.to_i
    tokens.skip false
    if not numeric? @value
      puts "ERROR! expected numeric value but got #{@value}"
      exit
    end
  end

  def print_out
    print @value.to_s
  end

  def numeric? str
    true if Float(str) rescue false
  end

end
