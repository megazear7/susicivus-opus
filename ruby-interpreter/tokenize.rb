require "./tokenizer"

tokenizer = Tokenizer.new(ARGV[0])

tokenizer.each do |token|
  puts token
end

puts "Error" if tokenizer.error?
