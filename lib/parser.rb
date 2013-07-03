module Sorted
  class Parser
    def initialize input
      @input = input.split("\n")
      @id_counter = 0
    end

    def input() @input end

    def find_indentations
      whitespaces = []
      input.each do |line|
        v = line.match(/^\s*/).to_s
        whitespaces.push(v)
      end
      whitespaces.sort.uniq
    end

    def indentation_count
      indents = find_indentations
      return indents.first.size if indents.first.size == indents.last.size
      indents[-1].size - indents[-2].size
    end

    def indentation_value
      find_indentations.last.empty? ? "" : find_indentations.last.match(/^./).to_s
    end

    def output
      out = []
      input.each do |line|
        out.push({ :depth => depth(line), :data => clean(line) })
      end
      out.map!{|l| generate_id(l)}
    end

    def generate_id element
      element[:id] = @id_counter
      @id_counter = @id_counter + 1
      element
    end

    def indent
      "#{indentation_value}" * indentation_count
    end

    private
    def depth line
      return 0 if indent.empty?
      leading_whitespace = line.match(/^#{indent}*/).to_s
      leading_whitespace.scan(/#{indent}/).size
    end

    private
    def clean line
      line.gsub(/^(#{indent})*/, "")
    end

  end
end
