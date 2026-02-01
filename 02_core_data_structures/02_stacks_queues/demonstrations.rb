# frozen_string_literal: true

# Stacks and Queues - Code Demonstrations
#
# This file demonstrates common stack and queue patterns and operations.
# Study each function and its use case.

# ============================================================================
# BASIC STACK IMPLEMENTATION
# ============================================================================

# Stack implementation using Ruby Array (LIFO - Last In First Out).
#
# Example: [1, 2, 3] → push 4 → [1, 2, 3, 4] → pop → 4
class Stack
  def initialize
    @items = []
  end

  # Add element to top of stack.
  #
  # Time: O(1) amortized
  # Space: O(1)
  def push(val)
    @items.push(val)
  end

  # Remove and return top element.
  #
  # Time: O(1)
  # Space: O(1)
  #
  # Returns: nil if stack is empty
  def pop
    return nil if empty?

    @items.pop
  end

  # View top element without removing.
  #
  # Time: O(1)
  # Space: O(1)
  #
  # Returns: nil if stack is empty
  def peek
    return nil if empty?

    @items.last
  end

  # Check if stack is empty.
  #
  # Time: O(1)
  # Space: O(1)
  def empty?
    @items.empty?
  end

  # Get number of elements in stack.
  #
  # Time: O(1)
  # Space: O(1)
  def size
    @items.size
  end

  def to_s
    "Stack(#{@items})"
  end
end

# ============================================================================
# BASIC QUEUE IMPLEMENTATION
# ============================================================================

# Queue implementation using Ruby Array (FIFO - First In First Out).
#
# Note: Using shift for efficient O(1) dequeue operation in Ruby.
# Example: [1, 2, 3] → enqueue 4 → [1, 2, 3, 4] → dequeue → 1
class Queue
  def initialize
    @items = []
  end

  # Add element to back of queue.
  #
  # Time: O(1)
  # Space: O(1)
  def enqueue(val)
    @items.push(val)
  end

  # Remove and return front element.
  #
  # Time: O(1) amortized in Ruby
  # Space: O(1)
  #
  # Returns: nil if queue is empty
  def dequeue
    return nil if empty?

    @items.shift
  end

  # View front element without removing.
  #
  # Time: O(1)
  # Space: O(1)
  #
  # Returns: nil if queue is empty
  def front
    return nil if empty?

    @items.first
  end

  # Check if queue is empty.
  #
  # Time: O(1)
  # Space: O(1)
  def empty?
    @items.empty?
  end

  # Get number of elements in queue.
  #
  # Time: O(1)
  # Space: O(1)
  def size
    @items.size
  end

  def to_s
    "Queue(#{@items})"
  end
end

# ============================================================================
# PATTERN 1: VALID PARENTHESES
# ============================================================================

# Check if string has valid matching parentheses/brackets/braces.
#
# Time: O(n) - traverse string once
# Space: O(n) - stack can store up to n/2 opening brackets
#
# Approach: Use stack to match closing with opening brackets.
# - Push opening brackets: (, [, {
# - For closing brackets, pop and verify match
# - At end, stack must be empty
#
# Example: "()" → true
# Example: "([{}])" → true
# Example: "([)]" → false
# Example: "{[}" → false
def valid_parentheses?(str)
  matching = { '(' => ')', '[' => ']', '{' => '}' }
  stack = Stack.new

  str.each_char do |char|
    if matching.key?(char) # Opening bracket
      stack.push(char)
    else # Closing bracket
      return false if stack.empty?

      last_open = stack.pop
      return false if matching[last_open] != char
    end
  end

  stack.empty?
end

# Validate parentheses with special cases (empty spaces, etc).
#
# Time: O(n)
# Space: O(n)
#
# Example: "(a[b]{c})" → true
# Example: "[({})]" → true
def valid_parentheses_advanced?(str)
  matching = { '(' => ')', '[' => ']', '{' => '}' }
  stack = []

  str.each_char do |char|
    if matching.key?(char)
      stack.push(char)
    elsif matching.value?(char) # Closing bracket
      return false if stack.empty? || matching[stack.pop] != char
    end
  end

  stack.empty?
end

