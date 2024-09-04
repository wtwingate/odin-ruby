# frozen_string_literal: true

# This is the base class for all players, whether code maker or code
# breaker, human or computer.
class Player
  attr_reader :name

  def initialize(name)
    @name = name
  end
end
