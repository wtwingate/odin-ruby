# frozen_string_literal: true

require_relative 'lib/board'
require_relative 'lib/code_breaker'
require_relative 'lib/code_maker'
require_relative 'lib/colors'
require_relative 'lib/game'
require_relative 'lib/mastermind'

game = Mastermind.new
game.start
