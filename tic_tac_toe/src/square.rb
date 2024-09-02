# frozen_string_literal: true

# Class representing a single square on a Tic-tac-toe board.
class Square
  attr_accessor :mark
  attr_reader :number

  def initialize(number)
    @number = number
    @mark = nil
  end

  def markable?
    @mark.nil?
  end

  def to_s
    @mark ? @mark.to_s : @number.to_s
  end
end
