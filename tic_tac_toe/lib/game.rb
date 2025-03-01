# frozen_string_literal: true

require 'io/console'

class Game
  def initialize
    @board = Board.new
    @turn = 0
  end

  def play
    until over?
      puts @board
      place_mark(user_input)
      @turn += 1
    end

    finish
  end

  private

  def user_input
    loop do
      char = $stdin.getch

      next unless char.match?(/[1-9]/)

      number = char.to_i - 1
      return number if @board.square_empty? number
    end
  end

  def place_mark(number)
    mark = @turn.even? ? 'X' : 'O'
    @board.place_mark(mark, number)
  end

  def over?
    @board.winner? || @turn == 9
  end

  def finish
    puts @board

    if @board.winner?
      winner = @turn.odd? ? 'X' : 'O'
      puts "#{winner} wins!"
    else
      puts "That's a draw!"
    end
  end
end
