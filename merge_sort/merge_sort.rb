# frozen_string_literal: true

def merge_sort(arr)
  return arr if arr.length <= 1

  mid = arr.length / 2
  left = merge_sort(arr.take(mid))
  right = merge_sort(arr.drop(mid))

  merge(left, right)
end

def merge(left, right)
  merged = []

  until left.empty? || right.empty?
    merged << if left.first < right.first
                left.shift
              else
                right.shift
              end
  end

  merged + left + right
end

arr = Array.new(10) { Random.rand(100) }

puts "Unsorted: #{arr}"
puts "Sorted:   #{merge_sort(arr)}"
