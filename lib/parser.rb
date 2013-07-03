module Sorted
  class Parser
    def initialize input, config={}
      @input = input.split("\n")
      @config = config
      @config[:indentation] = indentation unless @config.has_key?(:indentation)
      @data = create_structure
      @data
    end

    def output
      @data
    end

    def indentation
      return @config[:indentation] if @config.has_key?(:indentation)
      @config[:indentation] = "#{indentation_value}" * indentation_count
    end

    private
    def create_structure
      data = []
      @input.each do |line|
        data.push({
          :id => id,
          :data => clean(line),
          :depth => depth(line)
        })
      end
      data
    end

    private
    def depth line
      return 0 if indentation.empty?
      leading_whitespace = line.match(/^#{indentation}*/).to_s
      leading_whitespace.scan(/#{indentation}/).size
    end

    private
    def clean line
      line.gsub(/^(#{indentation})*/, "")
    end

    private
    def id
      @config[:id_counter] = -1 unless @config.has_key?(:id_counter)
      @config[:id_counter] += 1
    end

    private
    def indentations
      whitespaces = []
      @input.each do |line|
        v = line.match(/^\s*/).to_s
        whitespaces.push(v)
      end
      whitespaces.sort.uniq
    end

    private
    def indentation_count
      return indentations.first.size if indentations.first.size == indentations.last.size
      indentations[-1].size - indentations[-2].size
    end

    private
    def indentation_value
      indentations.last.empty? ? "" : indentations.last.match(/^./).to_s
    end

  end
end
