def fibonacci(n)
  sequence = []

  n.times do |i|
    if i == 0
      sequence << 0
    elsif i == 1
      sequence << 1
    else
      sequence << sequence[i - 1] + sequence[i - 2]
    end
  end
  
  sequence
end

def fibonacci_r(n)
  return [ 0, 1 ] if n == 2

  sequence = fibonacci_r(n - 1)
  sequence << sequence[-2] + sequence[-1]
end

p fibonacci 10 
p fibonacci_r 10
