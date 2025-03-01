# frozen_string_literal: true

class Board
  LINES = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ].freeze

  def initialize
    @squares = Array.new(9, nil)
  end

  def place_mark(mark, number)
    @squares[number] = mark
  end

  def square_empty?(number)
    @squares[number].nil?
  end

  def winner?
    LINES.each do |a, b, c|
      return true if @squares[a] && @squares[a] == @squares[b] && @squares[a] == @squares[c]
    end

    false
  end

  def to_s
    <<~BOARD
       #{@squares[0] || '1'} | #{@squares[1] || '2'} | #{@squares[2] || '3'}
      ---+---+---
       #{@squares[3] || '4'} | #{@squares[4] || '5'} | #{@squares[5] || '6'}
      ---+---+---
       #{@squares[6] || '7'} | #{@squares[7] || '8'} | #{@squares[8] || '9'}

    BOARD
  end
end
