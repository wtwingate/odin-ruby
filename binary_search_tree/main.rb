# frozen_string_literal: true

require_relative 'lib/binary_search_tree'
require_relative 'lib/node'

bst = BinarySearchTree.new(Array.new(16) { rand(1..100) })

puts "#{bst.balanced? ? 'Balanced' : 'Imbalanced'} BST:"
bst.display
puts

16.times { bst.insert(rand(1..1000)) }
bst.in_order.sample(16).each { |value| bst.delete(value) }

puts "#{bst.balanced? ? 'Balanced' : 'Imbalanced'} BST:"
bst.display
puts

bst.rebalance

puts "#{bst.balanced? ? 'Balanced' : 'Imbalanced'} BST:"
bst.display
puts

puts "In-order:    #{bst.in_order}"
puts "Pre-order:   #{bst.pre_order}"
puts "Post-order:  #{bst.post_order}"
puts "Level-order: #{bst.level_order}"
