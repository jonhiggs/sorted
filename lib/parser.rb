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
      @elements.map {|e|
        i = @elements.index(e)
        next unless parents_of(i).include?(id)
        next if parents_of(id).include?(e[:parent])
        next if e[:parent].nil?
        i
      }.compact || []
    end

    def parent_of id
      id < size ? @elements[id][:parent] : nil
    end

    def parents_of id
      parents = []

      parent = parent_of(id)
      while !parent.nil?
        parents.push(parent)
        parent = parent_of(parent)
      end
      parents.sort
    end

    def siblings_of id
      if depth_of(id) == 0
        answer = []
        results = @elements.select{|e| e[:depth] == 0}
        results.each do |a|
          answer.push(@elements.index(a))
        end
        answer.delete(id)
        answer
      else
        r = @elements.map{|e| @elements.index(e) if e[:parent] == parent_of(id)}.compact
        r.delete(id)
        r
      end
    end

    def data_of id
      id < size ? @elements[id][:data] : nil
    end

    def depth_of id
      id < size ? @elements[id][:depth] : nil
    end

    def is_parent? id
      @elements.each do |e|
        return true if e[:parent] == id
      end
      false
    end

    def is_child? id
      !parent_of(id).nil?
    end

    def block_of id
      indexes = siblings_of(id).zip(children_of(id)).flatten.compact
      indexes.push(id).sort!.uniq!
      results = []
      @elements.each_with_index do |element,index|
        results.push(element) if indexes.include?(index)
      end
      results
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
        if e[:depth] < depth_of_last
          @answer = e
          break
        end
      end
      @elements.index(@answer)
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
