require 'formatter'
require 'indentation'

module Sorted
  class Parser
    include Formatter
    def initialize input, config={}
      @input = input
      @elements = []
      @config = config
      push(input)
    end

    def push input
      @input += input
      @indentation = Sorted::Indentation.new(@input)

      input.split("\n").each do |line|
        @elements.push({
          :data => clean(line),
          :depth => depth(line)
        })
        @elements.last[:parent] = parent_of_last
      end
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
      @elements.each {|e| return true if e[:parent] == id }
      false
    end

    def is_child? id
      !parent_of(id).nil?
    end

    def block_of id
      elements = [id, children_of(id), siblings_of(id)].flatten.sort
      elements.map{|index| @elements[index] }
    end

    ##########################################################
    private
    def depth line
      return 0 if @indentation.to_s.empty?
      leading_whitespace = line.match(/^#{@indentation.to_s}*/).to_s
      leading_whitespace.scan(/#{@indentation.to_s}/).size
    end

    def clean line
      line.gsub(/^(#{@indentation.to_s})*/, "")
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

  end
end
