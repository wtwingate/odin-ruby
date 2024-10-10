# frozen_string_literal: true

require_relative 'node'

class HashMap
  attr_reader :capacity, :length, :load_factor, :buckets

  def initialize
    @capacity = 16
    @length = 0
    @load_factor = 0.75
    @buckets = Array.new(@capacity)
  end

  def set(key, value)
    node = Node.new(key, value)

    resize if overloaded?

    index = hash(key) % @buckets.length

    if @buckets[index].nil?
      @length += 1
      @buckets[index] = node
    else
      current = @buckets[index]
      previous = nil

      until current.nil?
        if current.key == key
          current.value = value
          return
        end

        previous = current
        current = current.next
      end

      @length += 1
      previous.next = node
    end
  end

  def get(key)
    index = hash(key) % @buckets.length

    return nil if @buckets[index].nil?

    current = @buckets[index]

    until current.nil?
      return current.value if current.key == key

      current = current.next
    end

    nil
  end

  def has?(key)
    !get(key).nil?
  end

  def remove(key)
    index = hash(key) % @buckets.length

    return nil if @buckets[index].nil?

    current = @buckets[index]
    previous = nil

    until current.nil?
      if current.key == key
        value = current.value

        if previous.nil?
          @buckets[index] = nil
        else
          previous.next = current.next
        end

        @length -= 1
        return value
      else
        previous = current
        current = current.next
      end
    end

    nil
  end

  def clear
    @capacity = 16
    @length = 0
    @buckets = Array.new(@capacity)
  end

  def keys
    keys = []

    @buckets.each do |bucket|
      next if bucket.nil?

      current = bucket

      until current.nil?
        keys << current.key
        current = current.next
      end
    end

    keys
  end

  def values
    values = []

    @buckets.each do |bucket|
      next if bucket.nil?

      current = bucket

      until current.nil?
        values << current.value
        current = current.next
      end
    end

    values
  end

  def entries
    entries = []

    @buckets.each do |bucket|
      next if bucket.nil?

      current = bucket

      until current.nil?
        entries << [current.key, current.value]
        current = current.next
      end
    end

    entries
  end

  private

  def overloaded?
    @length + 1 > @capacity * @load_factor
  end

  def resize
    contents = entries
    @capacity *= 2
    @length = 0
    @buckets = Array.new(@capacity)

    contents.each do |key, value|
      set(key, value)
    end
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char do |char|
      hash_code = prime_number * hash_code + char.ord
    end

    hash_code
  end

  def check_index(index)
    raise IndexError if index.negative? || index >= @buckets.length
  end
end
