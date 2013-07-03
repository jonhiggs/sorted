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
  asserts(:indent).equals ""
  asserts(:output).equals [
    {:id => 0, :depth => 0, :data => "this is a"},
    {:id => 1, :depth => 0, :data => "very"},
    {:id => 2, :depth => 0, :data => "flat file"}
  ]
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
  asserts(:indent).equals "  "
end

### EDGE CASES ################################################################
context "#Parser::Indentation - Tab Indented File" do
  setup do
    @stdin = "first level\n\tinside first level\n"
    obj = Sorted::Parser.new(@stdin)
  end

  asserts(:indentation_count).equals 1
  asserts(:indentation_value).equals "\t"
  asserts(:indent).equals "\t"
  asserts(:output).equals [
    { :id => 0, :depth => 0, :data => "first level" },
    { :id => 1, :depth => 1, :data => "inside first level"}
  ]
end

context "#Parser::Indentation - File gets shallower" do
  setup do
    @stdin = "\t\treally deep\n\tdeep\ntop\n"
    obj = Sorted::Parser.new(@stdin)
  end

  asserts(:indentation_count).equals 1
  asserts(:indentation_value).equals "\t"
  asserts(:output).equals [ { :depth => 2, :data => "really deep" }, { :depth => 1, :data => "deep"}, { :depth => 0, :data => "top" } ]
end
