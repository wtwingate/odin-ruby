# frozen_string_literal: true

require_relative 'lib/board'
require_relative 'lib/colors'
require_relative 'lib/display'
require_relative 'lib/game'

game = Game.new(12)
game.play
