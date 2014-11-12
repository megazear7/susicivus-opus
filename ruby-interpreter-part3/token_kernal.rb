class TokenKernal
  attr_reader :tokens
  attr_reader :token_strings
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
    @token_strings = []

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

  def each_as_strings &block
    @token_strings.each(&block)
  end

  def next_token_string
    @current_pos += 1
    @token_strings[@current_pos - 1]
  end

  def current_token_string
    @token_strings[@current_pos]
  end

  def skip expected
    if expected and @token_strings[@current_pos] != expected
      puts "ERROR! expected #{@token_strings[@current_pos]} to equal #{expected}" 
      exit
    end
    @current_pos += 1
    @tokens[@current_pos - 1]
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

    # for the sake of consistency add the EOF token
    @tokens << 33
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
    @token_strings << @token if not error?
    @state = state
    @token = ""
    add_char if not whitespace?
  end

  def transfer_on_char
    if lower?
      transfer_to :reserved_word
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
    when :reserved_word then reserved_word_number
    when :symbol then symbol_number
    when :integer then 31
    when :identifier_letters then 32
    when :identifier_numbers then 32
    end  
  end

  def reserved_words
    { "program" => 1,
      "begin"   => 2,
      "end"     => 3,
      "int"     => 4,
      "if"      => 5,
      "then"    => 6,
      "else"    => 7,
      "while"   => 8,
      "loop"    => 9,
      "read"    => 10,
      "write"   => 11 }
  end

  def symbols
    { ";"  => 12,
      ","  => 13,
      "="  => 14,
      "!"  => 15,
      "["  => 16,
      "]"  => 17,
      "&&" => 18,
      "||" => 19,
      "("  => 20,
      ")"  => 21,
      "+"  => 22,
      "-"  => 23,
      "*"  => 24,
      "!=" => 25,
      "==" => 26,
      "<"  => 27,
      ">"  => 28,
      "<=" => 29,
      ">=" => 30 }
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

  def reserved_word_number
    throw_error if not reserved_words.has_key? @token
    reserved_words[@token]
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
