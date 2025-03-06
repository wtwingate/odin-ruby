# frozen_string_literal: true

require_relative 'lib/board'
require_relative 'lib/color'
require_relative 'lib/computer'
require_relative 'lib/formatter'
require_relative 'lib/game'
require_relative 'lib/human'
require_relative 'lib/player'

game = Game.new(12)
game.play
