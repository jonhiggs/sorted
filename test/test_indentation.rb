require 'indentation'
require 'test_helper'

context "#Sorted::Indentation" do
  context "not nested" do
    setup { Sorted::Indentation.new(EXAMPLES[:json][:simple]) }

    asserts("correct count") { topic.count == 0 }
    asserts("correct value") { topic.value.empty? }
    asserts("correct string") { topic.to_s.empty? }
  end

  context "nested with tabs" do
    setup do
      obj = Sorted::Indentation.new("a\n\tb\n\t\tc\n")
    end

    asserts("correct count") { topic.count == 1 }
    asserts("correct value") { topic.value == "\t" }
    asserts("correct string") { topic.to_s == "\t" }
  end

  context "nested with spaces" do
    setup do
      obj = Sorted::Indentation.new("a\n  b\n    c\n")
    end

    asserts("correct count") { topic.count == 2 }
    asserts("correct value") { topic.value == " " }
    asserts("correct string") { topic.to_s == "  " }
  end
end
