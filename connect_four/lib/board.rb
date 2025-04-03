# frozen_string_literal: true

# This class is responsible for the state of the game board,
# and for testing whether the game over conditions have been met.
class Board
  NUM_COLS = 7
  NUM_ROWS = 6
  LINES = [
    [[0, 1], [0, 2], [0, 3]],
    [[1, 0], [2, 0], [3, 0]],
    [[1, 1], [2, 2], [3, 3]],
    [[1, -1], [2, -2], [3, -3]]
  ].freeze

  def initialize
    @grid = Array.new(NUM_COLS) { Array.new(NUM_ROWS) }
  end

  def place_token(token, col_idx)
    raise RuntimeError unless valid_move?(col_idx)

    token_idx = @grid[col_idx].find_index(nil)
    @grid[col_idx][token_idx] = token
  end

  def valid_move?(col_idx)
    return false unless col_idx >= 0 && col_idx < NUM_COLS

    @grid[col_idx].any? nil
  end

  def full?
    @grid.flatten.none? nil
  end

  def four_in_a_row?
    @grid.each_with_index do |column, x|
      column.each_with_index do |square, y|
        next if square.nil?

        LINES.each do |line|
          return true if winning_line?(line, x, y)
        end
      end
    end

    false
  end

  def pretty_print
    # TODO
  end

  private

  def winning_line?(line, x, y)
    line.each do |dx, dy|
      nx = x + dx
      ny = y + dy

      return false unless on_the_grid?(nx, ny)
      return false unless @grid[x][y] == @grid[nx][ny]
    end

    true
  end

  def on_the_grid?(x, y)
    x >= 0 && x < NUM_COLS && y >= 0 && y < NUM_ROWS
  end
end
