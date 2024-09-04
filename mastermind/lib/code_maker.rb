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

  def secret_code_broken?(guesses)
    @secret_code = guesses
  end

  def give_hints(guesses); end

  private

  def make_secret_code
    Array.new(4) { Constants::COLORS.sample }
  end
end
