# frozen_string_literal: true

# This class implements the Mastermind game board.
class Board
  attr_reader :size, :guesses, :hints

  def initialize(size, secret)
    @size = size
    @secret = secret
    @guesses = Array.new(size)
    @hints = Array.new(size)
    @next = 0
  end

  def update(guess)
    @guesses[@next] = guess
    hint = generate_hint(guess)
    @hints[@next] = hint
    @next += 1
  end

  private

  def generate_hint(guess)
    full_matches, half_matches = count_matches(guess)

    hint = []
    full_matches.times { hint << :full }
    half_matches.times { hint << :half }

    hint
  end

  # rubocop: disable Metrics/MethodLength
  def count_matches(guess)
    secret_counts = @secret.tally(Hash.new(0))
    guess_counts = guess.tally(Hash.new(0))

    full_matches = 0
    guess.each_with_index do |color, index|
      if @secret[index] == color
        full_matches += 1
        secret_counts[color] -= 1
      end
    end

    half_matches = guess_counts.keys.reduce(0) do |sum, color|
      sum + [secret_counts[color], guess_counts[color]].min
    end

    [full_matches, half_matches]
  end
  # rubocop: enable Metrics/MethodLength
end
