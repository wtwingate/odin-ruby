# frozen_string_literal: true

def bubble_sort(array)
  array_copy = array.clone

  last = array.size - 1
  sorted = false
  until sorted
    sorted = true
    (0...last).each do |i|
      if array_copy[i] > array_copy[i + 1]
        array_copy[i], array_copy[i + 1] = array_copy[i + 1], array_copy[i]
        sorted = false
      end
    end
    last -= 1
  end

  array_copy
end

array = Array.new(10) { Random.rand(100) }
p bubble_sort(array)
