# frozen_string_literal: true

# BFS (Breadth-First Search) Templates
#
# Templates for common BFS patterns on graphs and trees.
# BFS explores level by level, using a queue.

# ============================================================================
# TEMPLATE 1: BFS on Graph
# ============================================================================

def bfs_graph(graph, start)
  # Basic BFS on graph represented as adjacency list.
  #
  # Args:
  #   graph: Hash mapping node -> array of neighbors
  #   start: Starting node
  #
  # Time: O(V + E) where V = vertices, E = edges
  # Space: O(V) for queue and visited set
  #
  # Use cases:
  # - Shortest path in unweighted graph
  # - Level-order traversal
  # - Connected components
  visited = Set.new([start])
  queue = [start]

  until queue.empty?
    node = queue.shift
    puts node  # Process node

    (graph[node] || []).each do |neighbor|
      unless visited.include?(neighbor)
        visited.add(neighbor)
        queue.push(neighbor)
      end
    end
  end

  visited
end

# ============================================================================
# TEMPLATE 2: BFS with Level Tracking
# ============================================================================

def bfs_with_levels(graph, start)
  # BFS that tracks distance/level from start.
  #
  # Returns: Hash mapping node -> level
  visited = { start => 0 }  # Maps node -> level
  queue = [start]

  until queue.empty?
    node = queue.shift
    current_level = visited[node]

    (graph[node] || []).each do |neighbor|
      unless visited.key?(neighbor)
        visited[neighbor] = current_level + 1
        queue.push(neighbor)
      end
    end
  end

  visited
end

# ============================================================================
# TEMPLATE 3: BFS on Binary Tree (Level Order)
# ============================================================================

class TreeNode
  attr_accessor :val, :left, :right

  def initialize(val = 0, left = nil, right = nil)
    @val = val
    @left = left
    @right = right
  end
end

def level_order_traversal(root)
  # Level-order traversal of binary tree.
  #
  # Returns: Array of arrays, each inner array is one level
  #
  # Time: O(n) where n = number of nodes
  # Space: O(w) where w = max width of tree
  return [] if root.nil?

  result = []
  queue = [root]

  until queue.empty?
    level_size = queue.length
    current_level = []

    # Process all nodes in current level
    level_size.times do
      node = queue.shift
      current_level.push(node.val)

      # Add children for next level
      queue.push(node.left) if node.left
      queue.push(node.right) if node.right
    end

    result.push(current_level)
  end

  result
end

def level_order_bottom_up(root)
  # Level-order traversal from bottom to top.
  #
  # Returns: Array of arrays, bottom level first
  return [] if root.nil?

  result = []
  queue = [root]

  until queue.empty?
    level_size = queue.length
    current_level = []

    level_size.times do
      node = queue.shift
      current_level.push(node.val)

      queue.push(node.left) if node.left
      queue.push(node.right) if node.right
    end

    result.push(current_level)
  end

  result.reverse  # Reverse to get bottom-up
end

# ============================================================================
# TEMPLATE 4: BFS for Shortest Path
# ============================================================================

def shortest_path_bfs(graph, start, end_node)
  # Find shortest path between start and end in unweighted graph.
  #
  # Returns: Length of shortest path, or -1 if no path exists
  return 0 if start == end_node

  visited = Set.new([start])
  queue = [[start, 0]]  # [node, distance]

  until queue.empty?
    node, dist = queue.shift

    (graph[node] || []).each do |neighbor|
      return dist + 1 if neighbor == end_node

      unless visited.include?(neighbor)
        visited.add(neighbor)
        queue.push([neighbor, dist + 1])
      end
    end
  end

  -1  # No path found
end

def shortest_path_with_route(graph, start, end_node)
  # Find shortest path and return the actual route.
  #
  # Returns: Array representing path, or nil if no path
  return [start] if start == end_node

  visited = Set.new([start])
  queue = [[start, [start]]]  # [node, path]

  until queue.empty?
    node, path = queue.shift

    (graph[node] || []).each do |neighbor|
      return path + [end_node] if neighbor == end_node

      unless visited.include?(neighbor)
        visited.add(neighbor)
        queue.push([neighbor, path + [neighbor]])
      end
    end
  end

  nil
end

# ============================================================================
# TEMPLATE 5: Multi-Source BFS
# ============================================================================

def multi_source_bfs(graph, sources)
  # BFS from multiple starting points simultaneously.
  #
  # Use cases:
  # - Rotten oranges problem
  # - Walls and gates
  # - 01 Matrix
  #
  # Returns: Hash mapping node -> distance from nearest source
  visited = {}
  queue = []

  # Initialize queue with all sources
  sources.each do |source|
    visited[source] = 0
    queue.push(source)
  end

  until queue.empty?
    node = queue.shift
    current_dist = visited[node]

    (graph[node] || []).each do |neighbor|
      unless visited.key?(neighbor)
        visited[neighbor] = current_dist + 1
        queue.push(neighbor)
      end
    end
  end

  visited
end

# ============================================================================
# TEMPLATE 6: BFS on 2D Grid
# ============================================================================

