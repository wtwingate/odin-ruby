# frozen_string_literal: true

require_relative 'constants'

# This class represents the player whose goal is to break the secret
# code.  This implementation assumes that the code breaker is a human.
class CodeBreaker
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
    input.length == 4 && input.all? { |c| Constants::COLORS.include? c }
  end
end
