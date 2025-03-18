# frozen_string_literal: true

require_relative 'lib/hash_map'
require_relative 'lib/node'

hash_map = HashMap.new

hash_map.set('duck', 42)
hash_map.set('goose', 42)
hash_map.set('pig', 42)
hash_map.set('boar', 42)
hash_map.set('dog', 42)
hash_map.set('cat', 42)
hash_map.set('parrot', 42)
hash_map.set('hamster', 42)

p hash_map.size
p hash_map.capacity

hash_map.set('snake', 42)
hash_map.set('fish', 42)
hash_map.set('lizard', 42)
hash_map.set('frog', 42)
hash_map.set('ferret', 42)
hash_map.set('monkey', 42)
hash_map.set('chicken', 42)
hash_map.set('cow', 42)

p hash_map.get('duck')

hash_map.set('duck', 69)

p hash_map.get('duck')

p hash_map.size
p hash_map.capacity

p hash_map.entries
p hash_map.keys
p hash_map.values

p hash_map.has?('goose')
p hash_map.remove('goose')
p hash_map.has?('goose')

hash_map.clear
p hash_map.entries
