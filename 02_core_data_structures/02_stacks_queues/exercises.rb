# frozen_string_literal: true

# Stacks and Queues - Exercises
#
# Implement the following stack and queue problems.
# Focus on understanding when to use stacks vs queues and pattern recognition.
#
# After attempting, check solutions.rb for answers and explanations.

# ============================================================================
# EXERCISE 1: Implement Stack using Array
# ============================================================================

# Implement a Stack (LIFO) using Ruby Array.
#
# Example: push(1) → push(2) → push(3) → pop() = 3
#
# Requirements:
# - All operations should be O(1) amortized
# - Track size
#
# TODO: Implement push, pop, peek, empty?, size
# Hint: Use Array push/pop methods (they're O(1) amortized)
class Stack
  def initialize
    # TODO: Initialize stack
  end

  # Add element to top of stack.
  #
  # Time: O(1) amortized
  # Space: O(1)
  #
  # TODO: Implement
  def push(val)
    # TODO
  end

  # Remove and return top element.
  #
  # Returns: Element or nil if empty
  # Time: O(1)
  # Space: O(1)
  #
  # TODO: Implement
  def pop
    # TODO
  end

  # View top element without removing.
  #
  # Returns: Element or nil if empty
  # Time: O(1)
  # Space: O(1)
  #
  # TODO: Implement
  def peek
    # TODO
  end

  # Check if stack is empty.
  #
  # Time: O(1)
  # Space: O(1)
  #
  # TODO: Implement
  def empty?
    # TODO
  end

  # Return number of elements in stack.
  #
  # Time: O(1)
  # Space: O(1)
  #
  # TODO: Implement
  def size
    # TODO
  end
end

# ============================================================================
# EXERCISE 2: Implement Queue using Array
# ============================================================================

# Implement a Queue (FIFO) using Ruby Array.
#
# Example: enqueue(1) → enqueue(2) → enqueue(3) → dequeue() = 1
#
# Requirements:
# - All operations should be O(1) amortized
# - Use Array (shift is O(1) amortized in Ruby)
# - Track size
#
# TODO: Implement enqueue, dequeue, front, empty?, size
# Hint: Array#push is O(1), Array#shift is O(1) amortized
class Queue
  def initialize
    # TODO: Initialize queue
  end

  # Add element to back of queue.
  #
  # Time: O(1)
  # Space: O(1)
  #
  # TODO: Implement
  def enqueue(val)
    # TODO
  end

  # Remove and return front element.
  #
  # Returns: Element or nil if empty
  # Time: O(1) amortized
  # Space: O(1)
  #
  # TODO: Implement
  def dequeue
    # TODO
  end

  # View front element without removing.
  #
  # Returns: Element or nil if empty
  # Time: O(1)
  # Space: O(1)
  #
  # TODO: Implement
  def front
    # TODO
  end

  # Check if queue is empty.
  #
  # Time: O(1)
  # Space: O(1)
  #
  # TODO: Implement
  def empty?
    # TODO
  end

  # Return number of elements in queue.
  #
  # Time: O(1)
  # Space: O(1)
  #
  # TODO: Implement
  def size
    # TODO
  end
end

# ============================================================================
# EXERCISE 3: Valid Parentheses
# ============================================================================

# Check if string has valid matching parentheses/brackets/braces.
#
# Example: "()" → true
# Example: "([{}])" → true
# Example: "([)]" → false
# Example: "{[}" → false
# Example: "" → true
#
# Requirements:
# - Time: O(n)
# - Space: O(n)
#
# TODO: Use stack to match closing with opening brackets
# Hint: Push opening brackets, pop and verify on closing bracket
def valid_parentheses?(str)
  # TODO
end

# ============================================================================
# EXERCISE 4: Min Stack
# ============================================================================

