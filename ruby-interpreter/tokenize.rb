require "./tokenizer"

tokenizer = Tokenizer.new(ARGV[0])

tokenizer.each do |token|
  puts token
end

puts "Error: " + tokenizer.error_message if tokenizer.error?
