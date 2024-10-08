# frozen_string_literal: true

require 'colorize'

# This module provides constants to be used throughout the rest of
# the program.
module Constants
  COLORS = %w[R G B C M Y].freeze

  COLORIZED = {
    'R' => 'R'.colorize(color: :red, mode: :bold),
    'G' => 'G'.colorize(color: :green, mode: :bold),
    'B' => 'B'.colorize(color: :blue, mode: :bold),
    'C' => 'C'.colorize(color: :cyan, mode: :bold),
    'M' => 'M'.colorize(color: :magenta, mode: :bold),
    'Y' => 'Y'.colorize(color: :yellow, mode: :bold)
  }.freeze

  HINTS = {
    full: '*'.colorize(color: :red, mode: :bold),
    half: '*'.colorize(color: :yellow, mode: :bold)
  }.freeze
end