# Design a stack that supports push, pop, top, and retrieving minimum in O(1).
#
# Example: push(3) → push(1) → push(4) → push(1)
#          push(5) → get_min() = 1, pop() → get_min() = 1, pop() → get_min() = 1
#
# Requirements:
# - Time: O(1) for all operations
# - Space: O(n)
#
# TODO: Use auxiliary stack to track minimums at each level
# Hint: Synchronize pop operations between main and min stacks
class MinStack
  def initialize
    # TODO: Initialize MinStack
  end

  # Add value to stack.
  #
  # Time: O(1)
  # Space: O(1)
  #
  # TODO: Implement
  def push(val)
    # TODO
  end

  # Remove and return top value.
  #
  # Time: O(1)
  # Space: O(1)
  #
  # TODO: Implement
  def pop
    # TODO
  end

  # Return top value without removing.
  #
  # Time: O(1)
  # Space: O(1)
  #
  # TODO: Implement
  def top
    # TODO
  end

  # Return current minimum value.
  #
  # Time: O(1)
  # Space: O(1)
  #
  # TODO: Implement
  def get_min
    # TODO
  end
end

# ============================================================================
# EXERCISE 5: Next Greater Element
# ============================================================================

# Find next greater element for each element in array.
#
# Example: [1, 5, 0, 3, 4, 5] → [5, -1, 3, 4, 5, -1]
# Explanation: 1→5, 5→-1 (no greater), 0→3, 3→4, 4→5, 5→-1
#
# Requirements:
# - Time: O(n) - each element pushed/popped once
# - Space: O(n)
#
# TODO: Use monotonic decreasing stack
# Hint: Process array right to left, pop smaller elements
def next_greater_element(nums)
  # TODO
end

# ============================================================================
# EXERCISE 6: Daily Temperatures
# ============================================================================

# Find days until warmer temperature for each day.
#
# Example: [73,74,75,71,69,72,76,73] → [1,1,4,2,1,1,0,0]
# Explanation: 73→74 (1 day), 74→75 (1 day), 75→76 (4 days), etc.
#
# Requirements:
# - Time: O(n)
# - Space: O(n)
#
# TODO: Use monotonic stack of indices
# Hint: For warmer day, calculate difference with indices in stack
def daily_temperatures(temperatures)
  # TODO
end

# ============================================================================
# EXERCISE 7: Evaluate Reverse Polish Notation
# ============================================================================

# Evaluate expression in Reverse Polish Notation.
#
# Reverse Polish Notation (RPN) is where operators come after operands.
# Example: "3 4 +" means 3 + 4 = 7
#
# Example: ["2","1","+","3","*"] → 9 (means (2+1)*3)
# Example: ["4","13","5","/","+"] → 6 (means 4 + 13/5)
# Example: ["10","6","9","3","+","-11","*","/","*","17","+","5","+"] → 22
#
# Requirements:
# - Time: O(n)
# - Space: O(n)
#
# TODO: Use stack for operands
# Hint: Push operands, pop two operands when seeing operator
# Note: Integer division in Ruby can behave differently for negative numbers
def eval_rpn(tokens)
  # TODO
end

# ============================================================================
# EXERCISE 8: Implement Queue using Stacks
# ============================================================================

# Implement a Queue using two Stacks.
#
# Example: push(1) → push(2) → push(3) → pop() = 1
#
# Requirements:
# - Time: O(1) amortized for pop, O(1) for push
# - Space: O(n)
#
# TODO: Use two stacks (in_stack, out_stack)
# Hint: Use in_stack for push, transfer to out_stack for pop
class QueueUsingStacks
  def initialize
    # TODO: Initialize queue with two stacks
  end

  # Add element to queue.
  #
  # Time: O(1)
  #
  # TODO: Implement
  def push(val)
    # TODO
  end

  # Remove and return front element.
  #
  # Returns: Element
  # Time: O(1) amortized
  #
  # TODO: Implement
  def pop
    # TODO
  end

  # View front element without removing.
  #
  # Returns: Element
  # Time: O(1) amortized
  #
  # TODO: Implement
  def peek
    # TODO
  end

  # Check if queue is empty.
  #
  # Returns: Boolean
  # Time: O(1)
  #
  # TODO: Implement
  def empty?
    # TODO
  end
end

# ============================================================================
# EXERCISE 9: Implement Stack using Queues
# ============================================================================

