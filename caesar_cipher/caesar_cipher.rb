def caesar_cipher(message, shift)
  encrypted = message.chars.map do |char|
    if char.between?('a', 'z')
      (((char.ord - 'a'.ord + shift) % 26) + 'a'.ord).chr
    elsif char.between?('A', 'Z')
      (((char.ord - 'A'.ord + shift) % 26) + 'A'.ord).chr
    else
      char
    end
  end
  encrypted.join
end

puts caesar_cipher('What a string!', 5)   #=> "Bmfy f xywnsl!"
puts caesar_cipher('Bmfy f xywnsl!', -5)  #=> "What a string!"