# ============================================================================
# PATTERN 2: MONOTONIC STACK
# ============================================================================

# Find next greater element for each element in array.
#
# Time: O(n) - each element pushed/popped once
# Space: O(n) - stack and result
#
# Approach: Use monotonic decreasing stack.
# - Maintain elements in decreasing order from bottom to top
# - For each element, pop all smaller elements (they found their answer)
# - Current element is the next greater for popped elements
#
# Example: [1, 5, 0, 3, 4, 5]
# Output: [5, -1, 3, 4, 5, -1]
# Explanation: 1→5, 5→-1 (no greater), 0→3, 3→4, 4→5, 5→-1
def next_greater_element(nums)
  result = Array.new(nums.length, -1)
  stack = [] # Monotonic decreasing stack

  (nums.length - 1).downto(0) do |i|
    # Pop elements smaller than current
    stack.pop while !stack.empty? && stack.last <= nums[i]

    # Top of stack is next greater (if exists)
    result[i] = stack.last if !stack.empty?

    # Push current element
    stack.push(nums[i])
  end

  result
end

# Find next greater element with circular array.
#
# Time: O(n)
# Space: O(n)
#
# Approach: Process array twice to handle circular nature.
#
# Example: [1, 2, 1]
# Output: [2, -1, 2]
# Explanation: Last 1's next greater is first 2 (circular)
def next_greater_element_circular(nums)
  result = Array.new(nums.length, -1)
  stack = []
  n = nums.length

  # Process array twice for circular behavior
  (2 * n).times do |i|
    idx = i % n

    while !stack.empty? && nums[stack.last] < nums[idx]
      result[stack.pop] = nums[idx]
    end

    stack.push(idx) if i < n
  end

  result
end

# Find days until warmer temperature for each day.
#
# Time: O(n)
# Space: O(n)
#
# Approach: Monotonic stack of indices.
# - For warmer day, calculate difference and pop
# - Stack maintains indices of days waiting for warmer day
#
# Example: [73, 74, 75, 71, 69, 72, 76, 73]
# Output:  [1,  1,  4,  2,  1,  1,  0,  0]
# Explanation: 73→74 (1 day), 74→75 (1 day), 75→76 (4 days), etc.
def daily_temperatures(temps)
  result = Array.new(temps.length, 0)
  stack = [] # Indices of increasing temperature

  temps.each_with_index do |temp, i|
    # Pop indices with lower temperature
    while !stack.empty? && temps[stack.last] < temp
      prev_idx = stack.pop
      result[prev_idx] = i - prev_idx
    end

    stack.push(i)
  end

  result
end

# Calculate water trapped after raining on elevation map.
#
# Time: O(n)
# Space: O(n) - monotonic stack
#
# Approach: Use monotonic decreasing stack of indices.
# - For each bar, calculate trapped water between it and bars in stack
# - Water depends on minimum of surrounding heights and current height
#
# Example: [0,1,0,2,1,0,1,3,2,1,2,1]
# Output: 6
# Visualization: Water trapped in valleys between peaks
def trapping_rain_water(height)
  stack = [] # Monotonic decreasing stack of indices
  water = 0

  height.each_with_index do |h, i|
    while !stack.empty? && height[stack.last] < h
      bottom_idx = stack.pop
      bottom_height = height[bottom_idx]

      break if stack.empty?

      # Distance between left and right bars
      width = i - stack.last - 1

      # Height of water: min of left/right minus bottom
      water_height = [height[stack.last], h].min - bottom_height

      water += width * water_height
    end

    stack.push(i)
  end

  water
end

# Find largest rectangle area in histogram.
#
# Time: O(n)
# Space: O(n)
#
# Approach: Use monotonic increasing stack of indices.
# - For decreasing height, pop and calculate area
# - Area = height * width (current position - position before popped)
#
# Example: [2,1,5,6,2,3]
# Output: 10
# Explanation: Rectangle with height 5 and width 2 (indices 2-3)
def largest_rectangle_in_histogram(heights)
  stack = []
  max_area = 0

  heights.each_with_index do |h, i|
    while !stack.empty? && heights[stack.last] > h
      h_idx = stack.pop
      height = heights[h_idx]

      # Width is distance to current position
      width = stack.empty? ? i : i - stack.last - 1

      area = height * width
      max_area = [max_area, area].max
    end

    stack.push(i)
  end

  # Process remaining bars
  while !stack.empty?
    h_idx = stack.pop
    height = heights[h_idx]
    width = stack.empty? ? heights.length : heights.length - stack.last - 1
    area = height * width
    max_area = [max_area, area].max
  end

  max_area
