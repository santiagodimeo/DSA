# frozen_string_literal: true

# DFS (Depth-First Search) Templates
#
# Templates for common DFS patterns on graphs and trees.

# ============================================================================
# TEMPLATE 1: DFS on Graph (Adjacency List)
# ============================================================================

def dfs_graph_recursive(graph, start, visited = nil)
  # Recursive DFS on graph represented as adjacency list.
  #
  # Args:
  #   graph: Hash mapping node -> array of neighbors
  #   start: Starting node
  #   visited: Set of visited nodes
  #
  # Time: O(V + E) where V = vertices, E = edges
  # Space: O(V) for visited set and recursion stack
  visited = Set.new if visited.nil?

  visited.add(start)
  puts start  # Process node

  (graph[start] || []).each do |neighbor|
    dfs_graph_recursive(graph, neighbor, visited) unless visited.include?(neighbor)
  end

  visited
end

def dfs_graph_iterative(graph, start)
  # Iterative DFS using stack.
  #
  # Time: O(V + E)
  # Space: O(V) for stack and visited set
  visited = Set.new
  stack = [start]

  until stack.empty?
    node = stack.pop

    unless visited.include?(node)
      visited.add(node)
      puts node  # Process node

      # Add neighbors in reverse order to match recursive DFS
      (graph[node] || []).reverse_each do |neighbor|
        stack.push(neighbor) unless visited.include?(neighbor)
      end
    end
  end

  visited
end

# ============================================================================
# TEMPLATE 2: DFS on Binary Tree
# ============================================================================

class TreeNode
  attr_accessor :val, :left, :right

  def initialize(val = 0, left = nil, right = nil)
    @val = val
    @left = left
    @right = right
  end
end

def dfs_tree_preorder(root)
  # Preorder: Root → Left → Right
  #
  # Use case: Create copy of tree, prefix expression
  return [] if root.nil?

  result = []
  result.push(root.val)  # Process root
  result.concat(dfs_tree_preorder(root.left))   # Left subtree
  result.concat(dfs_tree_preorder(root.right))  # Right subtree
  result
end

def dfs_tree_inorder(root)
  # Inorder: Left → Root → Right
  #
  # Use case: Get sorted values from BST
  return [] if root.nil?

  result = []
  result.concat(dfs_tree_inorder(root.left))   # Left subtree
  result.push(root.val)  # Process root
  result.concat(dfs_tree_inorder(root.right))  # Right subtree
  result
end

def dfs_tree_postorder(root)
  # Postorder: Left → Right → Root
  #
  # Use case: Delete tree, postfix expression
  return [] if root.nil?

  result = []
  result.concat(dfs_tree_postorder(root.left))   # Left subtree
  result.concat(dfs_tree_postorder(root.right))  # Right subtree
  result.push(root.val)  # Process root
  result
end

# ============================================================================
# TEMPLATE 3: DFS for Path Finding
# ============================================================================

def find_path_dfs(graph, start, end_node, path = nil)
  # Find a path from start to end using DFS.
  #
  # Returns: Array representing path, or nil if no path exists
  path = [] if path.nil?

  path = path + [start]

  return path if start == end_node

  (graph[start] || []).each do |neighbor|
    unless path.include?(neighbor)  # Avoid cycles
      new_path = find_path_dfs(graph, neighbor, end_node, path)
      return new_path if new_path
    end
  end

  nil
end

def find_all_paths_dfs(graph, start, end_node, path = nil)
  # Find all paths from start to end using DFS.
  #
  # Returns: Array of all possible paths
  path = [] if path.nil?

  path = path + [start]

  return [path] if start == end_node

  paths = []
  (graph[start] || []).each do |neighbor|
    unless path.include?(neighbor)
      new_paths = find_all_paths_dfs(graph, neighbor, end_node, path)
      paths.concat(new_paths)
    end
  end

  paths
end

# ============================================================================
# TEMPLATE 4: DFS with Backtracking
# ============================================================================

def dfs_backtracking_template(choices)
  # Generic backtracking template.
  #
  # Pattern: Choose → Explore → Unchoose
  result = []

  # Returns true if state is a valid solution
  # Define what makes a valid solution
  is_valid_solution = lambda do |state|
    true  # Implement based on problem
  end

  # Get available choices for next step
  get_next_choices = lambda do |choice, remaining|
    []  # Implement based on problem
  end

  backtrack = lambda do |current_state, remaining_choices|
    # Base case: Found valid solution
    if is_valid_solution.call(current_state)
      result.push(current_state.dup)  # Copy current state
      return
    end

    # Try each choice
    remaining_choices.each do |choice|
      # Make choice
      current_state.push(choice)

      # Explore with this choice
      backtrack.call(current_state, get_next_choices.call(choice, remaining_choices))

      # Unmake choice (backtrack)
      current_state.pop
    end
  end

  backtrack.call([], choices)
  result
