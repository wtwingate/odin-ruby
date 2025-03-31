#frozen_string_literal: true

class Board
  def initialize
    @grid = Array.new(7) { Array.new(6) }
  end

  def full?
    @grid.flatten.none? nil
  end

  def column_full?(index)
    @grid[index].none? nil
  end
end
