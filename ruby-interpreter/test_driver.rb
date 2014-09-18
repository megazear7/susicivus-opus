require "./tokenizer"

test_directory = "./test_cases/"

puts
full_pass = true

Dir.glob(test_directory + "*.case") do |file_name|
  test_name = file_name[13..-6]
  tokenizer = Tokenizer.new(test_directory + test_name + ".case")

  answer = []
  File.open(test_directory + test_name + ".answer" , "r") do |f|
    f.each_line do |element|
      answer << element.strip
    end
  end

  result = tokenizer.tokens.map { |e| e.to_s }
  result << "Error" if tokenizer.error?

  print test_name + ":\t"

  if result == answer
    puts "Success" 
  else
    full_pass = false
    puts "Failure"
  end
end

puts
puts full_pass ? "All tests passed!" : "Some tests failed or errored"
puts
