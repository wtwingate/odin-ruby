# frozen_string_literal: true

require_relative 'constants'

# This class represents the player who makes the secret code and
# provides hints to the code breaker.  The current implementation
# assumes the code maker is a computer.
class CodeMaker
  def initialize
    @secret_code = make_secret_code
  end

  def code_broken?(guess)
    @secret_code == guess
  end

  def give_hints(guess)
    {
      full: count_full_matches(guess),
      half: count_half_matches(guess)
    }
  end

  private

  def make_secret_code
    Array.new(4) { Constants::COLORS.sample }
  end

  def count_full_matches(guess)
    zipped = @secret_code.zip(guess)
    zipped.select { |pair| pair[0] == pair[1] }.count
  end

  def count_half_matches(guess)
    zipped = @secret_code.zip(guess)
    partial_code, partial_guess = zipped.filter { |z| z[0] != z[1] }.transpose

    # these variables are nil when all guesses are correct
    return 0 if partial_code.nil? || partial_guess.nil?

    partial_code.count do |color|
      partial_guess.include? color
    end
  end
end
