# frozen_string_literal: true

# This class implements a Node within a Linked List.
class Node
  attr_accessor :value, :next

  def initialize(value)
    @value = value
    @next = nil
  end

  def to_s
    "( #{@value} ) -> #{@next ? @next.to_s : 'nil'}"
  end
end
