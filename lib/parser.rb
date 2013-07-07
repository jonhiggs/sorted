module Sorted
  class Parser
    def initialize input, config={}
      @elements = []
      @input = input.split("\n")
      @config = config
      @config[:indentation] = indentation unless @config.has_key?(:indentation)
      @input.each do |line|
        push(line)
      end
    end

    def to_a
      @elements
    end

    def size
      @elements.size
    end

    def push line
      @elements.push({
        :data => clean(line),
        :depth => depth(line)
      })
    end

    def indentation
      return @config[:indentation] if @config.has_key?(:indentation)
      @config[:indentation] = "#{indentation_value}" * indentation_count
    end

    def children_of id
      id < size ? @elements[id][:children] : nil
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

    def children elements,this_id
      children = []

      elements.each do |k,element|
        if k == this_id
          @depth_of_children = element[:depth] + 1
          #puts "setting depth to: #{@depth_of_children.inspect}"
          @found = true
          next
        end

        if @found
          return children if element[:depth] != @depth_of_children
          children.push(k)
        else
          next
        end
      end
      children
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
