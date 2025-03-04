# frozen_string_literal: true

# This class implements the Mastermind gameplay loop.
class Game
  def initialize(size)
    @size = size
    @secret = random_secret
    @board = Board.new(size, @secret)
    @display = Display.new(@board)
    @turn = 0
    @guess = nil
  end

  def play
    @display.game_start

    until over?
      @display.game_loop
      @guess = player_input
      @board.update(@guess)
      @turn += 1
    end

    @display.game_over(won?, @secret)
  end

  private

  def won?
    @guess == @secret
  end

  def over?
    won? || @turn == @size
  end

  def player_input
    loop do
      @display.input_prompt
      input = gets.chomp.upcase.chars

      next unless valid?(input)

      return input.map { |char| Colors::INPUT[char] }
    end
  end

  def valid?(input)
    input.length == 4 && input.all? { |char| Colors::INPUT.include?(char) }
  end

  def random_secret
    Array.new(4) { Colors::SYMBOLS.sample }
  end
end
