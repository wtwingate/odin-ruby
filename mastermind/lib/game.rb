# frozen_string_literal: true

# This class implements the Mastermind gameplay loop.
class Game
  include Formatter

  def initialize(code_maker, code_breaker)
    @size = 12
    @board = Board.new(@size)
    @code_maker = code_maker
    @code_breaker = code_breaker
    @secret = @code_maker.secret
    @turn = 0
  end

  def play
    until over?
      puts format_board
      guess = @code_breaker.guess(@board)
      hint = @code_maker.hint(guess, @secret)
      @board.update(guess, hint)
      @turn += 1
    end

    puts format_board
    end_screen
  end

  private

  def won?
    @board.last_guess == @secret
  end

  def over?
    won? || @turn == @size
  end

  def valid?(input)
    input.length == 4 && input.all? { |char| Color::INPUT.include?(char) }
  end

  def give_hint
    compare
  end

  def end_screen
    if won? && @code_breaker.is_a?(Human)
      puts 'Congrats! You cracked the secret code!'
    elsif won? && @code_breaker.is_a?(Computer)
      puts 'Dangit! Your secret code was cracked!'
    elsif @code_breaker.is_a?(Human)
      puts 'Sorry! You ran out of guesses!'
    elsif @code_breaker.is_a?(Computer)
      puts 'Wow! This is literally impossible!'
    end

    puts "The secret code was #{format_secret(@secret)}"
  end
end
