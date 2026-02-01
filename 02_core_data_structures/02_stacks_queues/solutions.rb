# frozen_string_literal: true

# Stacks and Queues - Solutions
#
# Complete solutions with explanations for all exercises.
# Study the approach and complexity analysis for each problem.

# ============================================================================
# EXERCISE 1: Implement Stack using Array
# ============================================================================

# Implement a Stack (LIFO) using Ruby Array.
#
# Example: push(1) → push(2) → push(3) → pop() = 3
#
# Approach:
# - Use Ruby Array with push/pop for O(1) amortized operations
# - push() adds to end (top of stack)
# - pop() removes from end (top of stack)
# - Both are O(1) amortized
#
# Time: O(1) amortized for all operations
# Space: O(n) for n elements in stack
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
  # Returns: Element or nil if empty
  # Time: O(1)
  # Space: O(1)
  def pop
    return nil if empty?

    @items.pop
  end

  # View top element without removing.
  #
  # Returns: Element or nil if empty
  # Time: O(1)
  # Space: O(1)
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

  # Return number of elements in stack.
  #
  # Time: O(1)
  # Space: O(1)
  def size
    @items.size
  end
end

# ============================================================================
# EXERCISE 2: Implement Queue using Array
# ============================================================================

# Implement a Queue (FIFO) using Ruby Array.
#
# Example: enqueue(1) → enqueue(2) → enqueue(3) → dequeue() = 1
#
# Approach:
# - Use Array with push/shift for queue operations
# - push() adds to back (rear of queue)
# - shift() removes from front of queue
# - Array#shift is O(1) amortized in Ruby
#
# Time: O(1) amortized for all operations
# Space: O(n) for n elements in queue
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
  # Returns: Element or nil if empty
  # Time: O(1) amortized
  # Space: O(1)
  def dequeue
    return nil if empty?

    @items.shift
  end

  # View front element without removing.
  #
  # Returns: Element or nil if empty
  # Time: O(1)
  # Space: O(1)
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

  # Return number of elements in queue.
  #
  # Time: O(1)
  # Space: O(1)
  def size
    @items.size
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
# Approach:
# - Use stack to match closing with opening brackets
# - Push opening brackets onto stack
# - For closing brackets, check top of stack matches
# - Stack must be empty at end
#
# Key Insight:
# - Each closing bracket must match most recent unmatched opening bracket
# - This is the definition of stack (LIFO) behavior
#
# Time: O(n) - visit each character once
# Space: O(n) - stack stores opening brackets
def valid_parentheses?(str)
  stack = []
  pairs = { '(' => ')', '[' => ']', '{' => '}' }

  str.each_char do |char|
    if pairs.key?(char) # Opening bracket
      stack.push(char)
    else # Closing bracket
      return false if stack.empty? || pairs[stack.pop] != char
    end
  end

  stack.empty?
end

# ============================================================================
# EXERCISE 4: Min Stack
# ============================================================================

# Design a stack that supports push, pop, top, and retrieving minimum in O(1).
#
# Example: push(3) → push(1) → push(4) → push(1)
#          push(5) → get_min() = 1, pop() → get_min() = 1
#
# Approach:
# - Use auxiliary stack to track minimum at each level
# - Main stack: stores all values
# - Min stack: stores minimum value at each level
# - When pushing: push value to main, push min(value, top of min stack)
# - When popping: pop from both stacks
#
# Key Insight:
# - Can't just store single min value - need to track history
# - After pop, need previous minimum for remaining elements
#
# Time: O(1) for all operations
# Space: O(n) - both stacks can have n elements
class MinStack
  def initialize
    @stack = []
    @min_stack = []
  end

  # Add value to stack.
  #
  # Time: O(1)
  # Space: O(1)
  def push(val)
    @stack.push(val)
    if @min_stack.empty?
      @min_stack.push(val)
    else
      @min_stack.push([val, @min_stack.last].min)
    end
  end

  # Remove and return top value.
  #
  # Time: O(1)
  # Space: O(1)
  def pop
    return nil if @stack.empty?

    @min_stack.pop
    @stack.pop
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
end

# ============================================================================
# EXERCISE 5: Next Greater Element
# ============================================================================

