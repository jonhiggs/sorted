module Sorted
  class Indentation
    def initialize input
      @input = input
    end

    def to_s
      "#{value}" * count
    end

    def count
      return 0 if indentations.empty?
      return indentations.first.size if indentations.first.size == indentations.last.size
      indentations[-1].size - indentations[-2].size
    end

    def value
      return "" if indentations.empty?
      indentations.last.empty? ? "" : indentations.last.match(/^./).to_s
    end

    ##################
    private
    def indentations
      whitespaces = []
      @input.each do |line|
        v = line.match(/^\s*/).to_s
        whitespaces.push(v)
      end
      whitespaces.sort.uniq
    end

  end
end
