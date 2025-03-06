# frozen_string_literal: true

require_relative 'player'

# This class implements the methods for a Computer player
class Computer < Player
  def initialize
    super
    @possible = Set.new(Color::SYMBOLS.repeated_permutation(4))
  end

  def guess(board)
    puts 'Calculating next guess...'
    sleep(1)

    return %i[red red green green] if board.last_guess.nil?

    last_guess = board.last_guess
    last_hint = board.last_hint

    @possible.filter! do |code|
      compare(last_guess, code) == last_hint
    end

    @possible.first
  end

  def secret
    puts 'Generating secret code...'
    sleep(1)

    Array.new(4) { Color::SYMBOLS.sample }
  end
end
