# frozen_string_literal: true

# This class implements the Mastermind gameplay loop.
class Game
  include Formatter

  def initialize(size)
    @size = size
    @code_maker = Human.new
    @code_breaker = Human.new
    @secret = @code_maker.secret
    @board = Board.new(size)
    @turn = 0
    @guess = nil
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

    hint = []
    full_matches.times { hint << :full }
    half_matches.times { hint << :half }

    hint
  end

  # rubocop: disable Metrics/MethodLength
  def count_matches
    secret_counts = @secret.tally(Hash.new(0))
    guess_counts = @guess.tally(Hash.new(0))

    full_matches = 0
    @guess.each_with_index do |color, index|
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
