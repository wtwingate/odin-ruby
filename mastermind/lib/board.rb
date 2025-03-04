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
    full_matches = count_full_matches(guess)
    half_matches = count_half_matches(guess) - full_matches

    hint = []
    full_matches.times { hint << :full }
    half_matches.times { hint << :half }

    hint
  end

  def count_full_matches(guess)
    full_matches = 0
    guess.each_with_index do |color, index|
      full_matches += 1 if @secret[index] == color
    end

    full_matches
  end

  def count_half_matches(guess)
    half_matches = 0
    guess.each do |color|
      half_matches += 1 if @secret.include? color
    end

    half_matches
  end
end
