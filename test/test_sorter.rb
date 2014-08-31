require 'test_helper'

context "#Sorted::Sorter::Dictionary" do
  context "has basic functionality" do
    setup do
      data = "bill\njoe\nsteven\n  tom\n  craig\n    kate\n    jo\nmatt\njon\n  jill\n  jane\nsarah\n"
      obj = Sorter::Dictionary.new(data)
    end

    # bill
    # joe
    # steven
    #   tom
    #   craig
    #     kate
    #     jo
    # matt
    # jon
    #   jill
    #   jane
    # sarah

    asserts(:get_next).equals 0
    asserts(:sort_siblings_of_next).equals [0, 1, 8, 7, 11, 2]
    asserts(:insert_next_into_ordered_list).equals [0, 1, 8, 7, 11, 2]
    asserts(:get_next).equals 3
    asserts(:sort_siblings_of_next).equals [4, 3]
    asserts(:insert_next_into_ordered_list).equals [0, 1, 8, 7, 11, 2, 4, 3]
    asserts(:get_next).equals 5
    asserts(:sort_siblings_of_next).equals [ 6, 5 ]
    asserts(:insert_next_into_ordered_list).equals [0, 1, 8, 7, 11, 2, 4, 6, 5, 3]
    asserts(:get_next).equals 9
    asserts(:sort_siblings_of_next).equals [ 10, 9 ]
    asserts(:insert_next_into_ordered_list).equals [0, 1, 8, 10, 9, 7, 11, 2, 4, 6, 5, 3]
    asserts(:to_a).equals [{:data=>"bill", :depth=>0, :parent=>nil, :original_position=>0}, {:data=>"joe", :depth=>0, :parent=>nil, :original_position=>1}, {:data=>"jon", :depth=>0, :parent=>nil, :original_position=>8}, {:data=>"jane", :depth=>1, :parent=>8, :original_position=>10}, {:data=>"jill", :depth=>1, :parent=>8, :original_position=>9}, {:data=>"matt", :depth=>0, :parent=>nil, :original_position=>7}, {:data=>"sarah", :depth=>0, :parent=>nil, :original_position=>11}, {:data=>"steven", :depth=>0, :parent=>nil, :original_position=>2}, {:data=>"craig", :depth=>1, :parent=>2, :original_position=>4}, {:data=>"jo", :depth=>2, :parent=>4, :original_position=>6}, {:data=>"kate", :depth=>2, :parent=>4, :original_position=>5}, {:data=>"tom", :depth=>1, :parent=>2, :original_position=>3}]
    asserts(:to_s).equals "bill\njoe\njon\n  jane\n  jill\nmatt\nsarah\nsteven\n  craig\n    jo\n    kate\n  tom"
  end
end