end

# ============================================================================
# PATTERN 3: MIN/MAX STACK
# ============================================================================

# Stack that supports push, pop, top, and retrieving minimum in O(1).
#
# Approach: Use auxiliary stack to track minimums.
# Each level of min_stack corresponds to min up to that point.
class MinStack
  def initialize
    @stack = []
    @min_stack = []
  end

  # Add value to stack and update minimum.
  #
  # Time: O(1)
  # Space: O(1)
  def push(val)
    @stack.push(val)

    # Update minimum stack
    @min_stack.push(val) if @min_stack.empty? || val <= @min_stack.last
  end

  # Remove top value. Update minimum if it's the min.
  #
  # Time: O(1)
  # Space: O(1)
  def pop
    return nil if @stack.empty?

    val = @stack.pop

    # Pop from min stack if top value is the minimum
    @min_stack.pop if !@min_stack.empty? && val == @min_stack.last

    val
  end

  # Return top value without removing.
  #
  # Time: O(1)
  # Space: O(1)
  def top
    @stack.empty? ? nil : @stack.last
  end

  # Return current minimum value.
  #
  # Time: O(1)
  # Space: O(1)
  def get_min
    @min_stack.empty? ? nil : @min_stack.last
  end

  def to_s
    "MinStack(items=#{@stack}, min=#{get_min})"
  end
end

# Stack that supports push, pop, top, and retrieving maximum in O(1).
#
# Approach: Use auxiliary stack to track maximums (similar to MinStack).
class MaxStack
  def initialize
    @stack = []
    @max_stack = []
  end

  # Add value to stack and update maximum.
  #
  # Time: O(1)
  # Space: O(1)
  def push(val)
    @stack.push(val)

    @max_stack.push(val) if @max_stack.empty? || val >= @max_stack.last
  end

  # Remove top value. Update maximum if it's the max.
  #
  # Time: O(1)
  # Space: O(1)
  def pop
    return nil if @stack.empty?

    val = @stack.pop

    @max_stack.pop if !@max_stack.empty? && val == @max_stack.last

    val
  end

  # Return top value without removing.
  #
  # Time: O(1)
  # Space: O(1)
  def top
    @stack.empty? ? nil : @stack.last
  end

  # Return current maximum value.
  #
  # Time: O(1)
  # Space: O(1)
  def get_max
    @max_stack.empty? ? nil : @max_stack.last
  end

  def to_s
    "MaxStack(items=#{@stack}, max=#{get_max})"
  end
end

# ============================================================================
# PATTERN 4: DEQUE EXAMPLES
# ============================================================================

# Find maximum in every sliding window of size k.
#
# Time: O(n) - each element processed once
# Space: O(k) - deque stores at most k elements
#
# Approach: Use deque to store indices of useful elements.
# - Deque is monotonic decreasing (max at front)
# - Remove indices outside window
# - Remove elements smaller than current (they can't be max while current exists)
#
# Example: nums=[1,3,1,2,0,5], k=3
# Output: [3,3,2,5]
# Windows: [1,3,1] → 3, [3,1,2] → 3, [1,2,0] → 2, [2,0,5] → 5
def sliding_window_maximum(nums, k)
  return [] if nums.empty? || k.zero?

  dq = [] # Stores indices
  result = []

  nums.each_with_index do |num, i|
    # Remove elements outside current window
    dq.shift while !dq.empty? && dq.first < i - k + 1

    # Remove elements smaller than current (monotonic decreasing)
    dq.pop while !dq.empty? && nums[dq.last] < num

    dq.push(i)

    # First window completes at index k-1
    result.push(nums[dq.first]) if i >= k - 1
  end

  result
end

