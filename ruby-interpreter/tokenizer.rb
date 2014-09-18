class Tokenizer
  attr_reader :tokens
  attr_reader :file
  attr_reader :status
  attr_reader :current_pos

  def initialize file
    # this is the name of the file we will be tokenizing
    @file = file

    # this can be :in_progess, :error or :success
    @status = :in_progress

    # this is the current state that the tokenizer is in
    @state = :finding

    # this is the current token we are building
    @token = ""

    # the list of tokens
    @tokens = []

    # actually do the calculative work of tokenizing
    tokenize

    # position in @tokens that we are at right now
    @current_pos = 0
  end

  def length
    @tokens.length
  end

  def each &block
    @tokens.each(&block)
  end

  def next_token
    @current_pos += 1
    @tokens[@current_pos - 1]
  end

  def current_token
    @tokens[@current_pos]
  end

  def error?
    @status == :error
  end

  private

  def tokenize
    @step = 0
    File.open(@file, "r") do |f|
      f.each_char do |char|
        @char = char
        return @tokens if error?
        puts @step.to_s + "-" + @char
        case @state
        when :finding then finding
        when :lower_case_word then lower_case_word
        when :symbol then symbol
        when :integer then integer
        when :identifier_letters then identifier_letters
        when :identifier_numbers then identifier_numbers
        end
        @step += 1
      end
    end
  end

  def finding char = @char
    if lower?
      switch_to :lower_case_word
    elsif symbol_char?
      switch_to :symbol
    elsif digit?
      switch_to :integer
    elsif upper? 
      switch_to :identifier
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
      add_char
    elsif whitespace?
      transfer_to :finding
    else
      throw_error
    end
  end

  def symbol char = @char
    puts "(" + @token + char + ")" if @step == 26
    puts 
    if symbol? @token and not symbol? @token + char
      if lower?
        transfer_to :lower_case_word
        add_char
      elsif symbol_char?
        transfer_to :symbol
        add_char
      elsif digit?
        transfer_to :integer
        add_char
      elsif upper? 
        transfer_to :identifier
        add_char
      elsif whitespace?
        transfer_to :finding
      else
        throw_error
      end
    elsif symbol? @token and symbol? @token + char
      add_char
    elsif whitespace?
      transfer_to :finding
    else
      puts "." if @step == 26
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
    add_char
    @state = state
  end
 
  def transfer_to state
    @tokens << token_number
    @state = state
    @token = ""
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
    symbol_list.join("").squeeze.split("")
  end

  def symbol? symbol = @token
    symbol_list.include? symbol
  end

  def symbol_list
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
    char == char.upcase and char.match(/^[[:alpha:]]$/)
  end

  def lower? char = @char
    char == char.downcase and char.match(/^[[:alpha:]]$/)
  end

  def digit? char = @char
    char =~ /[0-9]/
  end

  def whitespace? char = @char
    char == " " or char == "\n" or char == "\t"
  end

  def throw_error
    @status = :error
  end
end
