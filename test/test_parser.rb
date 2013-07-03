require 'parser'
require 'test_helper'

### CAPABILITIES ##############################################################
context "#Sorter::Parser - Config with default values" do
  setup do
    obj = Sorted::Parser.new("blah")
  end
  should("calculate indentation value") { topic.indentation == "" }
end

context "#Sorter::Parser - Config with set values" do
  setup do
    obj = Sorted::Parser.new("blah", { :indentation => "  "})
  end

  should("use the set indentation value") { topic.indentation == "  " }
end

context "#Sorter::Parser - Hierachy search" do
  setup do
    obj = Sorted::Parser.new("blah\n\tin blah\n")
  end

  should("should be able to find children") { topic.children_of(0) == [1] }
end

#### COMPLETE FILES ############################################################
context "#Sorted::Parser - With a flat file" do
  setup do
    @stdin = "this is a\nvery\nflat file"
    obj = Sorted::Parser.new(@stdin)
  end

  asserts(:indentation).equals ""
  asserts(:output).equals [
    {:id => 0, :depth => 0, :data => "this is a"},
    {:id => 1, :depth => 0, :data => "very"},
    {:id => 2, :depth => 0, :data => "flat file"}
  ]
end

context "#Sorted::Parser - With a simple nest" do
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

  asserts(:indentation).equals "  "
end

### EDGE CASES ################################################################
context "#Parser::Indentation - Tab Indented File" do
  setup do
    @stdin = "first level\n\tinside first level\n"
    obj = Sorted::Parser.new(@stdin)
  end

  asserts(:indentation).equals "\t"
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
  asserts(:output).equals [
    { :id => 0, :depth => 2, :data => "really deep" },
    { :id => 1, :depth => 1, :data => "deep"},
    { :id => 2, :depth => 0, :data => "top" }
  ]
end
