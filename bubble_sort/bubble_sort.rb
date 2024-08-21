def bubble_sort(array)
  array.length.times do
    array.each_index do |i|
      array[i], array[i + 1] = array[i + 1], array[i] if array[i + 1] && array[i] > array[i + 1]
    end
  end
end

array = [4, 3, 78, 2, 0, 2]
bubble_sort(array)
p array
