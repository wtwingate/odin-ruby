# frozen_string_literal: true

require_relative 'constants'
require_relative 'player'

# This class represents the player whose goal is to break the secret
# code.  This implementation assumes that the code breaker is a human.
class CodeBreaker < Player
  def guess
    loop do
      print 'Enter your guess: '
      guess = clean_input(gets)

      return guess if valid_guess?(guess)
    end
  end

  private

  def clean_input(input)
    input.gsub(/\s/, '').upcase.split('')
  end

  def valid_guess?(input)
    input.all? { |c| Constants::COLORS.include? c }
  end
end
