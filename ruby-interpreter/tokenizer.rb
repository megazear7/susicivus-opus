class Tokenizer
  def initialize file
    # this is the name of the file we will be tokenizing
    @file = file

    # this can be :in_progess, :error or :success
    @status = :in_progress

    # this is the current state that the tokenizer is in
    @state = :finding

    @tokens = []

    # this is the current token we are building
    @token = ""
  end

  # This method will turn the file @file into an array of integers that
  # represent tokens
  def tokenize
    File.open(@file, "r") do |f|
      f.each_char do |char|
        @char = char
        return @tokens if error?
        case @state
        when :finding then finding
        when :lower_case_word then lower_case_word
        when :symbol then symbol
        when :integer then integer
        when :identifier_letters then identifier_letters
        when :identifier_numbers then identifier_numbers
        end
      end
    end
    @tokens
  end

  def finding char = @char
    if lower?
      transfer_to :lower_case_word
    elsif symbol_char?
      transfer_to :symbol
    elsif digit?
      transfer_to :integer
    elsif upper? 
      transfer_to :identifier
    elsif whitespace?
      # do nothing
    else
      throw_error
    end
  end

  def lower_case_word char = @char
    if lower?
      add_char
    elsif symbol_char?
      transfer_to :symbol
    elsif whitespace?
      transfer_to :finding
    else
      throw_error
    end
  end

  def symbol char = @char
    if symbol? token and not symbol? token + char
      transfer_to :finding
    elsif symbol? token and symbol? token + char
      add_char
    elsif whitespace?
      transfer_to :finding
    else
      throw_error
    end
  end

  def integer char = @char
    if digit?
      add_char
    elsif symbol_char?
      transfer_to :symbol
    elsif space?
      transfer_to :finding
    else
      throw_error
    end
  end

  def identifier_letters char = @char
    if upper?
      add_char
    elsif digit?
      add_char
      switch_to :identifier_numbers
    elsif symbol_char?
      transfer_to :symbol
    elsif space?
      transfer_to :finding
    else
      throw_error
    end
  end

  def identifier_numbers char = @char
    if digit?
      add_char
    elsif symbol_char?
      transfer_to :symbol
    elsif space?
      transfer_to :finding
    else
      throw_error
    end
  end

  def switch_to state
    @state = state
  end
 
  def transfer_to state
    @tokens << token_number
    @token = ""
    @state = state
  end

  def token_number
    case @state
    when :lower_case_word then 1 
    when :symbol then symbol_number
    when :integer then 31
    when :identifier_letters then 32
    when :identifier_numbers then 32
    end  
  end

  def add_char
    @token += @char
  end

  def symbol_char? char = @char
    symbol_chars.include? char
  end

  def symbol_chars
    # this will return an array of every character that appears in symbols
    symbols.keys.join("").squeeze.split("")
  end

  def symbol? symbol
    symbols.include symbol
  end

  def symbols
    symbols.keys
  end

  def symbol_number
    symbols[@token]
  end

  def symbols
    { ";"  => 12,
      "="  => 14,
      "||" => 19,
      "==" => 26  }
  end

  def upper? char = @char
    char == char.upcase
  end

  def lower? char = @char
    char == char.downcase
  end

  def digit? char = @char
    char =~ /[0-9]/
  end

  def whitespace? char = @char
    char == ""
  end

  def throw_error
    @status = :error
  end

  def error?
    @status == :error
  end
end
