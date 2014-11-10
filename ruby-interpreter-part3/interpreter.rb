require "./tokenizer"
require "./prog.rb"

tokenizer = Tokenizer.new(ARGV[0])

prog = Prog.new(tokenizer, ARGV[1])

prog.print_out 0

prog.execute
