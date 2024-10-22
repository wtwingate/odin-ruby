# frozen_string_literal: true

require_relative 'lib/hash_map'

my_hash = HashMap.new

my_hash.set('apple', 'red')
my_hash.set('banana', 'yellow')
my_hash.set('carrot', 'orange')
my_hash.set('dog', 'brown')
my_hash.set('elephant', 'gray')
my_hash.set('frog', 'green')
my_hash.set('grape', 'purple')
my_hash.set('hat', 'black')
my_hash.set('ice cream', 'white')
my_hash.set('jacket', 'blue')
my_hash.set('kite', 'pink')
my_hash.set('lion', 'golden')

p my_hash.entries
p my_hash.capacity
p my_hash.length

my_hash.set('mallard', 'teal')

p my_hash.entries
p my_hash.capacity
p my_hash.length

my_hash.clear

p my_hash.entries
p my_hash.capacity
p my_hash.length
