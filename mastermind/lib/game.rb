# frozen_string_literal: true

# This class implements the Mastermind gameplay loop.
class Game
  MAX_TURNS = 12

  COLOR_HASH = {
    'R' => :red,
    'G' => :green,
    'B' => :blue,
    'C' => :cyan,
    'M' => :magenta,
    'Y' => :yellow
  }.freeze

  HINT_HASH = {
    'F' => :full,
    'H' => :half
  }.freeze

  def initialize
    @board = Board.new(MAX_TURNS)
    @turn = 0
  end

  def play
    raise NotImplementedError "#{self.class} does not implement #{__method__}"
  end

  private

  def color_input
    loop do
      input = gets.chomp.upcase.chars

      next unless valid_color_input?(input)

      return input.map { |char| COLOR_HASH[char] }
    end
  end

  def valid_color_input?(input)
    input.length == 4 && input.all? { |char| COLOR_HASH.key?(char) }
  end

  def hint_input
    loop do
      input = gets.chomp.upcase.chars

      next unless valid_hint_input?(input)

      return input.map { |char| HINT_HASH[char] }.sort
    end
  end

  def valid_hint_input?(input)
    input.length <= 4 && input.all? { |char| HINT_HASH.key?(char) }
  end

  def code_cracked?
    @board.last_guess == @code
  end

  def over?
    code_cracked? || @turn == MAX_TURNS
  end

  def format_code(code)
    code.map { |color| Colors::LETTERS[color] }.join(' ')
  end

  # rubocop: disable Metrics/MethodLength
  def compare(guess, code)
    matches = []
    code_counts = Hash.new(0)

    # Count full matches and build hash of remaining code colors
    code.each_with_index do |color, index|
      if guess[index] == color
        matches << :full
      else
        code_counts[color] += 1
      end
    end

    # Count half matches from guess positions that weren't a full match
    guess.each_with_index do |color, index|
      next if code[index] == color # Skip full matches

      unless code_counts[color].zero?
        matches << :half
        code_counts[color] -= 1
      end
    end

    matches
  end
  # rubocop: enable Metrics/MethodLength
end
