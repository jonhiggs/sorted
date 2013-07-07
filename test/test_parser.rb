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
    asserts("use a tab for indentation") { topic.indentation == "\t" }
    asserts("have 2 elements") { topic.size == 2 }
    asserts("have correct data for first line") { topic.data_of(0) == "line one" }
    asserts("have correct data for second line") { topic.data_of(1) == "line two" }
    asserts("have a child set for first") { topic.children_of(0) == [1] }
    asserts("have a parent set for second") { topic.parent_of(1) == 0 }
    asserts("indentation") { topic.indentation == "\t" }
  end
end
