# frozen_string_literal: true

require_relative 'constants'
require_relative 'player'

# This class represents the player who makes the secret code and
# provides hints to the code breaker.  The current implementation
# assumes the code maker is a computer.
class CodeMaker < Player
  def initialize(name)
    super
    @secret_code = make_secret_code
  end

  def solved?(guesses)
    @secret_code == guesses
  end

  def give_hints(guesses)
    {
      full: count_full_matches(guesses),
      half: count_half_matches(guesses)
    }
  end

  private

  def make_secret_code
    Array.new(4) { Constants::COLORS.sample }
  end

  def count_full_matches(guesses)
    zipped = @secret_code.zip(guesses)
    zipped.select { |pair| pair[0] == pair[1] }.count
  end

  def count_half_matches(guesses)
    zipped = @secret_code.zip(guesses)
    partial_code, partial_guesses = zipped.filter { |z| z[0] != z[1] }.transpose

    # these variables are nil when all guesses are correct
    return 0 if partial_code.nil? || partial_guesses.nil?

    partial_code.count do |color|
      partial_guesses.include? color
    end
  end
end
