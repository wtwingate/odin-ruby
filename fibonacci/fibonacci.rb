# frozen_string_literal: true

def fibs(num)
  return [] if num.zero?
  return [0] if num == 1

  result = [0, 1]
  (num - 2).times do
    result << result.last(2).sum
  end

  result
end

p fibs(8) #=> [0, 1, 1, 2, 3, 5, 8, 13]

def fibs_rec(num)
  case num
  when 0 then []
  when 1 then [0]
  when 2 then [0, 1]
  else
    result = fibs_rec(num - 1)
    result << result.last(2).sum
  end
end

p fibs_rec(8) #=> [0, 1, 1, 2, 3, 5, 8, 13]
