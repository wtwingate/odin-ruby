# frozen_string_literal: true

KNIGHT_DELTAS = [
  [1, 2],
  [2, 1],
  [2, -1],
  [1, -2],
  [-1, -2],
  [-2, -1],
  [-2, 1],
  [-1, 2]
].freeze

def next_squares(square)
  all_moves = KNIGHT_DELTAS.map do |delta|
    square.zip(delta).map(&:sum)
  end

  all_moves.select do |x, y|
    x >= 0 && x <= 7 && y >= 0 && y <= 7
  end
end

# rubocop: disable Metrics/MethodLength
def find_path(start_square, end_square)
  history = { start_square => nil }
  queue = [start_square]

  until queue.empty?
    square = queue.shift
    return format_path(square, history) if square == end_square

    next_squares(square).each do |next_square|
      next if history.include?(next_square)

      history[next_square] = square
      queue << next_square
    end
  end
end
# rubocop: enable Metrics/MethodLength

def format_path(square, history)
  path = []

  until square.nil?
    path << square
    square = history[square]
  end

  path.reverse
end

def knight_moves(start_square, end_square)
  path = find_path(start_square, end_square)

  puts "You made it in #{path.length - 1} moves! Here's your path:"
  path.each { |square| p square }
end

knight_moves([0, 0], [0, 0])
knight_moves([0, 0], [3, 3])
knight_moves([0, 0], [7, 7])
knight_moves([3, 3], [4, 3])
