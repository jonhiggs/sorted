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
    hookup { topic.push("first line") }
    asserts("have 1 element") { topic.size == 1 }
    asserts("data is not empty") { topic.data_of(0) == "first line" }
    asserts("parent is nil") { topic.parent_of(0).nil? }
    asserts("children is empty") { topic.children_of(0).empty? }
    asserts("indentation") { topic.indentation == "" }
  end

  context "with indented data" do
    hookup { topic.push("line one\n\tline two\n") }
    asserts("have 2 elements") { topic.size == 2 }
    asserts("data is not empty") { topic.data_of(0) == "first line" }
    asserts("children is empty") { topic.children_of(0) == 0 }
    asserts("indentation") { topic.indentation == "\t" }
  end
end
