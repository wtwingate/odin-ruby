# frozen_string_literal: true

# This class implements a Linked List data structure.
class LinkedList
  attr_reader :head, :tail, :size

  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  def append(value)
    @size += 1

    new_node = Node.new(value)

    if @head.nil?
      @head = new_node
      @tail = new_node
      return self
    end

    @tail.next = new_node
    @tail = new_node

    self
  end

  def prepend(value)
    @size += 1

    new_node = Node.new(value)

    if @head.nil?
      @head = new_node
      @tail = new_node
      return self
    end

    new_node.next = @head
    @head = new_node

    self
  end

  def at(index)
    return nil if index.negative? || index >= @size

    current = @head
    index.times { current = current.next }

    current
  end

  def pop
    return nil if @head.nil?

    @size -= 1

    last_node = @tail
    current = @head

    if @size.zero?
      @head = nil
      @tail = nil
      return last_node
    end

    current = current.next until current.next == @tail

    @tail = current
    @tail.next = nil

    last_node
  end

  def contains?(value)
    return false if @head.nil?

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
    @head.to_s
  end

  def insert_at(value, index)
    return nil if index.negative? || index > @size
    return prepend(value) if index.zero?
    return append(value) if index == @size

    @size += 1

    new_node = Node.new(value)

    prev_node = at(index - 1)
    new_node.next = prev_node.next
    prev_node.next = new_node

    self
  end

  def remove_at(index)
    return nil if index.negative? || index >= @size
    return pop if index == @size - 1

    @size -= 1

    if index.zero?
      prev_head = @head
      @head = prev_head.next
      return prev_head
    end

    prev_node = at(index - 1)
    target = prev_node.next
    prev_node.next = target.next

    target
  end
end
