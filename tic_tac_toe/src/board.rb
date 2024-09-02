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
    "\n"\
    " #{@squares[0]} | #{@squares[1]} | #{@squares[2]}\n"\
    "___________\n"\
    " #{@squares[3]} | #{@squares[4]} | #{@squares[5]}\n"\
    "___________\n"\
    " #{@squares[6]} | #{@squares[7]} | #{@squares[8]}\n"\
    "\n"
  end

  private

  def create_squares
    (1..9).each do |number|
      @squares << Square.new(number)
    end
  end
end
