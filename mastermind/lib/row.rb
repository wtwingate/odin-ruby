# frozen_string_literal: true

require_relative 'constants'

class Row
  def initialize(guess, hints)
    @guess = guess
    @full_matches = hints[:full]
    @half_matches = hints[:half]
  end

  def draw
    @guess.each do |color|
      print " #{Constants::COLORIZED[color]} "
    end

    @full_matches.times do
      print Constants::HINTS[:full]
    end

    @half_matches.times do
      print Constants::HINTS[:half]
    end

    print "\n"
  end
end
