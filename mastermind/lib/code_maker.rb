# frozen_string_literal: true

require_relative 'game'

# This class implements a version of the Mastermind game where the user plays
# as the Code Maker.
class CodeMaker < Game
  def initialize
    super
    @code = enter_code
    @possible = Set.new(Colors::SYMBOLS.repeated_permutation(4))
  end

  def play
    until over?
      puts @board

      guess = generate_guess
      hint = enter_hint(guess)
      @board.update(guess, hint)

      @turn += 1
    end

    puts @board
    puts end_message
  end

  private

  def enter_code
    puts "Enter your secret code (#{Colors::LETTERS.values.join('/')}):"
    color_input
  end

  def generate_guess
    puts 'Calculating next guess...'
    sleep(1)

    return %i[red red green green] if @board.last_guess.nil?

    last_guess = @board.last_guess
    last_hint = @board.last_hint

    @possible.filter! do |code|
      compare(last_guess, code) == last_hint
    end

    @possible.first
  end

  def enter_hint(guess)
    puts "Guess: #{format_code(guess)}"
    puts "Code:  #{format_code(@code)}"
    puts "Enter a hint ('F' for full matches; 'H' for half matches):"
    loop do
      hint = hint_input

      return hint if hint == compare(guess, @code)

      puts "Oops! That hint isn't quite right..."
    end
  end

  def end_message
    if code_cracked?
      'Dangit! The computer cracked your code!'
    else
      'Wow! This should never happen!'
    end
  end
end
