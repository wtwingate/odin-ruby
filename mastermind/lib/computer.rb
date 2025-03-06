# frozen_string_literal: true

require_relative 'player'

# This class implements the methods for a Computer player
class Computer < Player
  def guess; end

  def secret
    Array.new(4) { Colors::SYMBOLS.sample }
  end
end