# Find next greater element for each element in array.
#
# Example: [1, 5, 0, 3, 4, 5] → [5, -1, 3, 4, 5, -1]
# Explanation: 1→5, 5→-1 (no greater), 0→3, 3→4, 4→5, 5→-1
#
# Approach:
# - Use monotonic decreasing stack (stores indices)
# - Process array right to left
# - For each element:
#   - Pop all smaller elements from stack
#   - Top of stack (if exists) is next greater element
#   - Push current element
#
# Example trace for [1, 5, 0, 3, 4, 5]:
# - Start right: 5, stack=[5]
# - 4: 4<5, pop nothing, answer[4]=5, stack=[5,4]
# - 3: 3<4, pop 4, 3<5, pop nothing, answer[3]=4, stack=[5,3]
# - 0: 0<3, pop 3, 0<5, pop nothing, answer[0]=5, stack=[5,0]
# - 5: 5>0, pop 0, 5=5, pop 5, stack empty, answer[1]=-1, stack=[5]
#
# Key Insight:
# - Decreasing stack maintains candidates for "next greater"
# - Processing right to left ensures we see larger elements first
#
# Time: O(n) - each element pushed and popped once
# Space: O(n) - stack storage
def next_greater_element(nums)
  result = Array.new(nums.length, -1)
  stack = []

  # Process right to left
  (nums.length - 1).downto(0) do |i|
    # Pop smaller elements
    stack.pop while !stack.empty? && stack.last <= nums[i]

    # Top of stack is next greater (if exists)
    result[i] = stack.last if !stack.empty?

    # Push current element
    stack.push(nums[i])
  end

  result
end

# ============================================================================
# EXERCISE 6: Daily Temperatures
# ============================================================================

# Find days until warmer temperature for each day.
#
# Example: [73,74,75,71,69,72,76,73] → [1,1,4,2,1,1,0,0]
# Explanation: 73→74 (1 day), 74→75 (1 day), 75→76 (4 days), etc.
#
# Approach:
# - Use monotonic decreasing stack of indices
# - Process array right to left
# - For each day:
#   - Pop indices of days with lower/equal temperatures
#   - Remaining top index is first warmer day
#   - Calculate difference
#
# Example trace for [73,74,75,71,69,72,76,73]:
# - i=7 (73): stack empty, answer[7]=0, stack=[7]
# - i=6 (76): 76>73, pop 7, stack empty, answer[6]=0, stack=[6]
# - i=5 (72): 72<76, answer[5]=1, stack=[6,5]
# - i=4 (69): 69<72, answer[4]=1, stack=[6,5,4]
# - i=3 (71): 71>69, pop 4, 71<72, answer[3]=2, stack=[6,5,3]
# - i=2 (75): 75>71, pop 3, 75>72, pop 5, 75<76, answer[2]=4, stack=[6,2]
# - i=1 (74): 74<75, answer[1]=1, stack=[6,2,1]
# - i=0 (73): 73<74, answer[0]=1, stack=[6,2,1,0]
#
# Key Insight:
# - Stack maintains indices in decreasing temperature order
# - When we find warmer day, difference = current_index - stack_top
#
# Time: O(n) - each index pushed and popped once
# Space: O(n) - stack storage
def daily_temperatures(temperatures)
  result = Array.new(temperatures.length, 0)
  stack = []

  (temperatures.length - 1).downto(0) do |i|
    # Pop days with lower or equal temperature
    stack.pop while !stack.empty? && temperatures[stack.last] <= temperatures[i]

    # Top is first warmer day
    result[i] = stack.last - i if !stack.empty?

    stack.push(i)
  end

  result
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
#
# Approach:
# - Use stack for operands
# - Scan tokens left to right:
#   - If number: push to stack
#   - If operator: pop two operands, apply, push result
# - Final result is only element in stack
#
# Example trace for ["2","1","+","3","*"]:
# - "2": push 2, stack=[2]
# - "1": push 1, stack=[2,1]
# - "+": pop 1,2; 2+1=3; push 3, stack=[3]
# - "3": push 3, stack=[3,3]
# - "*": pop 3,3; 3*3=9; push 9, stack=[9]
# - Result: 9
#
# Key Insight:
# - RPN order matches stack evaluation perfectly
# - Operators immediately follow their operands
#
# Note:
# - Ruby division for integers truncates toward negative infinity
# - For negative division: -13 / 5 = -3, but we want -2
# - Use (a.to_f / b).to_i for truncation toward zero
#
# Time: O(n) - process each token once
# Space: O(n) - stack stores operands
def eval_rpn(tokens)
  stack = []

  tokens.each do |token|
    if %w[+ - * /].include?(token)
      # Pop two operands (note: order matters for - and /)
      b = stack.pop
      a = stack.pop

      case token
      when '+'
        stack.push(a + b)
      when '-'
        stack.push(a - b)
      when '*'
        stack.push(a * b)
      when '/'
        # Truncate toward zero (not toward negative infinity)
        stack.push((a.to_f / b).to_i)
      end
    else
      stack.push(token.to_i)
    end
  end

  stack[0]
