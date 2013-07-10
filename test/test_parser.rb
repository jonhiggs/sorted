require 'parser'
require 'test_helper'

context "#Sorted::Parser" do
  setup do
    obj = Sorted::Parser.new("")
  end

  context "with no input" do
    asserts("have no elements") { topic.size == 0 }
    asserts("data is nil") { topic.data_of(0).nil? }
    asserts("children is empty") { topic.children_of(0).empty? }
    asserts("indentation") { topic.indentation == "" }
  end

  context "with flat data" do
    hookup { topic.push("first line\nsecond_line") }
    asserts("that indentation is empty") { topic.indentation.empty? }
    asserts("that topic has two elements") { topic.size == 2 }
    asserts("that data is not empty") { topic.data_of(0) == "first line" }
    asserts("that parent is nil") { topic.parent_of(0).nil? }
    asserts("that children is empty") { topic.children_of(0).empty? }
    asserts("that zero is sibling of one") { topic.siblings_of(1).include?(0) }
    asserts("that one is sibling of zero") { topic.siblings_of(0).include?(1) }
    asserts("that block of zero has two elements") { topic.block_of(0).size == 2 }
    asserts("that block has correct line zero") { topic.block_of(0)[0][:data] == "first line" }
    asserts("that block has correct line one") { topic.block_of(0)[1][:data] == "second_line" }
  end

  context "with indented data" do
    hookup { topic.push("line one\n\tline two\n") }
    asserts("that indentation is a tab") { topic.indentation == "\t" }
    asserts("that we have 2 elements") { topic.size == 2 }
    asserts("that line zero is correct") { topic.data_of(0) == "line one" }
    asserts("that line one is correct") { topic.data_of(1) == "line two" }
    asserts("that line one is child of line zero") { topic.children_of(0) == [1] }
    asserts("that line zero is parent of line one") { topic.parent_of(1) == 0 }
    asserts("that line zero is a parent") { topic.is_parent?(0) }
    denies("that line one is a parent") { topic.is_parent?(1) }
    denies("that line zero is a child") { topic.is_child?(0) }
    asserts("that line one is a child") { topic.is_child?(1) }
    asserts("that block of zero has two elements") { topic.block_of(0).size == 2 }
    asserts("that block has correct line zero") { topic.block_of(0)[0][:depth] == 0 }
    asserts("that block has correct line one") { topic.block_of(0)[1][:depth] == 1 }
  end

  context "with valid json" do
    valid_json = "{\n  'Version' : '1',\n  'Description' : 'Something',\n  'Parameters' : {\n    'InstanceType' : {\n      'Description' : 'tests'\n    }\n  }\n}\n"
    hookup { topic.push(valid_json) }

    asserts("that indentation is two spaces") { topic.indentation == "  " }
    asserts("that line zero is valid") { topic.data_of(0) == "{" }
    asserts("that line one is valid") { topic.data_of(1) == "'Version' : '1'," }
    asserts("that line one is child of line zero") { topic.children_of(0).include?(1) }
    asserts("that line four is child of line zero") { topic.children_of(0).include?(4) }
    asserts("that line four is child of line three") { topic.children_of(3).include?(4) }
    asserts("that line zero has no parent" ) { topic.parent_of(0).nil? }
    asserts("that line one has parent of zero" ) { topic.parent_of(1) == 0 }
    asserts("that line four has parent of three" ) { topic.parent_of(4) == 3 }
    asserts("that line four has sibling of six" ) { topic.siblings_of(4) == [6] }
    asserts("that line zero has sibling of eight" ) { topic.siblings_of(0) == [8] }
    asserts("that line four has child of five") { topic.children_of(4) == [5] }
    asserts("that block of three has seven elements") { topic.block_of(3).size == 7 }
  end

  context "a deep nest" do
    hookup { topic.push("line zero\n\tline one\n\t\tline two\n\t\t\tline three\n\t\t\t\tline four") }
    asserts ("that line four has no siblings") { topic.siblings_of(4).empty? }
    asserts ("that line four has no children") { topic.children_of(4).empty? }
    asserts ("that line three has no siblings") { topic.siblings_of(3).empty? }
    asserts ("that line three has four as child") { topic.children_of(3) == [4] }
    asserts ("that line zero has no siblings") { topic.siblings_of(0).empty? }
  end

end
