# frozen_string_literal: true

require_relative 'lib/hash_map'
require_relative 'lib/node'

hash_map = HashMap.new

hash_map.set('apple', 'red')
hash_map.set('banana', 'yellow')
hash_map.set('carrot', 'orange')
hash_map.set('dog', 'brown')
hash_map.set('elephant', 'gray')
hash_map.set('frog', 'green')
hash_map.set('grape', 'purple')
hash_map.set('hat', 'black')
hash_map.set('ice cream', 'white')
hash_map.set('jacket', 'blue')
hash_map.set('kite', 'pink')
hash_map.set('lion', 'golden')

p hash_map.entries
p hash_map.length
p hash_map.capacity

hash_map.set('ice cream', 'strawberry')
hash_map.set('carrot', 'purple')
hash_map.set('kite', 'rainbow')

p hash_map.entries
p hash_map.length
p hash_map.capacity

hash_map.set('moon', 'silver')

p hash_map.entries
p hash_map.length
p hash_map.capacity

hash_map.set('moon', 'blue')
hash_map.set('frog', 'brown')
hash_map.set('jacket', 'black')

p hash_map.entries
p hash_map.length
p hash_map.capacity
