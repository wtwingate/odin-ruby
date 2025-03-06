# frozen_string_literal: true

require_relative 'player'

# This class implements the methods for a Human player
class Human < Player
  include Formatter

  def guess(_board)
    puts "Enter your guess (#{format_color_letters}):"
    input
  end

  def secret
    puts "Enter your secret (#{format_color_letters}):"
    input
  end

  private

  def input
    loop do
      input = gets.chomp.upcase.chars

      next unless valid?(input)

      return input.map { |char| Color::INPUT[char] }
    end
  end

  def valid?(input)
    input.length == 4 && input.all? { |char| Color::INPUT.include?(char) }
  end
end
