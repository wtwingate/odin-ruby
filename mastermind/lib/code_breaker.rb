# frozen_string_literal: true

require_relative 'game'

# This class implements a version of the Mastermind game where the user plays
# as the Code Breaker.
class CodeBreaker < Game
  def initialize
    super
    @code = generate_code
  end

  def play
    until over?
      puts @board

      guess = enter_guess
      hint = generate_hint(guess)
      @board.update(guess, hint)

      @turn += 1
    end

    puts @board
    puts end_message
  end

  private

  def generate_code
    Array.new(4) { Colors::SYMBOLS.sample }
  end

  def enter_guess
    puts "Enter your guess (#{Colors::LETTERS.values.join('/')}):"
    color_input
  end

  def generate_hint(guess)
    compare(guess, @code)
  end

  def end_message
    message = []
    message << if code_cracked?
                 'Congrats! You cracked the code!'
               else
                 'Sorry! You ran out of guesses!'
               end
    message << "The secret code was #{format_code(@code)}"
    message.join("\n")
  end
end
