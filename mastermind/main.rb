# frozen_string_literal: true

require_relative 'lib/board'
require_relative 'lib/color'
require_relative 'lib/computer'
require_relative 'lib/formatter'
require_relative 'lib/game'
require_relative 'lib/human'
require_relative 'lib/player'

puts '*** welcome to Mastermind ***'
puts "Enter '1' to be the Code Maker."
puts "Enter '2' to be the Code Breaker."
puts "Or, enter 'q' to quit"

code_maker = nil
code_breaker = nil

loop do
  input = gets.chomp.downcase[0]

  case input
  when '1'
    code_maker = Human.new
    code_breaker = Computer.new
    break
  when '2'
    code_maker = Computer.new
    code_breaker = Human.new
    break
  when 'q'
    exit
  end
end

game = Game.new(code_maker, code_breaker)
game.play