end

# ============================================================================
# EXERCISE 8: Implement Queue using Stacks
# ============================================================================

# Implement a Queue using two Stacks.
#
# Example: push(1) → push(2) → push(3) → pop() = 1
#
# Approach:
# - in_stack: stores newly added elements
# - out_stack: stores elements in queue order
# - push(x): always add to in_stack
# - pop(): if out_stack empty, transfer all from in_stack, then pop from out_stack
#
# Example trace for push(1,2,3) → pop():
# - push(1): in_stack=[1], out_stack=[]
# - push(2): in_stack=[1,2], out_stack=[]
# - push(3): in_stack=[1,2,3], out_stack=[]
# - pop(): transfer in_stack→out_stack, out_stack=[3,2,1], pop=1
#
# Key Insight:
# - Transfer from in_stack reverses order, giving us FIFO
# - Amortized O(1): each element transferred once per pop
# - pop() can be O(n) worst case, but amortized O(1)
#
# Time:
# - push: O(1)
# - pop/peek: O(1) amortized (transfer is O(n) but happens infrequently)
# Space: O(n)
class QueueUsingStacks
  def initialize
    @in_stack = []
    @out_stack = []
  end

  # Add element to queue.
  #
  # Time: O(1)
  def push(val)
    @in_stack.push(val)
  end

  # Helper: transfer from in_stack to out_stack when out_stack empty.
  def transfer
    return unless @out_stack.empty?

    @out_stack.push(@in_stack.pop) until @in_stack.empty?
  end

  # Remove and return front element.
  #
  # Returns: Element
  # Time: O(1) amortized
  def pop
    transfer
    @out_stack.pop
  end

  # View front element without removing.
  #
  # Returns: Element
  # Time: O(1) amortized
  def peek
    transfer
    @out_stack.last
  end

  # Check if queue is empty.
  #
  # Returns: Boolean
  # Time: O(1)
  def empty?
    @in_stack.empty? && @out_stack.empty?
  end
end

# ============================================================================
# EXERCISE 9: Implement Stack using Queues
# ============================================================================

