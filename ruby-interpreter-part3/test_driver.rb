require "./tokenizer"
require "./colors"

tests = "./test_cases/"

puts
full_pass = true

Dir.glob(tests + "*.core") do |file_name|

  test_name = file_name[13..-6]

  input = tests + test_name + ".core"
  answer = tests + test_name + ".answer"
  actual = tests + test_name + ".actual"

  puts Color.blue(test_name + ":")
  system "ruby interpreter.rb #{input} > #{actual}"
  system "diff #{answer} #{actual}"
  puts Color.blue("------------------------")
  puts ""

end
