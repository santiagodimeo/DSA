# frozen_string_literal: true

# Linked Lists - Exercises
#
# Implement the following linked list problems.
# Focus on pointer manipulation and edge cases.
#
# After attempting, check solutions.rb for answers and explanations.

# ============================================================================
# NODE DEFINITION
# ============================================================================

class Node
  attr_accessor :val, :next

  def initialize(val = 0, next_node = nil)
    @val = val
    @next = next_node
  end
end

# ============================================================================
# HELPER FUNCTIONS (provided for testing)
# ============================================================================

# Create linked list from array.
def create_linked_list(arr)
  return nil if arr.empty?

  head = Node.new(arr[0])
  current = head
  (1...arr.length).each do |i|
    current.next = Node.new(arr[i])
    current = current.next
  end
  head
end

# Print linked list.
def print_list(head)
  values = []
  current = head
  while current
    values << current.val.to_s
    current = current.next
  end
  puts "#{values.join(' → ')} → nil"
end

# Convert linked list to array for testing.
def list_to_array(head)
  result = []
  current = head
  while current
    result << current.val
    current = current.next
  end
  result
end

# ============================================================================
# EXERCISE 1: Basic Operations
# ============================================================================

# Reverse a singly linked list.
#
# Example: [1→2→3→4→5] → [5→4→3→2→1]
#
# Requirements:
# - Time: O(n)
# - Space: O(1)
#
# TODO: Implement using three pointers (prev, current, next)
# Hint: Reverse each pointer one by one
def reverse_list(head)
  # Your code here
end

# Find the middle node of linked list.
# If two middle nodes, return the second one.
#
# Example: [1→2→3→4→5] → 3
# Example: [1→2→3→4] → 3
#
# Requirements:
# - Time: O(n)
# - Space: O(1)
#
# TODO: Use fast/slow pointer technique
# Hint: Slow moves 1 step, fast moves 2 steps
def find_middle(head)
  # Your code here
end

# Get the length of the linked list.
#
# Example: [1→2→3→4] → 4
# Example: [] → 0
#
# Requirements:
# - Time: O(n)
# - Space: O(1)
#
# TODO: Count nodes while traversing
def get_length(head)
  # Your code here
end

# ============================================================================
# EXERCISE 2: Two Pointers
# ============================================================================

# Detect if linked list has a cycle.
#
# Example: [1→2→3→4→2] (4 points back to 2) → true
# Example: [1→2→3→4] → false
#
# Requirements:
# - Time: O(n)
# - Space: O(1)
#
# TODO: Use Floyd's cycle detection (fast/slow pointers)
# Hint: If fast catches slow, there's a cycle
def has_cycle(head)
  # Your code here
end

# Remove nth node from end of list.
#
# Example: [1→2→3→4→5], n=2 → [1→2→3→5]
#
# Requirements:
# - Time: O(n)
# - Space: O(1)
#
# TODO: Use two pointers n steps apart
# Hint: Use dummy node to handle edge case of removing head
def remove_nth_from_end(head, n)
  # Your code here
end

# Find node where two linked lists intersect.
# Return nil if they don't intersect.
#
# Example:
# A: [1→2→3]
#                ↘
#                 [6→7→8]
#                ↗
# B: [4→5]
# Intersection at node with value 6
#
# Requirements:
# - Time: O(n + m)
# - Space: O(1)
#
# TODO: Calculate lengths, align lists, then traverse together
def find_intersection(head_a, head_b)
  # Your code here
end

# ============================================================================
# EXERCISE 3: Merge and Sort
# ============================================================================

# Merge two sorted linked lists.
#
# Example: [1→3→5] + [2→4→6] → [1→2→3→4→5→6]
#
# Requirements:
# - Time: O(n + m)
# - Space: O(1)
#
# TODO: Use dummy node and compare values
# Hint: Similar to merge step in merge sort
def merge_two_sorted_lists(l1, l2)
  # Your code here
end

# Sort linked list in ascending order.
#
# Example: [4→2→1→3] → [1→2→3→4]
#
# Requirements:
# - Time: O(n log n)
# - Space: O(log n) - recursion stack
#
# TODO: Use merge sort (find middle, split, sort, merge)
# This is a challenging problem!
def sort_list(head)
  # Your code here
end

# ============================================================================
# EXERCISE 4: Manipulation
# ============================================================================

# Remove duplicates from sorted linked list.
#
# Example: [1→1→2→3→3] → [1→2→3]
#
# Requirements:
# - Time: O(n)
# - Space: O(1)
#
# TODO: Compare adjacent nodes
def remove_duplicates_sorted(head)
  # Your code here
end

# Remove all nodes with value equal to val.
#
# Example: [1→2→6→3→6], val=6 → [1→2→3]
#
# Requirements:
# - Time: O(n)
# - Space: O(1)
#
# TODO: Use dummy node to simplify edge cases
def remove_elements(head, val)
  # Your code here
end

# Delete a node (not given head, just the node to delete).
# Assume it's not the tail.
#
# Example: [1→2→3→4], node=3 → [1→2→4]
#
# Requirements:
# - Time: O(1)
# - Space: O(1)
#
# TODO: Copy next node's value and skip next node
# Trick question - you can't actually delete it, but can make it "disappear"
def delete_node(node)
  # Your code here
end

