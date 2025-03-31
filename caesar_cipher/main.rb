require_relative "lib/caesar_cipher"

caesar_cipher = CaesarCipher.new("What a string!")
puts caesar_cipher.encrypt(5)