# Implement a Stack using one or two Queues.
#
# Example: push(1) → push(2) → push(3) → pop() = 3
#
# Requirements:
# - Time: O(1) for push, O(n) for pop (or vice versa)
# - Space: O(n)
#
# TODO: Use one or two queues (choose approach)
# Hint: Option 1: One queue - rotate on pop
#       Option 2: Two queues - one for storage, one for temp
class StackUsingQueues
  def initialize
    # TODO: Initialize stack with queue(s)
  end

  # Add element to stack.
  #
  # Time: O(1) or O(n) depending on approach
  #
  # TODO: Implement
  def push(val)
    # TODO
  end

  # Remove and return top element.
  #
  # Returns: Element
  # Time: O(n) or O(1) depending on approach
  #
  # TODO: Implement
  def pop
    # TODO
  end

  # View top element without removing.
  #
  # Returns: Element
  # Time: O(1)
  #
  # TODO: Implement
  def top
    # TODO
  end

  # Check if stack is empty.
  #
  # Returns: Boolean
  # Time: O(1)
  #
  # TODO: Implement
  def empty?
    # TODO
  end
end

# ============================================================================
# EXERCISE 10: Sliding Window Maximum
# ============================================================================

# Find maximum in every sliding window of size k.
#
# Example: nums=[1,3,1,2,0,5], k=3 → [3,3,2,5]
# Windows: [1,3,1]→3, [3,1,2]→3, [1,2,0]→2, [2,0,5]→5
#
# Requirements:
# - Time: O(n)
# - Space: O(k)
#
# TODO: Use deque to store indices in decreasing order
# Hint: Remove indices outside window, maintain monotonic decreasing
def sliding_window_maximum(nums, k)
  # TODO
end

# ============================================================================
# EXERCISE 11: BFS Level Order Traversal
# ============================================================================

# Binary tree node for BFS.
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
# Example: Tree:    1
#                  / \
#                 2   3
#          Output: [[1], [2, 3]]
#
# Example: Tree:    3
#                  / \
#                 9  20
#                   /  \
#                  15   7
#          Output: [[3], [9, 20], [15, 7]]
#
# Requirements:
# - Time: O(n)
# - Space: O(w) where w is max width
#
# TODO: Use queue to process levels
# Hint: Track level_size, process level_size nodes, enqueue children
def level_order_traversal(root)
  # TODO
end

# ============================================================================
# EXERCISE 12: Number of Recent Calls
# ============================================================================

# Design a system to count recent requests within time window.
#
# You have a function that accepts a request at time t.
# Return the number of requests in last 3000 ms.
#
# Example:
# ping(1) → 1 (request at t=1)
# ping(100) → 2 (requests at t=1,100)
# ping(3001) → 3 (requests at t=1,100,3001, but 1 is 3000ms ago, counts)
# ping(3002) → 2 (requests at t=100,3001,3002; t=1 is outside window)
#
# Requirements:
# - Time: O(n) where n is requests in window (usually small)
# - Space: O(n)
#
# TODO: Use queue to store recent request times
# Hint: Remove requests older than t - 3000
class RecentCounter
  def initialize
    # TODO: Initialize counter
  end

  # Record request at time t.
  #
  # Returns: Number of requests in last 3000 ms
  # Time: O(n) amortized
  # Space: O(n)
  #
  # TODO: Implement
  def ping(t)
    # TODO
  end
end

# ============================================================================
# EXERCISE 13: Trapping Rain Water
# ============================================================================

# Calculate water trapped after raining on elevation map.
#
# Example: [0,1,0,2,1,0,1,3,2,1,2,1] → 6
# Visualization:
#    |
#  | |
#  | | |
#  |_|_|_|_|_|_
#
# Requirements:
# - Time: O(n)
# - Space: O(n)
#
# TODO: Use monotonic decreasing stack of indices
# Hint: When height increases, calculate water trapped between bars
def trap_rain_water(height)
  # TODO
end

# ============================================================================
# EXERCISE 14: Largest Rectangle in Histogram
# ============================================================================

# Find largest rectangle area in histogram.
#
# Example: [2,1,5,6,2,3] → 10
# Explanation: Rectangle with height 5 and width 2 (indices 2-3)
#
# Example: [2,4] → 4
# Example: [1] → 1
#
# Requirements:
# - Time: O(n)
# - Space: O(n)
#
# TODO: Use monotonic increasing stack of indices
# Hint: For decreasing height, pop and calculate area
def largest_rectangle_in_histogram(heights)
  # TODO
end

# ============================================================================
# EXERCISE 15: Asteroid Collision
# ============================================================================

