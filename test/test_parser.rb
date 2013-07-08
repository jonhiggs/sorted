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
  end

  context "with valid json" do
    valid_json = "{\n  'Version' : '1',\n  'Description' : 'Something',\n  'Parameters' : {\n    'InstanceType' : {\n      'Description' : 'tests'\n    }\n  }\n}\n"
    hookup { topic.push(valid_json) }

    asserts("that indentation is two spaces") { topic.indentation == "  " }
    asserts("that line zero is valid") { topic.data_of(0) == "{" }
    asserts("that line one is valid") { topic.data_of(1) == "'Version' : '1'," }
    asserts("that line one is child of line zero") { topic.children_of(0).include?(1) }
    denies("that line four is child of line zero") { topic.children_of(0).include?(4) }
    asserts("that line four is child of line three") { topic.children_of(3).include?(4) }
    asserts("that line zero has no parent" ) { topic.parent_of(0).nil? }
    asserts("that line one has parent of zero" ) { topic.parent_of(1) == 0 }
    asserts("that line four has parent of three" ) { topic.parent_of(4) == 3 }
    asserts("that line four has sibling of four and six" ) { topic.siblings_of(4) == [4,6] }
    asserts("that line zero has sibling of zero and eight" ) { topic.siblings_of(0) == [0,8] }
  end
end
