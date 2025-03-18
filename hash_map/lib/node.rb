# frozen_string_literal: true

# This class implements a key-value pair in a Hash Map.
class Node
  attr_accessor :key, :value, :next

  def initialize(key, value)
    @key = key
    @value = value
    @next = nil
  end

  def to_s
    "( #{@key}: #{@value} ) -> #{@next.nil? ? 'nil' : @next}"
  end
end