# Simulate asteroids colliding in a line.
#
# Each asteroid size represented by integer.
# Positive → moving right, Negative → moving left.
# Collision occurs when right-moving hits left-moving.
# Larger destroys smaller. Equal size both destroyed.
#
# Example: [5,10,-5] → [5,10]
# Explanation: -5 hits 10, 10 wins and continues right
#
# Example: [8,-8] → []
# Explanation: They collide and destroy each other
#
# Example: [10,2,-5] → [10]
# Explanation: 2→right, -5→left, they collide, 2 destroys
#              10→right, 2→left (was moving right), no collision
#
# Requirements:
# - Time: O(n)
# - Space: O(n)
#
# TODO: Use stack to handle collisions
# Hint: Push positive, process negative to handle collisions
def asteroid_collision(asteroids)
  # TODO
end

# ============================================================================
# EXERCISE 16: Word Ladder II
# ============================================================================

# Find all shortest transformation sequences from begin_word to end_word.
#
# A transformation is changing one letter at a time.
# All intermediate words must exist in word_list.
#
# Example:
# begin_word = "hit"
# end_word = "cog"
# word_list = ["hot","dot","dog","lot","log","cog"]
#
# Output: [["hit","hot","dot","dog","cog"],
#          ["hit","hot","lot","log","cog"]]
#
# Requirements:
# - Time: O(n * l^2) where n is word count, l is word length
# - Space: O(n * l)
#
# TODO: Use BFS to find shortest paths, then backtrack
# Hint: First find shortest distances using BFS, then DFS to build paths
# This is an advanced problem!
def find_ladders(begin_word, end_word, word_list)
  # TODO
end

# ============================================================================
# EXERCISE 17: LRU Cache Design
# ============================================================================

# Design and implement an LRU (Least Recently Used) Cache.
#
# - Capacity is fixed
# - get(key): Return value if key exists, else return -1, mark as recently used
# - put(key, value): Update value if key exists, add if not
# - When capacity exceeded, evict least recently used item
#
# Example:
# LRUCache.new(2)  # capacity 2
# put(1, 1)
# put(2, 2)
# get(1)  → 1
# put(3, 3)  # evicts 2
# get(2)  → -1 (not found)
# put(4, 4)  # evicts 1
# get(1)  → -1 (not found)
# get(3)  → 3
# get(4)  → 4
#
# Requirements:
# - Time: O(1) for get and put
# - Space: O(capacity)
#
# TODO: Use hash map + doubly linked list
# Hint: Hash map for O(1) access, doubly linked list for O(1) removal/reordering
# This is a challenging design problem!
class LRUCache
  def initialize(capacity)
    # TODO: Initialize cache with given capacity
    # Time: O(1)
    # Space: O(capacity)
  end

  # Get value and mark as recently used.
  #
  # Returns: Value or -1
  # Time: O(1)
  # Space: O(1)
  #
  # TODO: Implement
  def get(key)
    # TODO
  end

  # Update value or add new key-value pair.
  #
  # Time: O(1)
  # Space: O(1)
  #
  # TODO: Implement
  def put(key, value)
    # TODO
  end
end

# ============================================================================
# HELPER FUNCTIONS (provided for testing)
# ============================================================================

# Create binary tree from level-order array.
# nil represents null nodes.
#
# Example: [1, 2, 3] creates tree:
#     1
#    / \
#   2   3
def create_binary_tree(values)
  return nil if values.nil? || values.empty? || values[0].nil?

  root = TreeNode.new(values[0])
  queue = [root]
  i = 1

  until queue.empty? || i >= values.length
    node = queue.shift

    if i < values.length && !values[i].nil?
      node.left = TreeNode.new(values[i])
      queue.push(node.left)
    end

    i += 1

    if i < values.length && !values[i].nil?
      node.right = TreeNode.new(values[i])
      queue.push(node.right)
    end

    i += 1
  end

  root
end

# Print tree as levels.
def print_tree_levels(root)
  return [] unless root

  level_order_traversal(root)
end

# Print stack from bottom to top.
def print_stack(stack)
  items = stack.instance_variable_get(:@items) if stack.instance_variable_defined?(:@items)
  puts "Stack: #{items || '[implementation specific]'}"
end

# Print queue from front to back.
def print_queue(queue)
  items = queue.instance_variable_get(:@items) if queue.instance_variable_defined?(:@items)
  puts "Queue: #{items || '[implementation specific]'}"
