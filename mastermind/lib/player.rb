# frozen_string_literal: true

# This class provides a common interface for Human and Computer players.
class Player
  def guess(_board)
    raise NotImplementedError "#{self.class} does not implement #{__method__}"
  end

  def secret
    raise NotImplementedError "#{self.class} does not implement #{__method__}"
  end

  def hint(guess, secret)
    compare(guess, secret)
  end

  private

  # rubocop: disable Metrics/MethodLength
  def compare(guess, secret)
    matches = []
    secret_counts = Hash.new(0)

    # Count full matches and build hash of remaining secret colors
    secret.each_with_index do |color, index|
      if guess[index] == color
        matches << :full
      else
        secret_counts[color] += 1
      end
    end

    # Count half matches from guess positions that weren't a full match
    guess.each_with_index do |color, index|
      next if secret[index] == color # Skip full matches

      unless secret_counts[color].zero?
        matches << :half
        secret_counts[color] -= 1
      end
    end

    matches
  end
  # rubocop: enable Metrics/MethodLength
end
