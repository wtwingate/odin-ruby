# frozen_string_literal: true

require_relative 'board'
require_relative 'player'

# Master class for a game of Tic-tac-toe. Holds references to the
# players and board, and provides methods for the main game loop.
class Game
  def initialize
    @board = Board.new
    @player_one = Player.new('Player One', 'X')
    @player_two = Player.new('Player Two', 'O')
    @turn = 0
  end

  def play
    loop do
      @turn += 1

      puts @board

      player = @turn.odd? ? @player_one : @player_two
      player.place_mark(@board)

      break if game_over?
    end

    puts @board
  end

  private

  def game_over?
    @board.three_in_a_row? || out_of_turns?
  end

  def out_of_turns?
    @turn >= 9
  end
end
