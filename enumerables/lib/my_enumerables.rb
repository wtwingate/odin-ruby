module Enumerable
  # Your code goes here
  def my_each_with_index
    index = 0
    self.my_each do |element|
      yield(element, index)
      index += 1
    end

    self
  end

  def my_select
    matches = []
    self.my_each do |element|
      matches << element if yield(element)
    end

    matches
  end

  def my_all?
    self.my_each do |element|
      return false unless yield(element)
    end

    true
  end

  def my_any?
    self.my_each do |element|
      return true if yield(element)
    end

    false
  end

  def my_none?
    self.my_each do |element|
      return false if yield(element)
    end

    true
  end

  def my_count
    return self.size unless block_given?

    count = 0
    self.my_each do |element|
      count += 1 if yield(element)
    end

    count
  end

  def my_map
    arr = []
    self.my_each do |element|
      arr << yield(element)
    end

    arr
  end

  def my_inject(init)
    memo = init
    self.my_each do |element|
      memo = yield(memo, element)
    end

    memo
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method

class Array
  # Define my_each here
  def my_each
    for element in self
      yield element
    end

    self
  end
end