end

# ============================================================================
# TEMPLATE 5: DFS for Cycle Detection
# ============================================================================

def has_cycle_undirected?(graph, n)
  # Detect cycle in undirected graph.
  #
  # Args:
  #   graph: Adjacency list
  #   n: Number of nodes (0 to n-1)
  #
  # Returns: true if cycle exists
  visited = Set.new

  dfs = lambda do |node, parent|
    visited.add(node)

    (graph[node] || []).each do |neighbor|
      if !visited.include?(neighbor)
        return true if dfs.call(neighbor, node)
      elsif neighbor != parent
        # Visited neighbor that's not parent = cycle
        return true
      end
    end

    false
  end

  # Check all components
  n.times do |node|
    return true if !visited.include?(node) && dfs.call(node, -1)
  end

  false
end

def has_cycle_directed?(graph, n)
  # Detect cycle in directed graph using colors.
  #
  # White (0): Not visited
  # Gray (1): In current DFS path
  # Black (2): Completely processed
  #
  # Returns: true if cycle exists
  color = Array.new(n, 0)  # 0=white, 1=gray, 2=black

  dfs = lambda do |node|
    color[node] = 1  # Mark as being processed

    (graph[node] || []).each do |neighbor|
      # Back edge found = cycle
      return true if color[neighbor] == 1
      return true if color[neighbor].zero? && dfs.call(neighbor)
    end

    color[node] = 2  # Mark as completely processed
    false
  end

  n.times do |node|
    return true if color[node].zero? && dfs.call(node)
  end

  false
end

# ============================================================================
# TEMPLATE 6: DFS on 2D Grid
# ============================================================================

def dfs_grid(grid, row, col, visited = nil)
  # DFS on 2D grid (for problems like islands, flood fill).
  #
  # Args:
  #   grid: 2D array
  #   row, col: Starting position
  #   visited: Set of [row, col] arrays
  #
  # Time: O(rows × cols)
  # Space: O(rows × cols) for recursion and visited
  visited = Set.new if visited.nil?

  rows = grid.length
  cols = grid[0].length

  # Base cases
  if row.negative? || row >= rows ||
     col.negative? || col >= cols ||
     visited.include?([row, col]) ||
     grid[row][col].zero?  # Adjust condition based on problem
    return
  end

  visited.add([row, col])
  # Process cell
  puts "Visiting (#{row}, #{col})"

  # Explore 4 directions: up, down, left, right
  directions = [[-1, 0], [1, 0], [0, -1], [0, 1]]
  directions.each do |dr, dc|
    dfs_grid(grid, row + dr, col + dc, visited)
  end

  visited
end

# ============================================================================
# TEMPLATE 7: DFS with Memoization
# ============================================================================

def dfs_with_memo(graph, start, target, memo = nil)
  # DFS with memoization for optimization.
  #
  # Use when subproblems overlap.
  memo = {} if memo.nil?

  return memo[start] if memo.key?(start)

  return true if start == target

  (graph[start] || []).each do |neighbor|
    if dfs_with_memo(graph, neighbor, target, memo)
      memo[start] = true
      return true
    end
  end

  memo[start] = false
  false
end

# ============================================================================
# TESTING
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  require 'set'

  # Test graph DFS
  graph = {
    0 => [1, 2],
    1 => [0, 3, 4],
    2 => [0, 5],
    3 => [1],
    4 => [1],
    5 => [2]
  }

  puts 'DFS Recursive:'
  dfs_graph_recursive(graph, 0)

  puts "\nDFS Iterative:"
  dfs_graph_iterative(graph, 0)

  # Test tree DFS
  root = TreeNode.new(1)
  root.left = TreeNode.new(2)
  root.right = TreeNode.new(3)
  root.left.left = TreeNode.new(4)
  root.left.right = TreeNode.new(5)

  puts "\nPreorder: #{dfs_tree_preorder(root)}"
  puts "Inorder: #{dfs_tree_inorder(root)}"
  puts "Postorder: #{dfs_tree_postorder(root)}"

  # Test path finding
  puts "\nFind path 0 to 5: #{find_path_dfs(graph, 0, 5)}"
  puts "All paths 0 to 5: #{find_all_paths_dfs(graph, 0, 5)}"

  # Test cycle detection
  graph_with_cycle = { 0 => [1], 1 => [2], 2 => [0] }
  puts "\nHas cycle (directed): #{has_cycle_directed?(graph_with_cycle, 3)}"

  # Test grid DFS
  grid = [
    [1, 1, 0],
    [1, 0, 0],
    [0, 1, 1]
  ]
  puts "\nGrid DFS from (0,0):"
  dfs_grid(grid, 0, 0)
end
