class TokenKernal
  attr_reader :tokens
  attr_reader :file
  attr_reader :status
  attr_reader :current_pos
  attr_reader :error_message

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
    File.open(@file, "r") do |f|
      @line_num = 0
      f.each_line do |line|
        @char_num = 0
        line.each_char do |char|
          @char = char
          return if error?
          send @state
          @char_num += 1
        end
        @line_num += 1
      end
    end
  end

  def finding char = @char
  end

  def switch_to state
    add_char
    @state = state
  end
 
  def transfer_to state
    tok_num = token_number
    @tokens << tok_num if not error?
    @state = state
    @token = ""
    add_char if not whitespace?
  end

  def transfer_on_char
    if lower?
      transfer_to :lower_case_word
    elsif symbol_char?
      transfer_to :symbol
    elsif digit?
      transfer_to :integer
    elsif upper? 
      transfer_to :identifier_letters
    elsif whitespace?
      transfer_to :finding
    else
      transfer_to :finding
      throw_error
    end
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

  def symbols
    { ";"  => 12,
      "="  => 14,
      "||" => 19,
      "==" => 26  }
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

  def symbol_prefix? symbol = @token
    symbol_list.any? { |e| e.start_with? symbol }
  end

  def symbol? symbol = @token
    symbol_list.include? symbol
  end

  def symbol_list
    symbols.keys
  end

  def symbol_number
    throw_error if not symbols.has_key? @token
    symbols[@token]
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
    @error_message = "Failed at line #{@line_num + 1}, at character number #{@char_num + 1} while "
    @error_message += @state == :finding ? "on white space" : "on a #{@state}"
  end
end 