# ============================================================================
# EXERCISE 5: Palindrome and Reversal
# ============================================================================

# Check if linked list is a palindrome.
#
# Example: [1→2→2→1] → true
# Example: [1→2→3] → false
#
# Requirements:
# - Time: O(n)
# - Space: O(1)
#
# TODO: Find middle, reverse second half, compare
def is_palindrome(head)
  # Your code here
end

# Reverse nodes from position left to right (1-indexed).
#
# Example: [1→2→3→4→5], left=2, right=4 → [1→4→3→2→5]
#
# Requirements:
# - Time: O(n)
# - Space: O(1)
#
# TODO: Find left position, reverse until right position
# This is tricky - draw it out!
def reverse_between(head, left, right)
  # Your code here
end

# Reverse nodes in groups of k.
#
# Example: [1→2→3→4→5], k=2 → [2→1→4→3→5]
# Example: [1→2→3→4→5], k=3 → [3→2→1→4→5]
#
# Requirements:
# - Time: O(n)
# - Space: O(1)
#
# TODO: Reverse k nodes at a time, connect groups
# Hard problem!
def reverse_k_group(head, k)
  # Your code here
end

# ============================================================================
# EXERCISE 6: Advanced
# ============================================================================

# Add two numbers represented by linked lists (digits in reverse).
#
# Example: [2→4→3] + [5→6→4] → [7→0→8]
# Represents: 342 + 465 = 807
#
# Requirements:
# - Time: O(max(n, m))
# - Space: O(max(n, m))
#
# TODO: Traverse both lists, handle carry
def add_two_numbers(l1, l2)
  # Your code here
end

# Reorder list: L0→L1→…→Ln-1→Ln to L0→Ln→L1→Ln-1→L2→Ln-2→…
#
# Example: [1→2→3→4] → [1→4→2→3]
# Example: [1→2→3→4→5] → [1→5→2→4→3]
#
# Requirements:
# - Time: O(n)
# - Space: O(1)
#
# TODO: Find middle, reverse second half, merge alternately
def reorder_list(head)
  # Your code here
end

# Partition list so all nodes < x come before nodes >= x.
# Preserve original relative order.
#
# Example: [1→4→3→2→5→2], x=3 → [1→2→2→4→3→5]
#
# Requirements:
# - Time: O(n)
# - Space: O(1)
#
# TODO: Use two dummy nodes for two partitions
def partition(head, x)
  # Your code here
end

# Deep copy a linked list with random pointers.
#
# Node structure:
# class NodeWithRandom
#   attr_accessor :val, :next, :random
#   def initialize(val = 0, next_node = nil, random = nil)
#     @val = val
#     @next = next_node
#     @random = random  # Points to any node or nil
#   end
# end
#
# Requirements:
# - Time: O(n)
# - Space: O(n)
#
# TODO: Use hash map to map old nodes to new nodes
# This is a medium-hard problem
def copy_random_list(head)
  # Your code here
end

# Rotate list to the right by k places.
#
# Example: [1→2→3→4→5], k=2 → [4→5→1→2→3]
#
# Requirements:
# - Time: O(n)
# - Space: O(1)
#
# TODO: Find length, make circular, break at right position
# Hint: k = k % length (handle k > length)
def rotate_right(head, k)
  # Your code here
end

# ============================================================================
# EXERCISE 7: Design Problems
# ============================================================================

# Design your own linked list.
#
# Implement:
# - get(index): Get value at index
# - add_at_head(val): Add node at head
# - add_at_tail(val): Add node at tail
# - add_at_index(index, val): Add node at index
# - delete_at_index(index): Delete node at index
#
# Requirements:
# - All operations should be efficient
#
# TODO: Implement using Node
class MyLinkedList
  def initialize
    # Your code here
  end

  # Get the value of the index-th node. Return -1 if invalid.
  def get(index)
    # Your code here
  end

  # Add a node of value val before the first element.
  def add_at_head(val)
    # Your code here
  end

  # Append a node of value val to the last element.
  def add_at_tail(val)
    # Your code here
  end

  # Add a node before the index-th node.
  def add_at_index(index, val)
    # Your code here
  end

  # Delete the index-th node.
  def delete_at_index(index)
    # Your code here
  end
end

# ============================================================================
# TESTING YOUR SOLUTIONS
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts 'Test your solutions!'
  puts 'Run: ruby exercises.rb'
  puts "Compare with solutions.rb when done.\n"

  # Example test - Reverse List
  puts '=== Test Reverse List ==='
  head = create_linked_list([1, 2, 3, 4, 5])
  print 'Original: '
  print_list(head)
  # reversed_head = reverse_list(head)
  # print 'Reversed: '
  # print_list(reversed_head)

  # Example test - Find Middle
  puts "\n=== Test Find Middle ==="
  head = create_linked_list([1, 2, 3, 4, 5])
  # middle = find_middle(head)
  # puts "Middle value: #{middle ? middle.val : nil}"

  # Example test - Has Cycle
  puts "\n=== Test Has Cycle ==="
  head = create_linked_list([1, 2, 3, 4])
  # Create cycle: 4 → 2
  # if head
  #   tail = head
  #   tail = tail.next while tail.next
  #   tail.next = head.next  # Create cycle
  # end
  # puts "Has cycle: #{has_cycle(head)}"
end
