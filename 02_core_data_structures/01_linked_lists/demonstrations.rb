# frozen_string_literal: true

# Linked Lists - Code Demonstrations
#
# This file demonstrates common linked list patterns and operations.
# Study each function and its use case.

# ============================================================================
# NODE DEFINITION
# ============================================================================

# Basic building block of a linked list.
class Node
  attr_accessor :val, :next

  def initialize(val = 0, next_node = nil)
    @val = val
    @next = next_node
  end

  def to_s
    "Node(#{@val})"
  end
end

# ============================================================================
# HELPER FUNCTIONS
# ============================================================================

# Create linked list from array.
#
# Time: O(n)
# Space: O(n) - creates n nodes
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

# Print linked list in readable format.
#
# Time: O(n)
# Space: O(1)
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
#
# Time: O(n)
# Space: O(n)
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
# BASIC OPERATIONS
# ============================================================================

# Get length of linked list.
#
# Time: O(n)
# Space: O(1)
def get_length(head)
  count = 0
  current = head
  while current
    count += 1
    current = current.next
  end
  count
end

# Get value at specific index (0-based).
#
# Time: O(n) - worst case traverse entire list
# Space: O(1)
#
# Example: [1→2→3], index=1 → 2
def get_value_at_index(head, index)
  current = head
  pos = 0

  while current
    return current.val if pos == index

    current = current.next
    pos += 1
  end

  nil # Index out of bounds
end

# Insert node at beginning.
#
# Time: O(1) - constant time
# Space: O(1)
#
# Example: [2→3], insert 1 → [1→2→3]
def insert_at_beginning(head, val)
  new_node = Node.new(val)
  new_node.next = head
  new_node
end

# Insert node at end.
#
# Time: O(n) - must traverse to end
# Space: O(1)
#
# Example: [1→2], insert 3 → [1→2→3]
def insert_at_end(head, val)
  new_node = Node.new(val)

  return new_node unless head

  current = head
  current = current.next while current.next

  current.next = new_node
  head
end

# Insert node at specific position (0-based).
#
# Time: O(n)
# Space: O(1)
#
# Example: [1→3], insert 2 at pos 1 → [1→2→3]
def insert_at_position(head, val, pos)
  return insert_at_beginning(head, val) if pos.zero?

  new_node = Node.new(val)
  current = head

  (pos - 1).times do
    return head unless current # Position out of bounds

    current = current.next
  end

  if current
    new_node.next = current.next
    current.next = new_node
  end

  head
end

# Delete first node.
#
# Time: O(1)
# Space: O(1)
#
# Example: [1→2→3] → [2→3]
def delete_at_beginning(head)
  return nil unless head

  head.next
end

# Delete last node.
#
# Time: O(n) - must traverse to second-last
# Space: O(1)
#
# Example: [1→2→3] → [1→2]
def delete_at_end(head)
  return nil if !head || !head.next

  current = head
  current = current.next while current.next.next

  current.next = nil
  head
end

# Delete first occurrence of value.
#
# Time: O(n)
# Space: O(1)
#
# Example: [1→2→3→2], delete 2 → [1→3→2]
def delete_value(head, val)
  dummy = Node.new(0)
  dummy.next = head

  current = dummy
  while current.next
    if current.next.val == val
      current.next = current.next.next
      break
    end
    current = current.next
  end

  dummy.next
end

# ============================================================================
# PATTERN 1: TWO POINTERS (FAST & SLOW)
# ============================================================================

# Find middle node of linked list.
#
# Time: O(n)
# Space: O(1)
#
# Approach: Slow moves 1 step, fast moves 2 steps.
# When fast reaches end, slow is at middle.
#
# Example: [1→2→3→4→5] → 3
# Example: [1→2→3→4] → 3 (second middle for even length)
def find_middle(head)
  return nil unless head

  slow = fast = head

  while fast&.next
    slow = slow.next
    fast = fast.next.next
  end

  slow
end

