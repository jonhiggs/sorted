module Sorted
  module Formatter
    def to_a
      @elements.to_a
    end

    def to_s
      @elements.to_a.map{|e| (@indentation.to_s * e[:depth]) + e[:data]}.join("\n") + "\n"
    end

    def size
      @elements.size
    end
  end
end
