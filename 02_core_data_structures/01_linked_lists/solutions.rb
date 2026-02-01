# frozen_string_literal: true

# Linked Lists - Solutions
#
# Complete solutions with explanations for all exercises.
# Study the approach and complexity analysis for each problem.

# See demonstrations.rb for full implementations with detailed comments.
# This file contains the same solutions with concise explanations.

class Node
  attr_accessor :val, :next

  def initialize(val = 0, next_node = nil)
    @val = val
    @next = next_node
  end
end

# Helper functions
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

def print_list(head)
  values = []
  current = head
  while current
    values << current.val.to_s
    current = current.next
  end
  puts "#{values.join(' → ')} → nil"
end

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

# Time: O(n), Space: O(1)
# Approach: Use three pointers to reverse links one by one
def reverse_list(head)
  prev = nil
  current = head

  while current
    next_temp = current.next # Save next
    current.next = prev # Reverse link
    prev = current # Move prev forward
    current = next_temp # Move current forward
  end

  prev
end

# Time: O(n), Space: O(1)
# Approach: Fast/slow pointers - when fast reaches end, slow is at middle
def find_middle(head)
  slow = fast = head
  while fast&.next
    slow = slow.next
    fast = fast.next.next
  end
  slow
end

# Time: O(n), Space: O(1)
def get_length(head)
  count = 0
  current = head
  while current
    count += 1
    current = current.next
  end
  count
end

# ============================================================================
# EXERCISE 2: Two Pointers
# ============================================================================

# Time: O(n), Space: O(1)
# Approach: Floyd's algorithm - if fast meets slow, there's a cycle
def has_cycle(head)
  slow = fast = head
  while fast&.next
    slow = slow.next
    fast = fast.next.next
    return true if slow == fast
  end
  false
end

# Time: O(n), Space: O(1)
# Approach: Two pointers n steps apart
def remove_nth_from_end(head, n)
  dummy = Node.new(0)
  dummy.next = head
  first = second = dummy

  (n + 1).times do
    first = first.next
  end

  while first
    first = first.next
    second = second.next
  end

  second.next = second.next.next
  dummy.next
end

# Time: O(n + m), Space: O(1)
# Approach: Calculate lengths, align, traverse together
def find_intersection(head_a, head_b)
  return nil if !head_a || !head_b

  # Calculate lengths
  len_a = len_b = 0
  a = head_a
  b = head_b
  while a
    len_a += 1
    a = a.next
  end
  while b
    len_b += 1
    b = b.next
  end

  # Align starts
  a = head_a
  b = head_b
  while len_a > len_b
    a = a.next
    len_a -= 1
  end
  while len_b > len_a
    b = b.next
    len_b -= 1
  end

  # Find intersection
  while a != b
    a = a.next
    b = b.next
  end

  a
end

# ============================================================================
# EXERCISE 3: Merge and Sort
# ============================================================================

# Time: O(n + m), Space: O(1)
# Approach: Use dummy node, compare and link smaller values
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

  current.next = l1 || l2
  dummy.next
end

# Time: O(n log n), Space: O(log n)
# Approach: Merge sort - find middle, split, sort recursively, merge
def sort_list(head)
  return head if !head || !head.next

  # Find middle
  slow = fast = head
  prev = nil
  while fast&.next
    prev = slow
    slow = slow.next
    fast = fast.next.next
  end

  # Split
  prev.next = nil

  # Sort and merge
  left = sort_list(head)
  right = sort_list(slow)
  merge_two_sorted_lists(left, right)
end

# ============================================================================
# EXERCISE 4: Manipulation
# ============================================================================

# Time: O(n), Space: O(1)
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

# Time: O(n), Space: O(1)
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

# Time: O(1), Space: O(1)
# Trick: Copy next node's value, then skip next node
def delete_node(node)
  node.val = node.next.val
  node.next = node.next.next
end

