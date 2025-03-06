# frozen_string_literal: true

# This class implements the Mastermind game board.
class Board
  attr_reader :size, :guesses, :hints

  def initialize(size)
    @size = size
    @guesses = Array.new(size)
    @hints = Array.new(size)
    @next = 0
  end

  def update(guess, hint)
    @guesses[@next] = guess
    @hints[@next] = hint
    @next += 1
  end
end