# Find first negative number in each window of size k.
#
# Time: O(n)
# Space: O(k)
#
# Approach: Use deque to store indices of negative numbers.
# - Only store negatives (positives can't be answer)
# - Remove indices outside window
#
# Example: nums=[12,-1,-7,8], k=2
# Output: [-1,-7,-7]
def first_negative_in_window(nums, k)
  dq = []
  result = []

  nums.each_with_index do |num, i|
    # Remove negatives outside current window
    dq.shift while !dq.empty? && dq.first < i - k + 1

    # Add current if it's negative
    dq.push(i) if num.negative?

    # First window completes at index k-1
    result.push(dq.empty? ? 0 : nums[dq.first]) if i >= k - 1
  end

  result
end

# Count requests within recent time window using deque.
#
# Useful for rate limiting and monitoring.
class RecentCounter
  # Initialize counter.
  #
  # Time: O(1)
  # Space: O(1)
  def initialize
    @requests = []
  end

  # Record request at time t and return count in last 3000 ms.
  #
  # Time: O(n) where n is number of requests in window
  # Space: O(n)
  #
  # Approach: Remove outdated requests, then count.
  #
  # Example: ping(1) → 1 (t=1)
  #         ping(100) → 2 (t=1,100)
  #         ping(3001) → 3 (t=1,100,3001, but 1 is 3000ms ago, so all count)
  #         ping(3002) → 2 (t=100,3001,3002, t=1 is outside)
  def ping(t)
    # Remove requests older than t - 3000
    @requests.shift while !@requests.empty? && @requests.first < t - 3000

    @requests.push(t)
    @requests.size
  end
end

# Maximum consecutive 1's after flipping at most k 0's.
#
# Time: O(n) - sliding window
# Space: O(1)
#
# Approach: Use deque-based sliding window to track 0's.
# - Expand window by adding elements
# - When 0's exceed k, shrink from left
# - Track maximum window size
#
# Example: nums=[1,1,1,0,0,0,1,1,1,1,0], k=2
# Output: 6
# Explanation: Flip the two 0's in middle, get [1,1,1,1,1,1,1,1,1,1,0]
def max_consecutive_ones_iii(nums, k)
  zeros_pos = []
  left = 0
  max_length = 0

  nums.each_with_index do |num, right|
    zeros_pos.push(right) if num.zero?

    # If more than k zeros, move left pointer
    left = zeros_pos.shift + 1 if zeros_pos.size > k

    max_length = [max_length, right - left + 1].max
  end

  max_length
end

# ============================================================================
# PATTERN 5: BFS WITH QUEUE
# ============================================================================

# Simple tree node for BFS examples.
class TreeNode
  attr_accessor :val, :left, :right

  def initialize(val = 0, left = nil, right = nil)
    @val = val
    @left = left
    @right = right
  end
end

# Traverse binary tree level by level (BFS).
#
# Time: O(n) - visit each node once
# Space: O(w) - queue stores at most width of tree (usually O(n/2) at max)
#
# Approach: Use queue to process nodes level by level.
# - Enqueue root
# - For each level, dequeue node, process, enqueue children
# - Continue until queue empty
#
# Example: Tree:    1
#                  / \
#                 2   3
#          Output: [[1], [2, 3]]
def level_order_traversal(root)
  return [] unless root

  result = []
  queue = Queue.new
  queue.enqueue(root)

  until queue.empty?
    level_size = queue.size
    current_level = []

    # Process all nodes at current level
    level_size.times do
      node = queue.dequeue
      current_level.push(node.val)

      queue.enqueue(node.left) if node.left
      queue.enqueue(node.right) if node.right
    end

    result.push(current_level)
  end

  result
end

# Level order traversal using Ruby Array directly.
#
# Time: O(n)
# Space: O(w)
#
# More efficient than custom Queue class for real applications.
def level_order_traversal_array(root)
  return [] unless root

  result = []
  queue = [root]

  until queue.empty?
    level_size = queue.size
    current_level = []

    level_size.times do
      node = queue.shift
      current_level.push(node.val)

      queue.push(node.left) if node.left
      queue.push(node.right) if node.right
    end

    result.push(current_level)
  end

  result