def bfs_grid(grid, start_row, start_col)
  # BFS on 2D grid.
  #
  # Use cases:
  # - Shortest path in maze
  # - Flood fill
  # - Island perimeter
  #
  # Time: O(rows × cols)
  # Space: O(rows × cols)
  rows = grid.length
  cols = grid[0].length
  visited = Set.new([[start_row, start_col]])
  queue = [[start_row, start_col, 0]]  # [row, col, distance]

  # 4 directions: up, down, left, right
  directions = [[-1, 0], [1, 0], [0, -1], [0, 1]]

  until queue.empty?
    row, col, dist = queue.shift
    puts "Visiting (#{row}, #{col}) at distance #{dist}"

    directions.each do |dr, dc|
      new_row = row + dr
      new_col = col + dc

      # Check bounds and visited
      if new_row >= 0 && new_row < rows &&
         new_col >= 0 && new_col < cols &&
         !visited.include?([new_row, new_col]) &&
         grid[new_row][new_col] == 1  # Adjust condition

        visited.add([new_row, new_col])
        queue.push([new_row, new_col, dist + 1])
      end
    end
  end

  visited
end

def bfs_grid_shortest_path(grid, start, end_pos)
  # Find shortest path in grid from start to end.
  #
  # Args:
  #   grid: 2D array (1 = walkable, 0 = wall)
  #   start: [row, col] array
  #   end_pos: [row, col] array
  #
  # Returns: Shortest path length, or -1 if no path
  return 0 if start == end_pos

  rows = grid.length
  cols = grid[0].length
  start_row, start_col = start
  end_row, end_col = end_pos

  visited = Set.new([start])
  queue = [[start_row, start_col, 0]]

  directions = [[-1, 0], [1, 0], [0, -1], [0, 1]]

  until queue.empty?
    row, col, dist = queue.shift

    directions.each do |dr, dc|
      new_row = row + dr
      new_col = col + dc

      return dist + 1 if new_row == end_row && new_col == end_col

      if new_row >= 0 && new_row < rows &&
         new_col >= 0 && new_col < cols &&
         !visited.include?([new_row, new_col]) &&
         grid[new_row][new_col] == 1

        visited.add([new_row, new_col])
        queue.push([new_row, new_col, dist + 1])
      end
    end
  end

  -1
end

# ============================================================================
# TEMPLATE 7: BFS for Bipartite Graph
# ============================================================================

def bipartite?(graph, n)
  # Check if graph can be colored with 2 colors (bipartite).
  #
  # Uses BFS to try to color graph with alternating colors.
  #
  # Returns: true if bipartite, false otherwise
  color = Array.new(n, -1)  # -1 = uncolored, 0/1 = colors

  n.times do |start|
    next unless color[start] == -1

    queue = [start]
    color[start] = 0

    until queue.empty?
      node = queue.shift
      current_color = color[node]

      (graph[node] || []).each do |neighbor|
        if color[neighbor] == -1
          # Color with opposite color
          color[neighbor] = 1 - current_color
          queue.push(neighbor)
        elsif color[neighbor] == current_color
          # Same color as current = not bipartite
          return false
        end
      end
    end
  end

  true
end

# ============================================================================
# TEMPLATE 8: 0-1 BFS (Weighted BFS)
# ============================================================================

def bfs_01_weighted(graph, start, end_node)
  # BFS for graphs with edge weights of 0 or 1.
  #
  # Use deque as double-ended queue:
  # - Edges with weight 0: add to front (higher priority)
  # - Edges with weight 1: add to back (lower priority)
  #
  # Time: O(V + E)
  # Space: O(V)
  #
  # Returns: Shortest distance
  dist = { start => 0 }
  queue = [start]

  until queue.empty?
    node = queue.shift

    (graph[node] || []).each do |neighbor, weight|
      new_dist = dist[node] + weight

      if !dist.key?(neighbor) || new_dist < dist[neighbor]
        dist[neighbor] = new_dist

        if weight.zero?
          queue.unshift(neighbor)  # Priority: front
        else
          queue.push(neighbor)     # Normal: back
        end
      end
    end
  end

  dist[end_node] || -1
end

# ============================================================================
# TESTING
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  require 'set'

  # Test graph BFS
  graph = {
    0 => [1, 2],
    1 => [0, 3, 4],
    2 => [0, 5],
    3 => [1],
    4 => [1],
    5 => [2]
  }

  puts 'BFS from node 0:'
  bfs_graph(graph, 0)

  puts "\nBFS with levels:"
  levels = bfs_with_levels(graph, 0)
  p levels

  # Test tree BFS
  root = TreeNode.new(1)
  root.left = TreeNode.new(2)
  root.right = TreeNode.new(3)
  root.left.left = TreeNode.new(4)
  root.left.right = TreeNode.new(5)
  root.right.right = TreeNode.new(6)

  puts "\nLevel Order Traversal:"
  p level_order_traversal(root)

  puts "\nLevel Order (Bottom-Up):"
  p level_order_bottom_up(root)

  # Test shortest path
  puts "\nShortest path 0 to 5:"
  p shortest_path_bfs(graph, 0, 5)

  puts "\nShortest path with route:"
  p shortest_path_with_route(graph, 0, 5)

  # Test grid BFS
  grid = [
    [1, 1, 0, 1],
    [1, 0, 0, 1],
    [1, 1, 1, 1]
  ]

  puts "\nGrid BFS from (0, 0):"
  bfs_grid(grid, 0, 0)

  puts "\nShortest path in grid from (0,0) to (2,3):"
  p bfs_grid_shortest_path(grid, [0, 0], [2, 3])

  # Test bipartite
  bipartite_graph = {
    0 => [1, 3],
    1 => [0, 2],
    2 => [1, 3],
    3 => [0, 2]
  }
  puts "\nIs bipartite: #{bipartite?(bipartite_graph, 4)}"
end
