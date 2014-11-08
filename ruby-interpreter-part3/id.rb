class Id

  attr_accessor :value

  def initialize tokens
    @value = tokens.current_token_string
    tokens.skip false
    if not valid_id? @value[0]
      puts "WARNING! expected valid id but got #{@value}"
    end
  end

  def print_out
    print @value
  end

  def valid_id? char = @char
    char == char.upcase and char.match(/^[[:alpha:]]$/)
  end

end
