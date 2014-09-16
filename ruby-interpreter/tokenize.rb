tokenizer = Tokenizer.new(ARGV[0])

tokens = tokenizer.tokenize

tokens.each do |token|
  puts token
end
