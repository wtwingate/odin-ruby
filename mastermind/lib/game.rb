# frozen_string_literal: true

class Game
  def initialize
    @secret = random_secret
    @board = Board.new(@secret)
    @guess = nil
    @turn = 0
  end

  def play
    until game_over?
      render
      @guess = player_input
      @board.update(@guess)
      @turn += 1
    end
  end

  private

  def render
    @board.render
  end

  def game_won?
    @guess == @secret
  end

  def game_over?
    game_won? || @turn == 12
  end

  def player_input
    loop do
      puts 'Enter your guess:'
      input = gets.chomp.upcase.chars

      next unless input.length == 4 && input.all? { |char| Colors::INPUT.include?(char) }

      return input.map { |char| Colors::INPUT[char] }
    end
  end

  def random_secret
    secret = []
    4.times { secret << Colors::SYMBOLS.sample }
    secret
  end
end
