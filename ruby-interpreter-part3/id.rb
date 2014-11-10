class Id

  @@check_usage = false
  @@id_list = []
  attr_accessor :value

  def initialize tokens
    @value = tokens.current_token_string
    tokens.skip false
    if not valid_id? @value[0]
      puts "ERROR! expected valid id but got #{@value}"
      exit
    elsif @@check_usage and not @@id_list.include? @value
      puts "ERROR! id was referenced but not declared"
      exit
    end
  end

  def print_out
    print @value
  end

  def valid_id? char = @char
    char == char.upcase and char.match(/^[[:alpha:]]$/)
  end

  def self.set_check_usage id_list
    @@id_list = id_list
    @@check_usage = true
  end

end