end

# Get view of tree from right side (rightmost node at each level).
#
# Time: O(n)
# Space: O(h) where h is height
#
# Approach: BFS and take last node from each level.
#
# Example: Tree:    1
#                  / \
#                 2   3
#                  \   \
#                   5   4
#          Output: [1, 3, 4]
def right_side_view(root)
  return [] unless root

  result = []
  queue = [root]

  until queue.empty?
    level_size = queue.size

    level_size.times do |i|
      node = queue.shift

      # Take rightmost node from level
      result.push(node.val) if i == level_size - 1

      queue.push(node.left) if node.left
      queue.push(node.right) if node.right
    end
  end

  result
end

# Find shortest path in grid from top-left to bottom-right (BFS).
#
# Time: O(m*n) - visit each cell once
# Space: O(m*n) - queue and visited set
#
# Approach:
# 1. Start BFS from top-left
# 2. Explore neighbors in queue order
# 3. First time reaching bottom-right is shortest path
#
# Example: grid = [[0,1],
#                 [0,0]]
#          Output: 2 (only one path)
#
# Note: 0 = walkable, 1 = obstacle
def shortest_path_grid(grid)
  return -1 if grid.empty? || grid[0][0] == 1

  m = grid.length
  n = grid[0].length
  queue = [[0, 0, 1]] # [row, col, distance]
  visited = Set.new([[0, 0]])
  directions = [[0, 1], [1, 0], [0, -1], [-1, 0]]

  until queue.empty?
    row, col, dist = queue.shift

    return dist if row == m - 1 && col == n - 1

    directions.each do |dr, dc|
      new_row = row + dr
      new_col = col + dc

      if new_row >= 0 && new_row < m &&
         new_col >= 0 && new_col < n &&
         grid[new_row][new_col].zero? &&
         !visited.include?([new_row, new_col])
        visited.add([new_row, new_col])
        queue.push([new_row, new_col, dist + 1])
      end
    end
  end

  -1 # No path found
end

# ============================================================================
# HELPER FUNCTIONS
# ============================================================================

# Print stack contents from bottom to top.
#
# Time: O(n)
# Space: O(1)
def print_stack(stack)
  puts "Stack (bottom → top): #{stack.instance_variable_get(:@items).join(' → ')}"
end

# Print queue contents from front to back.
#
# Time: O(n)
# Space: O(1)
def print_queue(queue)
  puts "Queue (front → back): #{queue.instance_variable_get(:@items).join(' → ')}"
end

