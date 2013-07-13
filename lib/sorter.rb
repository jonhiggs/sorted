class Sorter
  module Sort
    def sort
      @elements.to_a.sort_by{|e| e[:data] }
    end

  class Dictionary
    require 'indentation'
    include Sorted::Formatter
    include Sorter::Sort

    def initialize input, config={}
      @indentation = Sorted::Indentation.new(input)
      @elements = Sorted::Parser.new(input)

      @config = {
        :type => "dictionary"
      }

      @elements = sort
    end
  end
end
