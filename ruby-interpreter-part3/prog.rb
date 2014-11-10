require "./decl_seq.rb"
require "./stmt_seq.rb"

class Prog

  attr_accessor :decl_seq
  attr_accessor :stmt_seq
  attr_accessor :variables

  def initialize tokens, input_data_file 
    @currentInput = 0
    @inputData = init_input_data input_data_file
    tokens.skip "program"

    @decl_seq = DeclSeq.new(tokens)
    declared_list = @decl_seq.declared_list

    @variables = {}
    declared_list.map { |x| @variables[x] = nil }

    tokens.skip "begin"

    Id.set_check_usage declared_list
    @stmt_seq = StmtSeq.new(tokens)

    tokens.skip "end"
  end

  def init_input_data input_data_file
    File.open(input_data_file, "r").read.split(" ").map { |x| x.to_i }
  end

  def next_input
    @currentInput += 1
    @inputData[@currentInput - 1]
  end

  def print_out spaces
    Prog.indentLn spaces, "program"
    @decl_seq.print_out spaces + 2
    Prog.indentLn spaces, "begin"
    @stmt_seq.print_out spaces + 2
    Prog.indentLn spaces, "end"
  end

  def execute
    @stmt_seq.execute @variables, self
  end

  def self.indentLn spaces, str
    indention = ""
    spaces.times { |i| indention += " " }
    puts indention + str
  end

  def self.indent spaces, str
    indention = ""
    spaces.times { |i| indention += " " }
    print indention + str
  end

end
