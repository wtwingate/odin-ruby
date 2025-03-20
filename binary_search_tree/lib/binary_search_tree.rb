# frozen_string_literal: true

# This class implements a Binary Search Tree data structure.
class BinarySearchTree
  def initialize(array = [])
    @root = build_tree(array.uniq.sort)
  end

  def insert(value)
    @root = insert_rec(value, @root)
  end

  def delete(value)
    @root = delete_rec(value, @root)
  end

  def find(value)
    node = @root

    until node.nil?
      return node if node.value == value

      node = value < node.value ? node.left : node.right
    end

    nil
  end

  # rubocop: disable Style/LineLength, Style/OptionalBooleanParameter
  def display(node = @root, prefix = '', is_left = true)
    return nil if node.nil?

    display(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    display(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
  # rubocop: enable Style/LineLength, Style/OptionalBooleanParameter

  private

  def build_tree(array)
    return nil if array.empty?

    mid = array.length / 2

    node = Node.new(array[mid])

    node.left = build_tree(array[0...mid])
    node.right = build_tree(array[mid + 1...])

    node
  end

  def insert_rec(value, node)
    return Node.new(value) if node.nil?
    return node if node.value == value

    if value < node.value
      node.left = insert_rec(value, node.left)
    else
      node.right = insert_rec(value, node.right)
    end

    node
  end

  # rubocop: disable Metrics
  def delete_rec(value, node)
    return nil if node.nil?

    # no match
    if value < node.value
      node.left = delete_rec(value, node.left)
    elsif value > node.value
      node.right = delete_rec(value, node.right)

    # delete this node
    elsif node.left && node.right
      successor = node.right
      successor = successor.left until successor.left.nil?

      node.value = successor.value
      node.right = delete_rec(successor.value, node.right)
    elsif node.left
      node = node.left
    elsif node.right
      node = node.right
    else
      node = nil
    end

    node
  end
  # rubocop: enable Metrics
end
