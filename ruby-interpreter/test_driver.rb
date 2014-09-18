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
      answer << element
    end
  end

  should_pass = answer[0].chomp == "pass"
  answer.map! { |e| e.to_i }
  answer.shift

  if should_pass
    if tokenizer.error?
      full_pass = false
      puts test_name + ":\t Error"
    elsif tokenizer.tokens == answer
      puts test_name + ":\t Success" 
    else
      full_pass = false
      puts test_name + ":\t Failure"
    end
  else
    # some test cases labeled as error cases so that
    # we know that we error when we are supposed to
    if tokenizer.error?
      puts test_name + ":\t Success"
    else
      full_pass = false
      puts test_name + ":\t Failure"
    end
  end
end

puts

if full_pass
  puts "All tests passed!"
else
  puts "Some tests failed or errored"
end

puts
