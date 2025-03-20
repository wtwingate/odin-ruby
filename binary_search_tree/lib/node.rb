# frozen_string_literal: true

# This class implements a Node in a Binary Search Tree.
class Node
  include Comparable

  attr_accessor :value, :left, :right

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end

  def <=>(other)
    @value <=> other.value
  end
end
