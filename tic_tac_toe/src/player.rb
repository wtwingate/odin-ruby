# frozen_string_literal: true

# Class representing the players in a game of Tic-tac-toe.
class Player
  attr_reader :name, :mark

  def initialize(name, mark)
    @name = name
    @mark = mark
  end

  def place_mark(board)
    loop do
      print "#{name} — choose a square: "
      choice = gets.chomp

      next unless valid_input?(choice)

      square = board.squares[choice.to_i - 1]
      if square.markable?
        square.mark = @mark
        break
      end
    end
  end

  private

  def valid_input?(choice)
    choice =~ /^[1-9]$/
  end
end