# Implement a Stack using one Queue.
#
# Example: push(1) → push(2) → push(3) → pop() = 3
#
# Approach (using one queue):
# - Store all elements in single queue
# - push(x): add element, then rotate (size-1) times to move it to front
# - pop(): simply dequeue (front element is most recent)
#
# Example trace for push(1,2,3) → pop():
# - push(1): enqueue 1, rotate 0 times, queue=[1]
# - push(2): enqueue 2, queue=[1,2], rotate 1 time, queue=[2,1]
# - push(3): enqueue 3, queue=[2,1,3], rotate 2 times, queue=[3,2,1]
# - pop(): dequeue 3, queue=[2,1]
#
# Rotation mechanism:
# - Rotate operation: shift then push (n times)
# - After rotation, newest element is at front
#
# Key Insight:
# - push() is expensive: O(n) due to rotation
# - pop() is efficient: O(1)
# - Could do opposite (push O(1), pop O(n))
#
# Time:
# - push: O(n) due to rotation
# - pop: O(1)
# Space: O(n)
class StackUsingQueues
  def initialize
    @queue = []
  end

  # Add element to stack.
  #
  # Time: O(n)
  def push(val)
    @queue.push(val)
    # Rotate to move new element to front
    (@queue.size - 1).times do
      @queue.push(@queue.shift)
    end
  end

  # Remove and return top element.
  #
  # Returns: Element
  # Time: O(1)
  def pop
    @queue.shift
  end

  # View top element without removing.
  #
  # Returns: Element
  # Time: O(1)
  def top
    @queue.first
  end

  # Check if stack is empty.
  #
  # Returns: Boolean
  # Time: O(1)
  def empty?
    @queue.empty?
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
# Approach:
# - Use deque to store indices in decreasing value order
# - Maintain monotonic decreasing deque
# - For each element:
#   - Remove indices outside current window
#   - Remove indices of smaller elements (they can't be max)
#   - Current max is front of deque
#   - Add current index
#
# Example trace for [1,3,1,2,0,5], k=3:
# - i=0 (1): deque=[0]
# - i=1 (3): 3>1, remove 0, deque=[1]
# - i=2 (1): 1<3, deque=[1,2], max=3
# - i=3 (2): 2>1, remove 2, 2<3, deque=[1,3], max=3
# - i=4 (0): 0<2, deque=[1,3,4], max=2
# - i=5 (5): 5>0, remove 4, 5>2, remove 3, 5>3, remove 1, deque=[5], max=5
#
# Key Insight:
# - Deque stores indices, not values (need to check values)
# - Front always has max in current window
# - Only add necessary indices (ignore smaller ones)
#
# Time: O(n) - each index added and removed once
# Space: O(k) - deque stores at most k indices
def sliding_window_maximum(nums, k)
  return [] if nums.empty? || k.zero?

  deq = []
  result = []

  nums.each_with_index do |num, i|
    # Remove indices outside current window
    deq.shift while !deq.empty? && deq.first < i - k + 1

    # Remove indices of smaller elements
    deq.pop while !deq.empty? && nums[deq.last] <= num

    # Add current index
    deq.push(i)

    # Record max (front of deque)
    result.push(nums[deq.first]) if i >= k - 1
  end

  result
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
# Approach:
# - Use queue for BFS
# - Track level size (number of nodes at current level)
# - Process all nodes in level, enqueue their children
# - Each iteration of outer loop processes one level
#
# Key Insight:
# - level_size tells us how many nodes to dequeue before moving to next level
# - Without tracking level_size, hard to separate levels
# - Alternative: use nil markers between levels
#
# Time: O(n) - visit each node once
# Space: O(w) where w is maximum width (number of nodes at widest level)
def level_order_traversal(root)
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
# Approach:
# - Use queue to store recent request times
# - For each ping:
#   - Add new request time
#   - Remove requests older than t - 3000
#   - Return length of queue
#
# Key Insight:
# - Requests are in chronological order (timestamps increasing)
# - Only remove from front (oldest requests)
# - No need to remove from middle or end
#
# Time: O(n) amortized where n is requests in window (typically small)
# Space: O(n) where n is requests in window
class RecentCounter
  def initialize
    @requests = []
  end

  # Record request at time t.
  #
  # Returns: Number of requests in last 3000 ms
  # Time: O(n) amortized
  # Space: O(n)
  def ping(t)
    @requests.push(t)

    # Remove requests older than t - 3000
    @requests.shift while !@requests.empty? && @requests.first < t - 3000

    @requests.size
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
# Approach:
# - Use monotonic decreasing stack of indices
# - For each bar:
#   - If taller than stack top, water is trapped
#   - Pop smaller bar, calculate water above it
#   - Water height = min(current bar, left bar) - popped bar
#   - Water width = distance between current and left
# - Continue while stack has elements
#
# Example trace for [0,1,0,2,1,0,1,3,2,1,2,1]:
# - i=0: h[0]=0, stack=[0]
# - i=1: h[1]=1>0, pop 0, stack empty, stack=[1]
# - i=2: h[2]=0<1, stack=[1,2]
# - i=3: h[3]=2>0, pop 2, h[2]=0, left=h[1]=1
#         water = min(2,1)-0 = 1, width = 3-1-1 = 1, trapped=1
#         h[3]=2>1, pop 1, h[1]=1, left empty, stack=[3]
# - ... continue
#
# Key Insight:
# - Monotonic decreasing: maintains increasing distances
# - When we see taller bar, we know water level
# - Water height = min(left, right) - current height
# - Stack stores indices, not values (need to check values)
#
# Time: O(n) - each bar pushed and popped once
# Space: O(n) - stack storage
def trap_rain_water(height)
  return 0 if height.empty?

  stack = []
  water = 0

  height.each_with_index do |h, i|
    while !stack.empty? && h > height[stack.last]
      top = stack.pop

      break if stack.empty?

      left = stack.last
      # Water height = min(left bar, right bar) - middle bar
      water_height = [height[left], h].min - height[top]
      # Width = distance between left and right bars
      width = i - left - 1
      water += water_height * width
    end

    stack.push(i)
  end

  water
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
# Approach:
# - Use monotonic increasing stack of indices
# - For each bar:
#   - While stack has taller bars, pop and calculate area
#   - Area = height * width
#   - Width = distance to current bar (how far this height extends)
# - Process remaining stack at end
#
# Example trace for [2,1,5,6,2,3]:
# - i=0: h[0]=2, stack=[0]
# - i=1: h[1]=1<2, pop 0, area=2*1=2, max_area=2, stack=[1]
# - i=2: h[2]=5>1, stack=[1,2]
# - i=3: h[3]=6>5, stack=[1,2,3]
# - i=4: h[4]=2<6, pop 3, area=6*1=6
#          pop 2, area=5*2=10, max_area=10
#          h[4]=2>1, stack=[1,4]
# - i=5: h[5]=3>2, stack=[1,4,5]
# - End: pop 5, area=3*1=3; pop 4, area=2*3=6; pop 1, area=1*5=5
#
# Key Insight:
# - Monotonic increasing: ensures heights are processed properly
# - When height decreases, taller bars can't extend further
# - Width calculation: from previous element to current position
#
# Time: O(n) - each bar pushed and popped once
# Space: O(n) - stack storage
def largest_rectangle_in_histogram(heights)
  return 0 if heights.empty?

  stack = []
  max_area = 0

  heights.each_with_index do |h, i|
    while !stack.empty? && h < heights[stack.last]
      height = heights[stack.pop]
      width = stack.empty? ? i : i - stack.last - 1
      max_area = [max_area, height * width].max
    end

    stack.push(i)
  end

  # Process remaining bars in stack
  while !stack.empty?
    height = heights[stack.pop]
    width = stack.empty? ? heights.length : heights.length - stack.last - 1
    max_area = [max_area, height * width].max
  end

  max_area
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
# Approach:
# - Use stack to track asteroids (moving right)
# - For each asteroid:
#   - If moving right: push to stack
#   - If moving left: check collisions with stack
#     - While collision possible (stack not empty, top positive):
#       - If top destroys current: break (current destroyed)
#       - If current destroys top: pop and continue
#       - If equal: pop and break (both destroyed)
#     - If no collision, push current
#
# Example trace for [5,10,-5]:
# - 5: positive, stack=[5]
# - 10: positive, stack=[5,10]
# - -5: negative, collision!
#     10 vs 5: 10 > 5, -5 destroyed
# Result: [5,10]
#
# Key Insight:
# - Only positive (right-moving) stay in stack
# - Negatives immediately collide with them
# - No negative-to-negative or no collision between same direction
#
# Time: O(n) - each asteroid pushed and popped once
# Space: O(n) - stack storage
def asteroid_collision(asteroids)
  stack = []

  asteroids.each do |asteroid|
    alive = true

    while alive && asteroid.negative? && !stack.empty? && stack.last.positive?
      # Collision occurs
      top = stack.pop

      if top.abs > asteroid.abs
        # Right-moving wins, current destroyed
        stack.push(top)
        alive = false
      elsif top.abs == asteroid.abs
        # Both destroyed
        alive = false
      end

      # If left-moving wins, continue colliding with next
    end

    stack.push(asteroid) if alive
  end

  stack
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
# Approach:
# 1. Build graph: word → neighbors (one letter difference)
# 2. BFS from begin_word: find shortest path distance to each word
# 3. DFS from begin_word: backtrack using distances to build valid paths
#
# Key Insight:
# - BFS finds shortest distance to all words
# - DFS only explores paths that decrease distance (greedy)
# - Avoids cycles and guarantees shortest paths
#
# Time: O(n * l^2) where n is word count, l is word length
#      Building graph: O(n * l) comparisons
#      Each comparison: O(l) for building neighbors
#      BFS: O(n + edges)
#      DFS: explores valid paths
# Space: O(n * l) for graph
def find_ladders(begin_word, end_word, word_list)
  # Get all words one letter different.
  def get_neighbors(word, word_set)
    neighbors = []
    word.length.times do |i|
      ('a'..'z').each do |c|
        next if c == word[i]

        new_word = word.dup
        new_word[i] = c
        neighbors.push(new_word) if word_set.include?(new_word)
      end
    end
    neighbors
  end

  # Build graph
  word_set = Set.new(word_list)
  return [] unless word_set.include?(end_word)

  # BFS to find shortest distance
  distances = {}
  word_set.each { |word| distances[word] = -1 }
  distances[begin_word] = 0

  queue = [begin_word]
  until queue.empty?
    word = queue.shift
    get_neighbors(word, word_set).each do |neighbor|
      if distances[neighbor] == -1
        distances[neighbor] = distances[word] + 1
        queue.push(neighbor)
      end
    end
  end

  # DFS to build paths
  paths = []

  dfs = lambda do |word, path|
    if word == end_word
      paths.push(path.dup)
      return
    end

    get_neighbors(word, word_set).each do |neighbor|
      if distances[neighbor] == distances[word] + 1
        path.push(neighbor)
        dfs.call(neighbor, path)
        path.pop
      end
    end
  end

  dfs.call(begin_word, [begin_word]) if distances[end_word] != -1

  paths
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
# put(3, 3)  # evicts 2 (least recently used)
# get(2)  → -1 (not found)
# put(4, 4)  # evicts 1
# get(1)  → -1 (not found)
# get(3)  → 3
# get(4)  → 4
#
# Approach:
# - Hash map: key → node (for O(1) access)
# - Doubly linked list: maintains LRU order
#   - Head (sentinel): most recently used (newest)
#   - Tail (sentinel): least recently used (oldest)
# - On get/put: move node to head (mark as recently used)
# - On capacity exceeded: remove tail
#
# Why doubly linked list:
# - Need O(1) removal from middle (when moving to head)
# - Singly linked would be O(n) to find previous node
# - Maintains order without searching
#
# Key Insight:
# - Hash map gives O(1) access to node
# - Linked list gives O(1) update of order
# - Together: O(1) for get and put
#
# Time: O(1) for get and put
# Space: O(capacity)
class LRUCache
  # Node for doubly linked list
  class Node
    attr_accessor :key, :val, :prev, :next

    def initialize(key = 0, val = 0)
      @key = key
      @val = val
      @prev = nil
      @next = nil
    end
  end

  # Initialize cache with given capacity.
  #
  # Time: O(1)
  # Space: O(capacity)
  def initialize(capacity)
    @capacity = capacity
    @cache = {}

    # Sentinels for doubly linked list
    @head = Node.new # Most recently used
    @tail = Node.new # Least recently used
    @head.next = @tail
    @tail.prev = @head
  end

  # Add node right after head (most recently used).
  def add_to_head(node)
    node.prev = @head
    node.next = @head.next
    @head.next.prev = node
    @head.next = node
  end

  # Remove node from linked list.
  def remove_node(node)
    node.prev.next = node.next
    node.next.prev = node.prev
  end

  # Move node to head (mark as recently used).
  def move_to_head(node)
    remove_node(node)
    add_to_head(node)
  end

  # Get value and mark as recently used.
  #
  # Returns: Value or -1
  # Time: O(1)
  # Space: O(1)
  def get(key)
    return -1 unless @cache.key?(key)

    node = @cache[key]
    move_to_head(node)
    node.val
  end

  # Update value or add new key-value pair.
  #
  # Time: O(1)
  # Space: O(1)
  def put(key, value)
    if @cache.key?(key)
      # Update existing
      node = @cache[key]
      node.val = value
      move_to_head(node)
    else
      # Add new
      node = Node.new(key, value)
      @cache[key] = node
      add_to_head(node)

      # Evict if over capacity
      if @cache.size > @capacity
        lru_node = @tail.prev
        remove_node(lru_node)
        @cache.delete(lru_node.key)
      end
    end
  end
