class Sorter
  class Dictionary
    require 'indentation'
    include Sorted::Formatter

    def initialize input, config={}
      @indentation = Sorted::Indentation.new(input)
      @elements = Sorted::Parser.new(input)
      @elements = sort
    end

    def sort
      @elements.to_a.sort_by{|e| e[:data] }
    end
  end
end
