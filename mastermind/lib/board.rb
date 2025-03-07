# frozen_string_literal: true

# This class implements the Mastermind game board.
class Board
  def initialize(size)
    @size = size
    @guesses = Array.new(size)
    @hints = Array.new(size)
    @next = 0
  end

  def update(guess, hint)
    @guesses[@next] = guess
    @hints[@next] = hint
    @next += 1
  end

  def last_guess
    @guesses[@next - 1]
  end

  def last_hint
    @hints[@next - 1]
  end

  def to_s
    format_board
  end

  private

  def format_board
    formatted_rows = []
    @size.times do |index|
      formatted_rows << format_row(index)
    end

    <<~BOARD
      -----------------
      #{formatted_rows.reverse.join("\n")}
      -----------------
    BOARD
  end

  def format_row(index)
    guess = format_guess(@guesses[index])
    hint = format_hint(@hints[index])
    "#{guess} #{hint}"
  end

  def format_guess(guess)
    return '|   |   |   |   |' if guess.nil?

    segments = guess.map { |item| " #{Colors::LETTERS[item]} |" }
    "|#{segments.join}"
  end

  def format_hint(hint)
    return '' if hint.nil?

    hint.map { |item| Colors::HINTS[item] }.join
  end
end