# ============================================================================
# TESTING
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=' * 70
  puts 'STACK OPERATIONS'
  puts '=' * 70

  # Basic Stack
  puts "\n--- Basic Stack ---"
  stack = Stack.new
  stack.push(1)
  stack.push(2)
  stack.push(3)
  print_stack(stack)
  puts "Peek: #{stack.peek}"
  puts "Pop: #{stack.pop}"
  print_stack(stack)

  # Valid Parentheses
  puts "\n--- Valid Parentheses ---"
  test_cases = [
    '()',
    '([{}])',
    '([)]',
    '{[}',
    ''
  ]
  test_cases.each do |test|
    result = valid_parentheses?(test)
    puts "'#{test}' → #{result}"
  end

  # Monotonic Stack - Next Greater Element
  puts "\n--- Next Greater Element ---"
  nums = [1, 5, 0, 3, 4, 5]
  result = next_greater_element(nums)
  puts "Input: #{nums}"
  puts "Output: #{result}"

  # Monotonic Stack - Daily Temperatures
  puts "\n--- Daily Temperatures ---"
  temps = [73, 74, 75, 71, 69, 72, 76, 73]
  result = daily_temperatures(temps)
  puts "Input: #{temps}"
  puts "Output: #{result}"

  # Min Stack
  puts "\n--- Min Stack ---"
  min_stack = MinStack.new
  min_stack.push(3)
  puts "Push 3: #{min_stack}"
  min_stack.push(1)
  puts "Push 1: #{min_stack}"
  min_stack.push(4)
  puts "Push 4: #{min_stack}"
  min_stack.push(1)
  puts "Push 1: #{min_stack}"
  min_stack.pop
  puts "Pop: #{min_stack}"

  # Max Stack
  puts "\n--- Max Stack ---"
  max_stack = MaxStack.new
  max_stack.push(1)
  max_stack.push(5)
  max_stack.push(3)
  puts "MaxStack after pushes: #{max_stack}"
  puts "Get max: #{max_stack.get_max}"

  # Trapping Rain Water
  puts "\n--- Trapping Rain Water ---"
  heights = [0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1]
  water = trapping_rain_water(heights)
  puts "Heights: #{heights}"
  puts "Water trapped: #{water}"

  # Largest Rectangle in Histogram
  puts "\n--- Largest Rectangle in Histogram ---"
  heights = [2, 1, 5, 6, 2, 3]
  area = largest_rectangle_in_histogram(heights)
  puts "Heights: #{heights}"
  puts "Largest rectangle area: #{area}"

  puts "\n#{'=' * 70}"
  puts 'QUEUE OPERATIONS'
  puts '=' * 70

  # Basic Queue
  puts "\n--- Basic Queue ---"
  queue = Queue.new
  queue.enqueue(1)
  queue.enqueue(2)
  queue.enqueue(3)
  print_queue(queue)
  puts "Front: #{queue.front}"
  puts "Dequeue: #{queue.dequeue}"
  print_queue(queue)

  # Sliding Window Maximum
  puts "\n--- Sliding Window Maximum ---"
  nums = [1, 3, 1, 2, 0, 5]
  k = 3
  result = sliding_window_maximum(nums, k)
  puts "Input: #{nums}, k=#{k}"
  puts "Output: #{result}"

  # First Negative in Window
  puts "\n--- First Negative in Window ---"
  nums = [12, -1, -7, 8]
  k = 2
  result = first_negative_in_window(nums, k)
  puts "Input: #{nums}, k=#{k}"
  puts "Output: #{result}"

  # Recent Counter
  puts "\n--- Recent Counter ---"
  counter = RecentCounter.new
  test_pings = [1, 100, 3001, 3002]
  test_pings.each do |ping|
    count = counter.ping(ping)
    puts "ping(#{ping}) → #{count}"
  end

  # Max Consecutive Ones III
  puts "\n--- Max Consecutive Ones III ---"
  nums = [1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0]
  k = 2
  result = max_consecutive_ones_iii(nums, k)
  puts "Input: #{nums}, k=#{k}"
  puts "Output: #{result}"

  puts "\n#{'=' * 70}"
  puts 'BFS WITH QUEUE'
  puts '=' * 70

  # Level Order Traversal
  puts "\n--- Level Order Traversal (BFS) ---"
  # Build tree:     1
  #                / \
  #               2   3
  tree_root = TreeNode.new(1)
  tree_root.left = TreeNode.new(2)
  tree_root.right = TreeNode.new(3)
  tree_root.left.left = TreeNode.new(4)
  tree_root.left.right = TreeNode.new(5)

  result = level_order_traversal(tree_root)
  puts "Level order: #{result}"

  # Right Side View
  puts "\n--- Right Side View ---"
  result = right_side_view(tree_root)
  puts "Right side view: #{result}"

  # Shortest Path in Grid
  puts "\n--- Shortest Path in Grid ---"
  grid = [
    [0, 0, 0],
    [1, 1, 0],
    [1, 0, 0]
  ]
  result = shortest_path_grid(grid)
  puts "Grid: #{grid}"
  puts "Shortest path distance: #{result}"

  puts "\n#{'=' * 70}"
  puts 'DEQUE EXAMPLES'
  puts '=' * 70

  # Using array directly
  puts "\n--- Direct Array Usage ---"
  dq = [1, 2, 3]
  puts "Initial array: #{dq}"
  dq.push(4)
  puts "After push(4): #{dq}"
  dq.unshift(0)
  puts "After unshift(0): #{dq}"
  puts "shift(): #{dq.shift}"
  puts "pop(): #{dq.pop}"
  puts "Final array: #{dq}"

  puts "\n#{'=' * 70}"
  puts 'ALL TESTS COMPLETED'
  puts '=' * 70
end
