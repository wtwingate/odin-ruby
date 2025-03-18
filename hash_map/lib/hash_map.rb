# frozen_string_literal: true

# This class implements a Hash Map data structure.
class HashMap
  attr_accessor :size, :capacity
  
  def initialize
    @size = 0
    @load_factor = 0.75
    @capacity = 16
    @buckets = Array.new(@capacity)
  end

  # rubocop: disable Metrics/MethodLength
  def set(key, value)
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
    until current.next.nil?
      if current.key == key
        current.value = value

        return value
      end

      current = current.next
    end

    # add new key-value pair
    current.next = Node.new(key, value)
    @size += 1

    value
  end
  # rubocop: enable Metrics/MethodLength

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

  private

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char do |char|
      hash_code = (prime_number * hash_code) + char.ord
    end

    hash_code % @capacity
  end
end
