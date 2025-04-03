# frozen_string_literal: true

# This class represents a player in the game.
class Player
  attr_reader :name, :token

  def initialize(number, token, name = nil)
    @number = number
    @token = token
    @name = name || input_name
  end

  def input_name
    puts "Player #{@number}: Please enter your name:"

    loop do
      name = gets.strip

      return name if name.match?(/\w+/)

      puts 'Please enter a valid name:'
    end
  end
end
