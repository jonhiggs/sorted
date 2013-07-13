require 'parser'
require 'sorter'
require 'test_helper'

context "#Sorted::Sorter::Dictionary" do
  context "basic functionality" do
    setup do
      obj = Sorter::Dictionary.new("y\n")
    end

    asserts("to_a returns an array of hashes") { topic.to_a == [{:data=>"y", :depth=>0, :parent=>nil}] }
    asserts("to_s returns data in a string") { topic.to_s == "y\n" }
    asserts("to_s returns nil") { topic.to_s.nil? }
    asserts("size is 1") { topic.size == 1 }
  end
end
