class Id

  attr_accessor :value

  def initialize tokens
    @value = tokens.current_token_string
    tokens.skip
  end

  def print_out
    print @value
  end

end