end

# ============================================================================
# TESTING YOUR SOLUTIONS
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts 'Test your solutions!'
  puts 'Run: ruby exercises.rb'
  puts "Compare with solutions.rb when done.\n"

  # Example test - Stack
  puts '=== Test Stack ==='
  # stack = Stack.new
  # stack.push(1)
  # stack.push(2)
  # stack.push(3)
  # puts "Stack size: #{stack.size}"  # Should be 3
  # puts "Peek: #{stack.peek}"  # Should be 3
  # puts "Pop: #{stack.pop}"  # Should be 3
  # puts "Pop: #{stack.pop}"  # Should be 2

  # Example test - Queue
  puts "\n=== Test Queue ==="
  # queue = Queue.new
  # queue.enqueue(1)
  # queue.enqueue(2)
  # queue.enqueue(3)
  # puts "Queue size: #{queue.size}"  # Should be 3
  # puts "Front: #{queue.front}"  # Should be 1
  # puts "Dequeue: #{queue.dequeue}"  # Should be 1
  # puts "Dequeue: #{queue.dequeue}"  # Should be 2

  # Example test - Valid Parentheses
  puts "\n=== Test Valid Parentheses ==="
  test_cases = [
    ['()', true],
    ['([{}])', true],
    ['([)]', false],
    ['{[}', false],
    ['', true]
  ]
  # test_cases.each do |s, expected|
  #   result = valid_parentheses?(s)
  #   status = result == expected ? '✓' : '✗'
  #   puts "#{status} '#{s}' → #{result}"
  # end

  # Example test - Min Stack
  puts "\n=== Test Min Stack ==="
  # min_stack = MinStack.new
  # min_stack.push(3)
  # min_stack.push(1)
  # min_stack.push(4)
  # min_stack.push(1)
  # puts "Min: #{min_stack.get_min}"  # Should be 1
  # min_stack.pop
  # puts "Min: #{min_stack.get_min}"  # Should be 1
  # min_stack.pop
  # puts "Min: #{min_stack.get_min}"  # Should be 1
  # min_stack.pop
  # puts "Min: #{min_stack.get_min}"  # Should be 3

  # Example test - Next Greater Element
  puts "\n=== Test Next Greater Element ==="
  # nums = [1, 5, 0, 3, 4, 5]
  # result = next_greater_element(nums)
  # puts "Input: #{nums}"
  # puts "Output: #{result}"  # Should be [5, -1, 3, 4, 5, -1]

  # Example test - Daily Temperatures
  puts "\n=== Test Daily Temperatures ==="
  # temps = [73, 74, 75, 71, 69, 72, 76, 73]
  # result = daily_temperatures(temps)
  # puts "Input: #{temps}"
  # puts "Output: #{result}"  # Should be [1, 1, 4, 2, 1, 1, 0, 0]

  # Example test - Evaluate RPN
  puts "\n=== Test Evaluate RPN ==="
  # tokens = ['2', '1', '+', '3', '*']
  # result = eval_rpn(tokens)
  # puts "Input: #{tokens}"
  # puts "Output: #{result}"  # Should be 9

  # Example test - Sliding Window Maximum
  puts "\n=== Test Sliding Window Maximum ==="
  # nums = [1, 3, 1, 2, 0, 5]
  # k = 3
  # result = sliding_window_maximum(nums, k)
  # puts "Input: #{nums}, k=#{k}"
  # puts "Output: #{result}"  # Should be [3, 3, 2, 5]

  # Example test - Level Order Traversal
  puts "\n=== Test Level Order Traversal ==="
  # root = create_binary_tree([3, 9, 20, nil, nil, 15, 7])
  # result = level_order_traversal(root)
  # puts "Output: #{result}"  # Should be [[3], [9, 20], [15, 7]]

  # Example test - Recent Counter
  puts "\n=== Test Recent Counter ==="
  # counter = RecentCounter.new
  # pings = [1, 100, 3001, 3002]
  # pings.each do |ping|
  #   result = counter.ping(ping)
  #   puts "ping(#{ping}) → #{result}"
  # end

  puts "\n#{'=' * 70}"
  puts 'TESTING COMPLETED'
  puts '=' * 70
end
