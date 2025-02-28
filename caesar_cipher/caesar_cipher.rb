# frozen_string_literal: true

def caesar_cipher(message, shift)
  message.chars.map do |char|
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

puts caesar_cipher('What a string!', 5)
puts caesar_cipher('What a string!', -5)
