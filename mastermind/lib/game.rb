# frozen_string_literal: true

# This class implements the Mastermind gameplay loop.
class Game
  include Formatter

  def initialize(size)
    @size = size
    @board = Board.new(size)
    @code_maker = Human.new
    @code_breaker = Human.new
    @secret = @code_maker.secret
    @guess = nil
    @turn = 0
  end

  def play
    start_screen

    until over?
      puts format_board
      @guess = @code_breaker.guess
      @board.update(@guess, give_hint)
      @turn += 1
    end

    end_screen
  end

  private

  def won?
    @guess == @secret
  end

  def over?
    won? || @turn == @size
  end

  def valid?(input)
    input.length == 4 && input.all? { |char| Color::INPUT.include?(char) }
  end

  def give_hint
    full_matches, half_matches = count_matches

    ([:full] * full_matches) + ([:half] * half_matches)
  end

  # rubocop: disable Metrics/MethodLength
  def count_matches
    full_matches = 0
    half_matches = 0
    secret_counts = Hash.new(0)

    # Count full matches and build hash of remaining secret colors
    @secret.each_with_index do |color, index|
      if @guess[index] == color
        full_matches += 1
      else
        secret_counts[color] += 1
      end
    end

    # Count half matches from guess positions that weren't a full match
    @guess.each_with_index do |color, index|
      next if @secret[index] == color # Skip full matches

      unless secret_counts[color].zero?
        half_matches += 1
        secret_counts[color] -= 1
      end
    end

    [full_matches, half_matches]
  end
  # rubocop: enable Metrics/MethodLength

  def start_screen
    puts <<~HEREDOC
      *** MASTERMIND ***

      The object of this game is to deduce the secret code before running
      out of guesses. The code is a random configuration of four colors.
      The possible colors are #{format_color_names}.

      After each guess, you'll receive feedback in the form of colored pegs:
        - #{Color::HINTS[:full]} indicates a peg with the correct color in the correct position.
        - #{Color::HINTS[:half]} indicates a peg with the correct color in the wrong position.

      You have #{@board.size} guesses to crack the code. Good luck!
    HEREDOC
  end

  def end_screen
    puts format_board

    if won?
      puts 'Congrats! You cracked the secret code!'
    else
      puts 'Sorry! You ran out of guesses!'
    end

    puts "The secret code was #{format_secret(@secret)}"
  end
end