# Detect if linked list has a cycle (Floyd's algorithm).
#
# Time: O(n)
# Space: O(1)
#
# Approach: If fast and slow meet, there's a cycle.
#
# Example: [1→2→3→4→2] (4 points back to 2) → true
def has_cycle(head)
  return false if !head || !head.next

  slow = fast = head

  while fast&.next
    slow = slow.next
    fast = fast.next.next

    return true if slow == fast
  end

  false
end

# Find where cycle begins (if exists).
#
# Time: O(n)
# Space: O(1)
#
# Approach:
# 1. Find meeting point with fast/slow
# 2. Move slow to head, keep fast at meeting point
# 3. Move both 1 step at a time - they meet at cycle start
def find_cycle_start(head)
  return nil if !head || !head.next

  # Find meeting point
  slow = fast = head
  while fast&.next
    slow = slow.next
    fast = fast.next.next
    break if slow == fast
  end

  # No cycle
  return nil if !fast || !fast.next

  # Find cycle start
  slow = head
  while slow != fast
    slow = slow.next
    fast = fast.next
  end

  slow
end

# Get nth node from end.
#
# Time: O(n)
# Space: O(1)
#
# Approach: Use two pointers n steps apart.
# When first reaches end, second is at nth from end.
#
# Example: [1→2→3→4→5], n=2 → 4
def get_nth_from_end(head, n)
  first = second = head

  # Move first n steps ahead
  n.times do
    return nil unless first

    first = first.next
  end

  # Move both until first reaches end
  while first
    first = first.next
    second = second.next
  end

  second
end

# ============================================================================
# PATTERN 2: REVERSAL
# ============================================================================

# Reverse entire linked list.
#
# Time: O(n)
# Space: O(1)
#
# Approach: Reverse pointers one by one.
#
# Example: [1→2→3→4] → [4→3→2→1]
def reverse_list(head)
  prev = nil
  current = head

  while current
    next_temp = current.next # Save next
    current.next = prev # Reverse pointer
    prev = current # Move prev forward
    current = next_temp # Move current forward
  end

  prev
end

# Reverse nodes from position left to right.
#
# Time: O(n)
# Space: O(1)
#
# Example: [1→2→3→4→5], left=2, right=4 → [1→4→3→2→5]
def reverse_between(head, left, right)
  return head if !head || left == right

  dummy = Node.new(0)
  dummy.next = head

  # Move to node before left
  prev = dummy
  (left - 1).times do
    prev = prev.next
  end

  # Reverse from left to right
  current = prev.next
  (right - left).times do
    next_temp = current.next
    current.next = next_temp.next
    next_temp.next = prev.next
    prev.next = next_temp
  end

  dummy.next
end

# Check if linked list is a palindrome.
#
# Time: O(n)
# Space: O(1)
#
# Approach:
# 1. Find middle with fast/slow
# 2. Reverse second half
# 3. Compare first and second halves
#
# Example: [1→2→2→1] → true
# Example: [1→2→3] → false
def is_palindrome(head)
  return true if !head || !head.next

  # Find middle
  slow = fast = head
  while fast.next&.next
    slow = slow.next
    fast = fast.next.next
  end

  # Reverse second half
  second_half = reverse_list(slow.next)

  # Compare
  first_half = head
  while second_half
    return false if first_half.val != second_half.val

    first_half = first_half.next
    second_half = second_half.next
  end

  true
end

# ============================================================================
# PATTERN 3: DUMMY NODE
# ============================================================================

# Remove all nodes with specific value.
#
# Time: O(n)
# Space: O(1)
#
# Approach: Use dummy node to handle edge case of removing head.
#
# Example: [1→2→6→3→6], val=6 → [1→2→3]
def remove_elements(head, val)
  dummy = Node.new(0)
  dummy.next = head

  current = dummy
  while current.next
    if current.next.val == val
      current.next = current.next.next
    else
      current = current.next
    end
  end

  dummy.next
end

# Merge two sorted linked lists.
#
# Time: O(n + m)
# Space: O(1)
#
# Example: [1→3→5] + [2→4→6] → [1→2→3→4→5→6]
def merge_two_sorted_lists(l1, l2)
  dummy = Node.new(0)
  current = dummy

  while l1 && l2
    if l1.val <= l2.val
      current.next = l1
      l1 = l1.next
    else
      current.next = l2
      l2 = l2.next
    end
    current = current.next
  end

  # Attach remaining nodes
  current.next = l1 || l2

  dummy.next
