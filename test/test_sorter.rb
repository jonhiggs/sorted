require 'parser'
require 'sorter'
require 'test_helper'

context "#Sorted::Sorter" do

  context "take a string" do
    context "with one line" do
      setup do
        obj = Sorted::Sorter.new("first_line")
      end

      asserts("that it has one element") { topic.size == 1 }
      asserts("that it can sort by dictionary") { topic.dictionary.size == 1 }
    end

    context "with two lines" do
      setup do
        obj = Sorted::Sorter.new("z\ny\n")
      end

      asserts("that it has two elements") { topic.size == 2 }
      asserts("that it can sort by dictionary") { topic.dictionary == [{:data=>"y", :depth=>0, :parent=>nil}, {:data=>"z", :depth=>0, :parent=>nil}] }
    end
  end

end
