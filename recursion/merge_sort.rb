def merge_sort(arr)
  return arr if arr.size == 1

  mid = arr.size / 2
  left = merge_sort arr[0...mid]
  right = merge_sort arr[mid..-1]

  sorted = []

  until left.empty? || right.empty?
    if left[0] < right[0]
      sorted << left.shift
    else
      sorted << right.shift
    end
  end

  until left.empty?
    sorted << left.shift
  end

  until right.empty?
    sorted << right.shift
  end

  sorted
end

arr = Array.new(10) { rand(0..9) }

p merge_sort arr
