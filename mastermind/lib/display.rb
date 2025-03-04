# frozen_string_literal: true

# This class is responsible for displaying the game.
class Display
  def initialize(board)
    @board = board
  end

  def game_start
    puts <<~HEREDOC
      *** MASTERMIND ***

      The object of this game is to deduce the secret code before running
      out of guesses. The code is a random configuration of four colors.
      The possible colors are #{format_colors}.

      After each guess, you'll receive feedback in the form of colored pegs:
        - #{Colors::DISPLAY[:full]} indicates a peg with the correct color in the correct position.
        - #{Colors::DISPLAY[:half]} indicates a peg with the correct color in the wrong position.

      You have #{@board.size} guesses to crack the code. Good luck!
    HEREDOC
  end

  def game_loop
    puts format_board
  end

  def game_over(won, secret)
    puts format_board

    if won
      puts 'Congrats! You cracked the secret code!'
    else
      puts 'Sorry! You ran out of guesses!'
    end

    puts "The secret code was #{format_secret(secret)}"
  end

  def input_prompt
    puts "Enter your guess (#{format_colors_abbrev}):"
  end

  private

  def format_colors
    "#{Colors::NAMES[:red]}, " \
      "#{Colors::NAMES[:green]}, " \
      "#{Colors::NAMES[:blue]}, " \
      "#{Colors::NAMES[:cyan]}, " \
      "#{Colors::NAMES[:magenta]} and " \
      "#{Colors::NAMES[:yellow]}"
  end

  def format_colors_abbrev
    "#{Colors::DISPLAY[:red]}/" \
      "#{Colors::DISPLAY[:green]}/" \
      "#{Colors::DISPLAY[:blue]}/" \
      "#{Colors::DISPLAY[:cyan]}/" \
      "#{Colors::DISPLAY[:magenta]}/" \
      "#{Colors::DISPLAY[:yellow]}"
  end

  def format_board
    formatted_rows = []
    @board.size.times do |index|
      formatted_rows << format_row(index)
    end

    formatted_rows.reverse.join("\n")
  end

  def format_row(index)
    guess = format_guess(@board.guesses[index])
    hint = format_hint(@board.hints[index])
    "#{guess} #{hint}"
  end

  def format_guess(guess)
    return '|   |   |   |   |' if guess.nil?

    segments = guess.map { |item| " #{Colors::DISPLAY[item]} |" }
    "|#{segments.join}"
  end

  def format_hint(hint)
    return '' if hint.nil?

    hint.map { |item| Colors::DISPLAY[item] }.join
  end

  def format_secret(secret)
    secret.map { |item| Colors::DISPLAY[item] }.join
  end
end
