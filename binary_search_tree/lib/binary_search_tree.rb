# frozen_string_literal: true

# This class implements a Binary Search Tree data structure.
# rubocop: disable Metrics/ClassLength
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

  # BFS
  def level_order
    values = []
    queue = [@root]

    until queue.empty?
      node = queue.shift
      next if node.nil?

      queue += [node.left, node.right]

      yield node if block_given?
      values << node.value
    end

    values
  end

  # DFS: Left -> Node -> Right
  def in_order(node = @root, &)
    return [] if node.nil?

    values = []

    values += in_order(node.left, &)
    yield node if block_given?
    values << node.value
    values += in_order(node.right, &)

    values
  end

  # DFS: Node -> Left -> Right
  def pre_order(node = @root, &)
    return [] if node.nil?

    values = []

    yield node if block_given?
    values << node.value
    values += pre_order(node.left, &)
    values += pre_order(node.right, &)

    values
  end

  # DFS: Left -> Right -> Node
  def post_order(node = @root, &)
    return [] if node.nil?

    values = []

    values += post_order(node.left, &)
    values += post_order(node.right, &)
    yield node if block_given?
    values << node.value

    values
  end

  # number of edges from root to farthest leaf node
  def height(node = @root)
    return -1 if node.nil?

    1 + [height(node.left), height(node.right)].max
  end

  # number of edges from node to root
  def depth(node)
    current = @root
    current_depth = 0

    until node == current
      current = node < current ? current.left : current.right
      current_depth += 1
    end

    current_depth
  end

  def balanced?(node = @root)
    return true if node.nil?

    difference = height(node.left) - height(node.right)
    return false unless difference.abs <= 1

    balanced?(node.left) && balanced?(node.right)
  end

  def rebalance
    @root = build_tree(in_order)
  end

  # rubocop: disable Layout/LineLength, Style/OptionalBooleanParameter
  def display(node = @root, prefix = '', is_left = true)
    return nil if node.nil?

    display(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    display(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
  # rubocop: enable Layout/LineLength, Style/OptionalBooleanParameter

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
# rubocop: enable Metrics/ClassLength