# ============================================================================
# EXERCISE 5: Palindrome and Reversal
# ============================================================================

# Time: O(n), Space: O(1)
# Approach: Find middle, reverse second half, compare
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

# Time: O(n), Space: O(1)
# Approach: Find left position, reverse nodes until right
def reverse_between(head, left, right)
  return head if !head || left == right

  dummy = Node.new(0)
  dummy.next = head
  prev = dummy

  (left - 1).times do
    prev = prev.next
  end

  current = prev.next
  (right - left).times do
    next_temp = current.next
    current.next = next_temp.next
    next_temp.next = prev.next
    prev.next = next_temp
  end

  dummy.next
end

# Time: O(n), Space: O(1)
# Approach: Reverse k nodes at a time, connect groups
def reverse_k_group(head, k)
  # Check if there are k nodes remaining
  count = 0
  node = head
  while node && count < k
    node = node.next
    count += 1
  end

  return head if count < k

  # Reverse k nodes
  prev = nil
  current = head
  k.times do
    next_temp = current.next
    current.next = prev
    prev = current
    current = next_temp
  end

  # Recursively reverse rest and connect
  head.next = reverse_k_group(current, k)
  prev
end

# ============================================================================
# EXERCISE 6: Advanced
# ============================================================================

# Time: O(max(n,m)), Space: O(max(n,m))
# Approach: Traverse both, handle carry
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

# Time: O(n), Space: O(1)
# Approach: Find middle, reverse second half, merge alternately
def reorder_list(head)
  return if !head || !head.next

  # Find middle
  slow = fast = head
  while fast.next&.next
    slow = slow.next
    fast = fast.next.next
  end

  # Reverse second half
  second = reverse_list(slow.next)
  slow.next = nil

  # Merge alternately
  first = head
  while second
    temp1 = first.next
    temp2 = second.next

    first.next = second
    second.next = temp1

    first = temp1
    second = temp2
  end
end

# Time: O(n), Space: O(1)
# Approach: Two dummy nodes for two partitions
def partition(head, x)
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

  after.next = nil
  before.next = after_dummy.next
  before_dummy.next
end

# Time: O(n), Space: O(1)
# Approach: Make circular, find new tail, break
def rotate_right(head, k)
  return head if !head || !head.next || k.zero?

  # Find length and tail
  length = 1
  tail = head
  while tail.next
    tail = tail.next
    length += 1
  end

  # Make circular
  tail.next = head

  # Find new tail
  k %= length
  steps = length - k
  new_tail = head
  (steps - 1).times do
    new_tail = new_tail.next
  end

  new_head = new_tail.next
  new_tail.next = nil

  new_head
end

# ============================================================================
# TESTING
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts '=== Reverse List ==='
  head = create_linked_list([1, 2, 3, 4, 5])
  print 'Original: '
  print_list(head)
  head = reverse_list(head)
  print 'Reversed: '
  print_list(head)

  puts "\n=== Find Middle ==="
  head = create_linked_list([1, 2, 3, 4, 5])
  middle = find_middle(head)
  puts "Middle: #{middle.val}"

  puts "\n=== Has Cycle ==="
  head = create_linked_list([1, 2, 3, 4])
  puts "Has cycle: #{has_cycle(head)}"

  puts "\n=== Merge Sorted Lists ==="
  l1 = create_linked_list([1, 3, 5])
  l2 = create_linked_list([2, 4, 6])
  merged = merge_two_sorted_lists(l1, l2)
  print 'Merged: '
  print_list(merged)

  puts "\n=== Palindrome ==="
  head = create_linked_list([1, 2, 2, 1])
  puts "Is palindrome: #{is_palindrome(head)}"

  puts "\n=== Add Two Numbers ==="
  l1 = create_linked_list([2, 4, 3])
  l2 = create_linked_list([5, 6, 4])
  result = add_two_numbers(l1, l2)
  print '342 + 465 = '
  print_list(result)
end