end

# Partition list so all nodes < x come before nodes >= x.
#
# Time: O(n)
# Space: O(1)
#
# Example: [1→4→3→2→5→2], x=3 → [1→2→2→4→3→5]
def partition(head, x)
  # Two dummy nodes for two partitions
  before_dummy = Node.new(0)
  after_dummy = Node.new(0)

  before = before_dummy
  after = after_dummy

  current = head
  while current
    if current.val < x
      before.next = current
      before = before.next
    else
      after.next = current
      after = after.next
    end
    current = current.next
  end

  after.next = nil # Important: terminate second list
  before.next = after_dummy.next # Connect two lists

  before_dummy.next
end

# ============================================================================
# ADVANCED OPERATIONS
# ============================================================================

# Remove duplicates from sorted list.
#
# Time: O(n)
# Space: O(1)
#
# Example: [1→1→2→3→3] → [1→2→3]
def remove_duplicates_sorted(head)
  current = head

  while current&.next
    if current.val == current.next.val
      current.next = current.next.next
    else
      current = current.next
    end
  end

  head
end

# Remove duplicates from unsorted list.
#
# Time: O(n)
# Space: O(n) - hash set
#
# Example: [1→3→2→1→4] → [1→3→2→4]
def remove_duplicates_unsorted(head)
  return nil unless head

  seen = Set.new([head.val])
  current = head

  while current.next
    if seen.include?(current.next.val)
      current.next = current.next.next
    else
      seen.add(current.next.val)
      current = current.next
    end
  end

  head
end

# Add two numbers represented by linked lists (digits in reverse order).
#
# Time: O(max(n, m))
# Space: O(max(n, m))
#
# Example: [2→4→3] + [5→6→4] → [7→0→8]
# Represents: 342 + 465 = 807
def add_two_numbers(l1, l2)
  dummy = Node.new(0)
  current = dummy
  carry = 0

  while l1 || l2 || carry.positive?
    val1 = l1 ? l1.val : 0
    val2 = l2 ? l2.val : 0

    total = val1 + val2 + carry
    carry = total / 10

    current.next = Node.new(total % 10)
    current = current.next

    l1 = l1.next if l1
    l2 = l2.next if l2
  end

  dummy.next
end

# ============================================================================
# TESTING
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  require 'set'

  puts '=== Basic Operations ==='
  head = create_linked_list([1, 2, 3, 4, 5])
  print 'Original: '
  print_list(head)
  puts "Length: #{get_length(head)}"
  puts "Value at index 2: #{get_value_at_index(head, 2)}"

  puts "\n=== Insertion ==="
  head = insert_at_beginning(head, 0)
  print 'After insert at beginning: '
  print_list(head)

  head = insert_at_end(head, 6)
  print 'After insert at end: '
  print_list(head)

  puts "\n=== Two Pointers ==="
  head = create_linked_list([1, 2, 3, 4, 5])
  middle = find_middle(head)
  puts "Middle node: #{middle ? middle.val : nil}"

  head = create_linked_list([1, 2, 3, 4, 5])
  nth = get_nth_from_end(head, 2)
  puts "2nd from end: #{nth ? nth.val : nil}"

  puts "\n=== Reversal ==="
  head = create_linked_list([1, 2, 3, 4, 5])
  head = reverse_list(head)
  print 'Reversed: '
  print_list(head)

  puts "\n=== Palindrome ==="
  head = create_linked_list([1, 2, 2, 1])
  puts "Is [1,2,2,1] palindrome? #{is_palindrome(head)}"

  puts "\n=== Merge Sorted Lists ==="
  l1 = create_linked_list([1, 3, 5])
  l2 = create_linked_list([2, 4, 6])
  merged = merge_two_sorted_lists(l1, l2)
  print 'Merged: '
  print_list(merged)

  puts "\n=== Remove Duplicates ==="
  head = create_linked_list([1, 1, 2, 3, 3])
  head = remove_duplicates_sorted(head)
  print 'After removing duplicates: '
  print_list(head)
end
