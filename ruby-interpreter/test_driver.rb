require "./tokenizer"
require "./colors"

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

  if result == answer
    puts green(".")
  else
    full_pass = false
    puts red(test_name)
  end
end

puts
puts full_pass ? blue("All tests passed!") : yellow("Some tests failed")
puts
