require "./token_kernal"

class Tokenizer < TokenKernal
  
  # You start in the :finding state
  def finding char = @char
    if lower?
      switch_to :lower_case_word
    elsif symbol_char?
      switch_to :symbol
    elsif digit?
      switch_to :integer
    elsif upper? 
      switch_to :identifier_letters
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
    if symbol_prefix? @token and not symbol? @token + char
      transfer_on_char
    elsif symbol_prefix? @token and symbol_prefix? @token + char
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
    elsif whitespace?
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
    elsif whitespace?
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
    elsif whitespace?
      transfer_to :finding
    else
      throw_error
    end
  end
end
