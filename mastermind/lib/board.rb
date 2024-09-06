# frozen_string_literal: true

require_relative 'row'

# This class represents the state of the game board and provides
# a method to draw it to the console.
class Board
  def initialize
    @rows = []
  end

  def full?
    @rows.length == 12
  end

  def draw
    empty_row_count.times do
      print "\n"
    end

    @rows.reverse.each(&:draw)
  end

  def update(guess, hints)
    @rows << Row.new(guess, hints)
  end

  private

  def empty_row_count
    12 - @rows.length
  end
end
