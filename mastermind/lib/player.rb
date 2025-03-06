# frozen_string_literal: true

# This class provides a common interface for Human and Computer players.
class Player
  def guess
    raise NotImplementedError "#{self.class} does not implement #{__method__}"
  end

  def secret
    raise NotImplementedError "#{self.class} does not implement #{__method__}"
  end
end
