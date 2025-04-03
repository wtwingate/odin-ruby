# frozen_string_literal: true

# This class implements the main gameplay loop for Connect Four.
class ConnectFour
  def initialize(player_one = nil, player_two = nil)
    @board = Board.new
    @player_one = player_one || Player.new(1, 'X')
    @player_two = player_two || Player.new(2, 'O')
    @current_player = @player_one
  end

  def play
    start_message

    loop do
      puts @board.pretty_print
      move = input_move
      @board.place_token(@current_player.token, move)

      break if game_over?

      @current_player = next_player
    end

    puts @board.pretty_print
    end_message
  end

  def input_move
    loop do
      puts "#{@current_player.name}: Choose a column (1-7):"

      move = gets.chomp
      return move.to_i - 1 if valid_move?(move)

      puts "You can't place a token there! Try again."
    end
  end

  def valid_move?(move)
    return false unless move.match?(/^[1-7]$/)

    @board.valid_move?(move.to_i - 1)
  end

  def game_over?
    @board.full? || @board.four_in_a_row?
  end

  def next_player
    @current_player == @player_one ? @player_two : @player_one
  end

  private

  def start_message
    puts 'Welcome to Connect Four!'
    puts "Player 1: #{@player_one.name} (#{@player_one.token})"
    puts "Player 2: #{@player_two.name} (#{@player_two.token})"
    puts 'Let the game begin!'
    puts '------------------------'
  end

  def end_message
    if @board.four_in_a_row?
      puts "#{@current_player.name} wins!"
    else
      puts "It's a draw!"
    end
  end
end
