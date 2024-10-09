# frozen_string_literal: true

require_relative 'node'

class LinkedList
  attr_accessor :head, :tail, :size

  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  def append(value)
    new_node = Node.new(value)

    @tail.next = new_node unless @tail.nil?
    @tail = new_node
    @head = new_node if @head.nil?

    @size += 1
  end

  def prepend(value)
    new_node = Node.new(value)

    new_node.next = @head unless @head.nil?
    @head = new_node
    @tail = new_node if @tail.nil?

    @size += 1
  end

  def at(index)
    return nil if index >= @size

    current = @head

    index.times { current = current.next }

    current
  end

  def pop
    return nil if @tail.nil?

    current = @head

    until current.next == @tail
      current = current.next
    end

    temp = @tail

    current.next = nil
    @tail = current

    @size -= 1

    temp
  end

  def contains?(value)
    return nil if @head.nil?

    current = @head

    until current.nil?
      return true if current.value == value
      current = current.next
    end

    false
  end

  def find(value)
    return nil if @head.nil?

    index = 0
    current = @head

    until current.nil?
      return index if current.value == value

      current = current.next
      index += 1
    end

    nil
  end

  def to_s
    string = ""

    current = @head

    until current.nil?
      string += "( #{current.value} ) -> "
      current = current.next
    end

    string += "nil"
  end
end
