# frozen_string_literal: true

# This module is responsible for displaying the game.
module Formatter
  def format_color_names
    Color::NAMES.values.join(', ')
  end

  def format_color_letters
    Color::LETTERS.values.join('/')
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

    segments = guess.map { |item| " #{Color::LETTERS[item]} |" }
    "|#{segments.join}"
  end

  def format_hint(hint)
    return '' if hint.nil?

    hint.map { |item| Color::HINTS[item] }.join
  end

  def format_secret(secret)
    secret.map { |item| Color::LETTERS[item] }.join
  end
end
