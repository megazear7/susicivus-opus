require "./tokenizer"
require "./colors"

tokenizer = Tokenizer.new(ARGV[0])

tokenizer.each do |token|
  puts token
end

puts red("Error") + ": " + tokenizer.error_message if tokenizer.error?
