class Sorter
  class Dictionary
    include Sorted::Formatter

    def initialize input, config={}
      @input = input
      @elements = Sorted::Parser.new(input)
      sort
      puts "elements are #{@elements.to_a.inspect}"
    end

    def sort
      @elements.to_a.sort_by{|e| e[:data] }
    end
  end
end
