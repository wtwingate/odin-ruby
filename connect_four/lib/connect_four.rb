# frozen_string_literal: true

# This class implements the main gameplay loop for Connect Four.
class ConnectFour
  def initialize(player_one, player_two)
    @board = Board.new
    @player_one = player_one
    @player_two = player_two
    @current_player = @player_one
  end

  def play
    start_message

    loop do
      puts @board.pretty_print
      column = player_input(@current_player)
      @board.place_mark(@current_player.token, column)

      break if game_over?

      @current_player = next_player
    end

    puts @board.pretty_print
    end_message
  end

  def player_input
    loop do
      puts "#{@current_player.name}: Choose a column (1-7):"

      input = gets.chomp
      return input.to_i - 1 if valid_input?(input)

      puts "You can't place a token there! Try again."
    end
  end

  def valid_input?(input)
    return false unless input.match?(/^[1-7]$/)

    @board.valid_move?(input.to_i - 1)
  end

  def game_over?
    @board.full? || @board.four_in_a_row?
  end

  def next_player
    @current_player == @player_one ? @player_two : @player_one
  end

  private

  def start_message
    # TODO
  end

  def end_message
    # TODO
  end
end
