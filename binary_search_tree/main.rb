# frozen_string_literal: true

require_relative 'lib/binary_search_tree'
require_relative 'lib/node'

array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]

bst = BinarySearchTree.new(array)

bst.display
