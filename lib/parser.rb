module Sorted
  class Parser
    def initialize input, config={}
      @input = input.split("\n")
      @config = config
      @config[:indentation] = indentation unless @config.has_key?(:indentation)
      @elements = create_structure
    end

    def output
      @elements
    end

    def indentation
      return @config[:indentation] if @config.has_key?(:indentation)
      @config[:indentation] = "#{indentation_value}" * indentation_count
    end

    def data_of id
      @elements.each do |element|
        return element[:data] if element[:id] == id
      end
    end

    def children_of id
      @children = []

      @elements.each do |element|
        if element[:id] == id
          @depth_of_children = element[:depth] + 1
          @found = true
          next
        end

        if @found
          return @children if element[:depth] != @depth_of_children
          @children.push(element[:id])
        else
          next
        end
      end
      @children
    end

    ##########################################################
    private

    def create_structure
      elements = []
      @input.each do |line|
        elements.push({
          :id => id,
          :data => clean(line),
          :depth => depth(line)
        })
      end
      elements
    end

    def depth line
      return 0 if indentation.empty?
      leading_whitespace = line.match(/^#{indentation}*/).to_s
      leading_whitespace.scan(/#{indentation}/).size
    end

    def clean line
      line.gsub(/^(#{indentation})*/, "")
    end

    def id
      @config[:id_counter] = -1 unless @config.has_key?(:id_counter)
      @config[:id_counter] += 1
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
      return indentations.first.size if indentations.first.size == indentations.last.size
      indentations[-1].size - indentations[-2].size
    end

    def indentation_value
      indentations.last.empty? ? "" : indentations.last.match(/^./).to_s
    end

  end
end
