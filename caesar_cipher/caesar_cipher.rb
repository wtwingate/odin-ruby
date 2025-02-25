# frozen_string_literal: true

def caesar_cipher(message, shift)
  message.chars.map do |char|
    if char =~ /[a-z]/
      base = 'a'.ord
      (base + ((char.ord - base + shift) % 26)).chr
    elsif char =~ /[A-Z]/
      base = 'A'.ord
      (base + ((char.ord - base + shift) % 26)).chr
    else
      char
    end
  end.join
end

puts caesar_cipher('What a string!', 5)
puts caesar_cipher('What a string!', -5)
