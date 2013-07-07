module Sorted
  class Parser
    def initialize input, config={}
      @input = []
      @elements = []
      @config = config
      @config[:indentation] = indentation unless @config.has_key?(:indentation)
      push(input)
    end

    def to_a
      @elements
    end

    def size
      @elements.size
    end

    def push input
      input.split("\n").each do |line|
        @input.push(line)
        @elements.push({
          :data => clean(line),
          :depth => depth(line)
        })
        @elements.last[:parent] = parent_of_last
      end
    end

    def indentation
      "#{indentation_value}" * indentation_count
    end

    def children_of id
      counter = 0
      children = []
      @elements.each do |e|
        children.push(counter) if e[:parent] == id
        counter += 1
      end
      children
    end

    def parent_of id
      id < size ? @elements[id][:parent] : nil
    end

    def data_of id
      id < size ? @elements[id][:data] : nil
    end

    ##########################################################
    private

    def depth line
      return 0 if indentation.empty?
      leading_whitespace = line.match(/^#{indentation}*/).to_s
      leading_whitespace.scan(/#{indentation}/).size
    end

    def clean line
      line.gsub(/^(#{indentation})*/, "")
    end

    def parent_of_last
      depth_of_last = @elements.last[:depth]
      return nil if depth_of_last == 0

      @elements.reverse.each do |e|
        return e[:depth] if e[:depth] < depth_of_last
      end
    end


    def children this_id
    end

    def indentations
      whitespaces = []
      @input.each do |line|
        v = line.match(/^\s*/).to_s
        whitespaces.push(v)
      end
      whitespaces.sort.uniq
    end

    def indentation_count
      return 0 if indentations.empty?
      return indentations.first.size if indentations.first.size == indentations.last.size
      indentations[-1].size - indentations[-2].size
    end

    def indentation_value
      return "" if indentations.empty?
      indentations.last.empty? ? "" : indentations.last.match(/^./).to_s
    end

  end
end
