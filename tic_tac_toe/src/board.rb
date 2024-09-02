# frozen_string_literal: true

require_relative 'square'

# Class representing the board in a game of Tic-tac-toe.
class Board
  attr_reader :squares

  def initialize
    @squares = []
    create_squares
  end

  def to_s
    " #{@squares[0]} | #{@squares[1]} | #{@squares[2]}\n"\
    "___________\n"\
    " #{@squares[3]} | #{@squares[4]} | #{@squares[5]}\n"\
    "___________\n"\
    " #{@squares[6]} | #{@squares[7]} | #{@squares[8]}\n"
  end

  def three_in_a_row?
    WIN_CONDITIONS.each do |wc|
      mark1 = @squares[wc[0]].mark
      mark2 = @squares[wc[1]].mark
      mark3 = @squares[wc[2]].mark

      next if mark1.nil? || mark2.nil? || mark3.nil?

      return true if mark1 == mark2 && mark2 == mark3
    end
    false
  end

  private

  WIN_CONDITIONS = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], # horizontal
    [0, 3, 6], [1, 4, 7], [2, 5, 8], # vertical
    [0, 4, 8], [2, 4, 6]             # diagonal
  ].freeze

  def create_squares
    (1..9).each do |number|
      @squares << Square.new(number)
    end
  end
end
