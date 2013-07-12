module Sorted
  class Sorter
    def initialize input
      @input = input
      @input = ::Sorted::Parser.new(input).to_a if input.is_a?(String)
    end

    def size
      @input.size
    end

    def to_a
      @input
    end

    def numeric
      @input
    end

    def dictionary
      @input
    end

    def json
      @input
    end

    def yaml
      @input
    end

    def auto
    end
  end
end
