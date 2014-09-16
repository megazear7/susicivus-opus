class Tokenizer
  def initialize file
    # this is the name of the file we will be tokenizing
    @file = file

    # this can be :in_progess, :error or :success
    @status = :in_progress
  end

  # This method will turn the file @file into an array of integers that
  # represent tokens
  def tokenize
  end
end
