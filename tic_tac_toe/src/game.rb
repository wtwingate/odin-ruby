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
    puts @board
    loop do
      @turn += 1

      player = @turn.odd? ? @player_one : @player_two
      player.place_mark(@board)

      puts @board

      break if game_over?
    end
  end

  private

  WIN_CONDITIONS = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], # horizontal
    [0, 3, 6], [1, 4, 7], [2, 5, 8], # vertical
    [0, 4, 8], [2, 4, 6]             # diagonal
  ].freeze

  def game_over?
    three_in_a_row? || out_of_turns?
  end

  def three_in_a_row?
    WIN_CONDITIONS.each do |wc|
      mark1 = @board.squares[wc[0]].mark
      mark2 = @board.squares[wc[1]].mark
      mark3 = @board.squares[wc[2]].mark

      next if mark1.nil? || mark2.nil? || mark3.nil?

      return true if mark1 == mark2 && mark2 == mark3
    end
    false
  end

  def out_of_turns?
    @turn >= 9
  end
end
