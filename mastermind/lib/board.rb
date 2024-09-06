# frozen_string_literal: true

require_relative 'row'

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

    @rows.reverse.each do |row|
      row.draw
    end
  end

  def update(guess, hints)
    @rows << Row.new(guess, hints)
  end

  private

  def empty_row_count
    12 - @rows.length
  end
end
