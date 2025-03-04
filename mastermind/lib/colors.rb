# frozen_string_literal: true

require 'colorize'

module Colors
  SYMBOLS = %i[red green blue cyan magenta yellow].freeze

  INPUT = {
    'R' => :red,
    'G' => :green,
    'B' => :blue,
    'C' => :cyan,
    'M' => :magenta,
    'Y' => :yellow
  }.freeze

  DISPLAY = {
    red: 'R'.colorize(color: :red, mode: :bold),
    green: 'G'.colorize(color: :green, mode: :bold),
    blue: 'B'.colorize(color: :blue, mode: :bold),
    cyan: 'C'.colorize(color: :cyan, mode: :bold),
    magenta: 'M'.colorize(color: :magenta, mode: :bold),
    yellow: 'Y'.colorize(color: :yellow, mode: :bold),
    full: '•'.colorize(:default),
    half: '•'.colorize(:gray)
  }.freeze
end
