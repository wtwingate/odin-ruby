# frozen_string_literal: true

# This class represents a player in the game.
class Player
  attr_reader :name, :token

  def initialize(name, token)
    @name = name
    @token = token
  end
end
