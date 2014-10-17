require "./tokenizer"
require "./colors"

tokenizer = Tokenizer.new(ARGV[0])

tokenizer.each do |token|
  puts token
end

puts Color.red("Error") + ": " + tokenizer.error_message if tokenizer.error?
