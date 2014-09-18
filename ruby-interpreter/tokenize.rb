require "./tokenizer"

tokenizer = Tokenizer.new(ARGV[0])

if not tokenizer.error?
  tokenizer.each do |token|
    puts token
  end
else
  puts "Error"
end
