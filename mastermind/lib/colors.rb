# frozen_string_literal: true

require 'colorize'

# This module contains colorful constants used by other classes.
module Colors
  SYMBOLS = %i[red green blue cyan magenta yellow].freeze

  LETTERS = {
    red: 'R'.colorize(color: :red, mode: :bold),
    green: 'G'.colorize(color: :green, mode: :bold),
    blue: 'B'.colorize(color: :blue, mode: :bold),
    cyan: 'C'.colorize(color: :cyan, mode: :bold),
    magenta: 'M'.colorize(color: :magenta, mode: :bold),
    yellow: 'Y'.colorize(color: :yellow, mode: :bold)
  }.freeze

  HINTS = {
    full: '•'.colorize(color: :default, mode: :bold),
    half: '•'.colorize(color: :gray, mode: :bold)
  }.freeze
end