end

# ============================================================================
# HELPER FUNCTIONS
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

# ============================================================================
# TESTING
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=' * 70
  puts 'STACKS AND QUEUES - SOLUTIONS TEST'
  puts '=' * 70

  # Exercise 1: Stack
  puts "\n=== EXERCISE 1: Stack ==="
  stack = Stack.new
  stack.push(1)
  stack.push(2)
  stack.push(3)
  puts "Stack size: #{stack.size}" # Should be 3
  puts "Peek: #{stack.peek}" # Should be 3
  puts "Pop: #{stack.pop}" # Should be 3
  puts "Pop: #{stack.pop}" # Should be 2
  puts "Is empty: #{stack.empty?}" # Should be false

  # Exercise 2: Queue
  puts "\n=== EXERCISE 2: Queue ==="
  queue = Queue.new
  queue.enqueue(1)
  queue.enqueue(2)
  queue.enqueue(3)
  puts "Queue size: #{queue.size}" # Should be 3
  puts "Front: #{queue.front}" # Should be 1
  puts "Dequeue: #{queue.dequeue}" # Should be 1
  puts "Dequeue: #{queue.dequeue}" # Should be 2

  # Exercise 3: Valid Parentheses
  puts "\n=== EXERCISE 3: Valid Parentheses ==="
  test_cases = [
    ['()', true],
    ['([{}])', true],
    ['([)]', false],
    ['{[}', false],
    ['', true]
  ]
  test_cases.each do |s, expected|
    result = valid_parentheses?(s)
    status = result == expected ? '✓' : '✗'
    puts "#{status} '#{s}' → #{result} (expected #{expected})"
  end

  # Exercise 4: Min Stack
  puts "\n=== EXERCISE 4: Min Stack ==="
  min_stack = MinStack.new
  min_stack.push(3)
  min_stack.push(1)
  min_stack.push(4)
  min_stack.push(1)
  puts "Get min: #{min_stack.get_min}" # Should be 1
  min_stack.pop
  puts "After pop, min: #{min_stack.get_min}" # Should be 1
  min_stack.pop
  puts "After pop, min: #{min_stack.get_min}" # Should be 1
  min_stack.pop
  puts "After pop, min: #{min_stack.get_min}" # Should be 3

  # Exercise 5: Next Greater Element
  puts "\n=== EXERCISE 5: Next Greater Element ==="
  nums = [1, 5, 0, 3, 4, 5]
  result = next_greater_element(nums)
  expected = [5, -1, 3, 4, 5, -1]
  status = result == expected ? '✓' : '✗'
  puts "#{status} Input: #{nums}"
  puts "   Output: #{result}"
  puts "   Expected: #{expected}"

  # Exercise 6: Daily Temperatures
  puts "\n=== EXERCISE 6: Daily Temperatures ==="
  temps = [73, 74, 75, 71, 69, 72, 76, 73]
  result = daily_temperatures(temps)
  expected = [1, 1, 4, 2, 1, 1, 0, 0]
  status = result == expected ? '✓' : '✗'
  puts "#{status} Input: #{temps}"
  puts "   Output: #{result}"
  puts "   Expected: #{expected}"

  # Exercise 7: Evaluate RPN
  puts "\n=== EXERCISE 7: Evaluate RPN ==="
  test_cases = [[%w[2 1 + 3 *], 9], [%w[4 13 5 / +], 6]]
  test_cases.each do |tokens, expected|
    result = eval_rpn(tokens)
    status = result == expected ? '✓' : '✗'
    puts "#{status} #{tokens} → #{result} (expected #{expected})"
  end

  # Exercise 8: Queue Using Stacks
  puts "\n=== EXERCISE 8: Queue Using Stacks ==="
  queue_stack = QueueUsingStacks.new
  queue_stack.push(1)
  queue_stack.push(2)
  queue_stack.push(3)
  puts "Peek: #{queue_stack.peek}" # Should be 1
  puts "Pop: #{queue_stack.pop}" # Should be 1
  puts "Pop: #{queue_stack.pop}" # Should be 2
  puts "Empty: #{queue_stack.empty?}" # Should be false

  # Exercise 9: Stack Using Queues
  puts "\n=== EXERCISE 9: Stack Using Queues ==="
  stack_queue = StackUsingQueues.new
  stack_queue.push(1)
  stack_queue.push(2)
  stack_queue.push(3)
  puts "Top: #{stack_queue.top}" # Should be 3
  puts "Pop: #{stack_queue.pop}" # Should be 3
  puts "Pop: #{stack_queue.pop}" # Should be 2
  puts "Empty: #{stack_queue.empty?}" # Should be false

  # Exercise 10: Sliding Window Maximum
  puts "\n=== EXERCISE 10: Sliding Window Maximum ==="
  nums = [1, 3, 1, 2, 0, 5]
  k = 3
  result = sliding_window_maximum(nums, k)
  expected = [3, 3, 2, 5]
  status = result == expected ? '✓' : '✗'
  puts "#{status} Input: #{nums}, k=#{k}"
  puts "   Output: #{result}"
  puts "   Expected: #{expected}"

  # Exercise 11: Level Order Traversal
  puts "\n=== EXERCISE 11: Level Order Traversal ==="
  root = create_binary_tree([3, 9, 20, nil, nil, 15, 7])
  result = level_order_traversal(root)
  expected = [[3], [9, 20], [15, 7]]
  status = result == expected ? '✓' : '✗'
  puts "#{status} Output: #{result}"
  puts "   Expected: #{expected}"

  # Exercise 12: Recent Counter
  puts "\n=== EXERCISE 12: Recent Counter ==="
  counter = RecentCounter.new
  pings = [[1, 1], [100, 2], [3001, 3], [3002, 3]]
  pings.each do |ping, expected|
    result = counter.ping(ping)
    status = result == expected ? '✓' : '✗'
    puts "#{status} ping(#{ping}) → #{result} (expected #{expected})"
  end

  # Exercise 13: Trapping Rain Water
  puts "\n=== EXERCISE 13: Trapping Rain Water ==="
  height = [0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1]
  result = trap_rain_water(height)
  expected = 6
  status = result == expected ? '✓' : '✗'
  puts "#{status} Input: #{height}"
  puts "   Output: #{result} (expected #{expected})"

  # Exercise 14: Largest Rectangle in Histogram
  puts "\n=== EXERCISE 14: Largest Rectangle in Histogram ==="
  test_cases = [[[2, 1, 5, 6, 2, 3], 10], [[2, 4], 4], [[1], 1]]
  test_cases.each do |heights, expected|
    result = largest_rectangle_in_histogram(heights)
    status = result == expected ? '✓' : '✗'
    puts "#{status} #{heights} → #{result} (expected #{expected})"
  end

  # Exercise 15: Asteroid Collision
  puts "\n=== EXERCISE 15: Asteroid Collision ==="
  test_cases = [[[5, 10, -5], [5, 10]], [[8, -8], []], [[10, 2, -5], [10]]]
  test_cases.each do |asteroids, expected|
    result = asteroid_collision(asteroids)
    status = result == expected ? '✓' : '✗'
    puts "#{status} #{asteroids} → #{result}"
    puts "   (expected #{expected})"
  end

  # Exercise 16: Word Ladder II
  puts "\n=== EXERCISE 16: Word Ladder II ==="
  begin_word = 'hit'
  end_word = 'cog'
  word_list = %w[hot dot dog lot log cog]
  result = find_ladders(begin_word, end_word, word_list)
  puts "Begin: #{begin_word}, End: #{end_word}"
  puts "Paths found: #{result.length}"
  result.each do |path|
    puts "  #{path.join(' → ')}"
  end

  # Exercise 17: LRU Cache
  puts "\n=== EXERCISE 17: LRU Cache ==="
  lru = LRUCache.new(2)
  lru.put(1, 1)
  lru.put(2, 2)
  puts "get(1) → #{lru.get(1)}" # Should be 1
  lru.put(3, 3) # Evicts 2
  puts "get(2) → #{lru.get(2)}" # Should be -1
  lru.put(4, 4) # Evicts 1
  puts "get(1) → #{lru.get(1)}" # Should be -1
  puts "get(3) → #{lru.get(3)}" # Should be 3
  puts "get(4) → #{lru.get(4)}" # Should be 4

  puts "\n#{'=' * 70}"
  puts 'ALL TESTS COMPLETED'
  puts '=' * 70
end
