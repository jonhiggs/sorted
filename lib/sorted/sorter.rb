class Sorter
  module Sort
    def sort
    end

    def to_a
      result = []
      @order.each do |order|
        result.push(@elements.to_a[order])
      end
      result
    end

    def to_s
      to_a.map{|e| (@indentation.to_s * e[:depth]) + e[:data]}.join("\n")
    end

    #####
    private
    def insert_next_into_ordered_list
      children = sort_siblings_of_next
      parent = @elements.parent_of(children.first)
      if parent.nil?
        @order = children
      else
        children.reverse.each do |child|
          position = @order.index(parent) + 1
          @order.insert(position, child)
        end
      end
      @order
    end

    def sort_siblings_of_next
      next_id = get_next
      siblings = [ @elements.siblings_of(next_id),next_id].flatten.sort
      elements = elements_of_ids(siblings)
      elements.sort_by!{|e| e[:data]}
      elements.map{|e| e[:original_position]}
    end

    def elements_of_ids ids
      @elements.to_a.map{|e| e if ids.include?(e[:original_position])}.compact
    end

    def get_next
      @elements.to_a.each do |e|
        next if @order.include? e[:original_position]
        return e[:original_position] if e[:parent].nil?
      end
      @elements.to_a.each do |e|
        next if @order.include? e[:original_position]
        return e[:original_position]
      end
      nil
    end

  end

  class Dictionary
    require 'indentation'
    include Sorter::Sort

    def initialize input, config={}
      @indentation = Sorted::Indentation.new(input)
      @elements = Sorted::Parser.new(input)
      @order = []

      @config = {
        :type => "dictionary"
      }
    end
  end
end
