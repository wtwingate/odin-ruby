#frozen_string_literal: true

class Board
  COLUMNS = 7
  ROWS = 6
  LINES = [
    [[0, 1], [0, 2], [0, 3]],
    [[1, 0], [2, 0], [3, 0]],
    [[1, 1], [2, 2], [3, 3]],
    [[1, -1], [2, -2], [3, -3]]
  ].freeze
  
  def initialize
    @grid = Array.new(COLUMNS) { Array.new(ROWS) }
  end

  def full?
    @grid.flatten.none? nil
  end

  def column_full?(index)
    @grid[index].none? nil
  end

  def four_in_a_row?
    @grid.each_with_index do |column, x|
      column.each_with_index do |square, y|
        next if square.nil?
        
        return true if on_some_line?(x, y)
      end
    end

    false
  end

  private

  def on_some_line?(x, y)
    LINES.each do |line|
      winning_line = true
      line.each do |dx, dy|
        nx = x + dx
        ny = y + dy

        if off_the_grid?(nx, ny) || @grid[x][y] != @grid[nx][ny]
          winning_line = false
          break
        end
      end

      return true if winning_line
    end

    false
  end

  def off_the_grid?(x, y)
    x < 0 || x >= COLUMNS || y < 0 || y >= ROWS
  end
end
