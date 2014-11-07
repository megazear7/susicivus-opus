class No

  attr_accessor :value

  def initialize tokens
    @value = tokens.current_token_string.to_i
    tokens.skip
  end

  def print_out
    print @value.to_s
  end

end
