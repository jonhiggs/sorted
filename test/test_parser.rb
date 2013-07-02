require 'parser'
require 'test_helper'

### COMPLETE FILES ############################################################
context "#Parser::Indentation - Flat File" do
  setup do
    @stdin = <<-EOF
this is a
very
flat file
    EOF

    obj = Sorted::Parser.new(@stdin)
  end

  asserts(:input).equals ["this is a", "very", "flat file"]
  asserts(:find_indentations).equals [""]
  asserts(:indentation_count).equals 0
  asserts(:indentation_value).equals ""
end

context "#Parser::Indentation - Complete File" do
  setup do
    @stdin = <<-EOF
first level
  inside first level
    a second nested value
      a third nested value
another at top
  inside another
    EOF

    obj = Sorted::Parser.new(@stdin)
  end

  asserts(:find_indentations).equals ["", "  ", "    ", "      "]
  asserts(:indentation_count).equals 2
  asserts(:indentation_value).equals " "
end

### EDGE CASES ################################################################
context "#Parser::Indentation - Tab Indented File" do
  setup do
    @stdin = "first level\n\tinside first level\n"
    obj = Sorted::Parser.new(@stdin)
  end

  asserts(:indentation_count).equals 1
  asserts(:indentation_value).equals "\t"
end
