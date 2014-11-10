require "./id_list.rb"
require "./prog.rb"

class Decl

  @@declared_ids = []
  attr_accessor :id_list

  def initialize tokens
    tokens.skip "int"
    @id_list = IdList.new(tokens)
    @@declared_ids += @id_list.ids
    if @@declared_ids.uniq.length != @@declared_ids.length
      puts "Error, duplicate declaration of id"
      exit
    end
    tokens.skip ";"
  end

  def print_out spaces
    Prog.indent spaces, "int "
    @id_list.print_out
    puts ";"
  end

  def self.declared_list
    @@declared_ids
  end

end
