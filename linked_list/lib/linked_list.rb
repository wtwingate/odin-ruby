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

    node = Node.new(value)

    if @head.nil?
      @head = node
      @tail = node
      return self
    end

    @tail.next = node
    @tail = node

    self
  end

  def prepend(value)
    @size += 1

    node = Node.new(value)

    if @head.nil?
      @head = node
      @tail = node
      return self
    end

    node.next = @head
    @head = node

    self
  end

  def at(index)
    return nil if index >= @size

    current = @head
    index.times { current = current.next }

    current
  end

  def pop
    return nil if @head.nil?

    last_node = @tail
    current = @head

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

  def insert_at(index)
    # TODO: implement insert_at
  end

  def remove_at(index)
    # TODO: implement remove_at
  end
end
