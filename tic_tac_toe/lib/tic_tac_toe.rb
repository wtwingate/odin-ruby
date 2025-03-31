# frozen_string_literal: true

class TicTacToe
  def initialize
    @board = Board.new
    @turn = 0
  end

  def play
    until game_over?
      puts @board
      place_mark(user_input)
      @turn += 1
    end

    game_over_message
  end

  def game_over?
    @board.winner? || @turn == 9
  end

  def user_input
    loop do
      char = gets.chomp

      next unless char.match?(/^[1-9]$/)

      number = char.to_i - 1
      return number if @board.square_empty? number
    end
  end

  def place_mark(square_index)
    player_mark = @turn.even? ? 'X' : 'O'
    @board.place_mark(player_mark, square_index)
  end

  private

  def game_over_message
    puts @board

    if @board.winner?
      winner = @turn.odd? ? 'X' : 'O'
      puts "#{winner} wins!"
    else
      puts "That's a draw!"
    end
  end
end
