# frozen_string_literal: true

# This class implements a Hash Map data structure.
# rubocop: disable Metrics/ClassLength
class HashMap
  attr_reader :size, :capacity

  def initialize
    @size = 0
    @load_factor = 0.75
    @capacity = 16
    @buckets = Array.new(@capacity)
  end

  # rubocop: disable Metrics/MethodLength, Metrics/AbcSize
  def set(key, value)
    grow if @size.to_f / @capacity >= @load_factor

    index = hash(key)

    # no hash collision
    if @buckets[index].nil?
      @buckets[index] = Node.new(key, value)
      @size += 1

      return value
    end

    # hash collision
    current = @buckets[index]

    # update value for existing key
    loop do
      if current.key == key
        current.value = value

        return value
      end

      break if current.next.nil?

      current = current.next
    end

    # add new key-value pair
    current.next = Node.new(key, value)
    @size += 1

    value
  end
  # rubocop: enable Metrics/MethodLength, Metrics/AbcSize

  def get(key)
    index = hash(key)

    return nil if @buckets[index].nil?

    current = @buckets[index]

    until current.nil?
      return current.value if current.key == key

      current = current.next
    end

    nil
  end

  def has?(key)
    !!get(key)
  end

  # rubocop: disable Metrics/MethodLength
  def remove(key)
    index = hash(key)

    return nil if @buckets[index].nil?

    prev = nil
    current = @buckets[index]

    until current.nil?
      unless current.key == key
        prev = current
        current = current.next
        next
      end

      if prev.nil? # first node in bucket
        @buckets[index] = current.next
      else
        prev.next = current.next
      end

      @size -= 1
      return current.value
    end

    nil
  end
  # rubocop: enable Metrics/MethodLength

  def length
    @size
  end

  def clear
    @size = 0
    @capacity = 16
    @buckets = Array.new(@capacity)
  end

  def keys
    data = entries

    data.map { |key, _value| key }
  end

  def values
    data = entries

    data.map { |_key, value| value }
  end

  def entries
    data = []

    @buckets.each do |bucket|
      next if bucket.nil?

      current = bucket

      until current.nil?
        data << [current.key, current.value]
        current = current.next
      end
    end

    data
  end

  private

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char do |char|
      hash_code = (prime_number * hash_code) + char.ord
    end

    hash_code % @capacity
  end

  def grow
    data = entries

    @size = 0
    @capacity *= 2
    @buckets = Array.new(@capacity)

    data.each do |key, value|
      set(key, value)
    end
  end
end
# rubocop: enable Metrics/ClassLength
