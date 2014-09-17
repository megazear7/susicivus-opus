require "./tokenizer"

tokenizer = Tokenizer.new(ARGV[0])

tokens = tokenizer.tokenize

if not tokenizer.error?
  tokens.each do |token|
    puts token
  end
else
  puts "Error"
end
