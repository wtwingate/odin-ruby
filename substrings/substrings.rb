# frozen_string_literal: true

def substrings(string, dictionary)
  lowercase_string = string.downcase

  dictionary.each_with_object(Hash.new(0)) do |word, counts|
    lowercase_string.split.each do |substring|
      counts[word] += 1 if substring.include?(word)
    end
  end
end

dictionary = %w[below down go going horn how howdy it i low own part partner sit]

puts substrings('below', dictionary)
puts substrings("Howdy partner, sit down! How's it going?", dictionary)
