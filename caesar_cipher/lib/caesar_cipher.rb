# frozen_string_literal: true

class CaesarCipher
  def initialize(message)
    @message = message
  end

  def encrypt(shift)
    @message.chars.map do |char|
      if /[a-z]/.match?(char)
        base = 'a'.ord
        (base + ((char.ord - base + shift) % 26)).chr
      elsif /[A-Z]/.match?(char)
        base = 'A'.ord
        (base + ((char.ord - base + shift) % 26)).chr
      else
        char
      end
    end.join
  end
end
