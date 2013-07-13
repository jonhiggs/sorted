require 'parser'
require 'sorter'
require 'test_helper'

context "#Sorted::Sorter::Dictionary" do
  context "has basic functionality" do
    setup do
      obj = Sorter::Dictionary.new("y\n")
    end

    asserts("to_a returns an array of hashes") { topic.to_a == [{:data=>"y", :depth=>0, :parent=>nil}] }
    asserts("to_s returns data in a string") { topic.to_s == "y\n" }
    asserts("size is correct") { topic.size == 1 }
  end

  context "can sort flat data" do
    setup do
      obj = Sorter::Dictionary.new("z\ny\n")
    end

    asserts("to_a returns an array of hashes") { topic.to_a == [{:data=>"y", :depth=>0, :parent=>nil}, {:data=>"z", :depth=>0, :parent=>nil}] }
    asserts("to_s returns data in a string") { topic.to_s == "y\nz\n" }
    asserts("size is correct") { topic.size == 2 }
  end

  context "can indented data" do
    setup do
      obj = Sorter::Dictionary.new("z\n\ty\n")
    end

    asserts("to_a returns an array of hashes") { topic.to_a == [{:data=>"z", :depth=>0, :parent=>nil}, {:data=>"y", :depth=>0, :parent=>nil}] }
    asserts("to_s returns data in a string") { topic.to_s == "z\n\ty\n" }
    asserts("size is correct") { topic.size == 2 }
  end
end
