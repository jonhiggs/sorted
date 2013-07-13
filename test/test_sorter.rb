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

#"one\ntwo\n100\n1\n2\n"
#"one\ntwo\n1\n2\n100\n" # numeric
#"1\n100\n2\none\ntwo\n" # dictionary

#      end
#
#      asserts("that it has five elements") { topic.size == 5 }
#      asserts("that it has five elements") { topic.to_s == "something" }
#      asserts("that it has five elements") { topic.to_s == "something" }
#      asserts("that it can sort by dictionary") { topic.dictionary == [{:data=>"y", :depth=>0, :parent=>nil}, {:data=>"z", :depth=>0, :parent=>nil}] }
#    end
#  end
#
#end
