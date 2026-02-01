# frozen_string_literal: true

# Big O Notation - Solutions
#
# Complete solutions with detailed explanations for all exercises.

# ============================================================================
# EXERCISE 1: Analyze Complexity - ANSWERS
# ============================================================================

# Exercise 1a:
# Time: O(n) - Single loop through array
# Space: O(1) - Only storing one variable (result)
#
# Exercise 1b:
# Time: O(n²) - Nested loops, both iterate over entire array
# Space: O(1) - No extra data structures
#
# Exercise 1c:
# Time: O(log n) - Dividing n by 2 each iteration
# Space: O(1) - Only one variable
#
# Exercise 1d:
# Time: O(n log n) - Sort is O(n log n), loop is O(n), total is O(n log n)
#        When adding complexities, take the larger one
# Space: O(1) or O(n) depending on sort implementation


# ============================================================================
# EXERCISE 2: Optimize These Functions - SOLUTIONS
# ============================================================================

def find_pair_with_sum_fast(arr, target)
  # Optimized to O(n) using hash set.
  #
  # Time: O(n) - Single pass through array with O(1) lookups
  # Space: O(n) - Set stores up to n elements
  #
  # Strategy: For each number, check if complement (target - num) exists
  seen = Set.new

  arr.each do |num|
    complement = target - num
    return true if seen.include?(complement)
    seen.add(num)
  end

  false
end


def find_duplicates_fast(arr)
  # Optimized to O(n) using frequency map.
  #
  # Time: O(n) - Two passes through array
  # Space: O(n) - Hash stores frequencies
  #
  # Strategy: Count frequencies, then collect elements with count > 1
  freq = Hash.new(0)
  arr.each do |num|
    freq[num] += 1
  end

  duplicates = []
  freq.each do |num, count|
    duplicates << num if count > 1
  end

  duplicates
end


# Alternative one-pass solution
def find_duplicates_fast_v2(arr)
  # One-pass solution using set to track seen and duplicates.
  #
  # Time: O(n)
  # Space: O(n)
  seen = Set.new
  duplicates = Set.new

  arr.each do |num|
    if seen.include?(num)
      duplicates.add(num)
    else
      seen.add(num)
    end
  end

  duplicates.to_a
end


# ============================================================================
# EXERCISE 3: Implement with Given Complexity - SOLUTIONS
# ============================================================================

def is_sorted(arr)
  # Check if array is sorted.
  #
  # Time: O(n) - Single pass, return early if unsorted found
  # Space: O(1) - No extra space
  #
  # Strategy: Compare each adjacent pair
  (0...arr.length - 1).each do |i|
    return false if arr[i] > arr[i + 1]
  end
  true
end


def find_missing_number(arr, n)
  # Find missing number using mathematical approach.
  #
  # Time: O(n) - Single pass to calculate sum
  # Space: O(1) - Only variables for sums
  #
  # Strategy: Expected sum - Actual sum = Missing number
  # Expected sum of 1 to n: n * (n + 1) / 2
  expected_sum = n * (n + 1) / 2
  actual_sum = arr.sum
  expected_sum - actual_sum
end


# Alternative using XOR (also O(n) time, O(1) space)
def find_missing_number_xor(arr, n)
  # Using XOR property: a ^ a = 0, a ^ 0 = a
  #
  # XOR all numbers from 1 to n and all array elements.
  # Duplicates cancel out, leaving only the missing number.
  xor_all = 0
  xor_arr = 0

  (1..n).each do |i|
    xor_all ^= i
  end

  arr.each do |num|
    xor_arr ^= num
  end

  xor_all ^ xor_arr
end


def reverse_string(s)
  # Reverse a string.
  #
  # Time: O(n) - Process each character once
  # Space: O(n) - New string of same length
  #
  # Ruby strings are mutable but we create new string with reverse
  s.reverse
end


# Alternative: Using manual approach for clearer logic
def reverse_string_v2(s)
  # More explicit two-pointer approach.
  chars = s.chars
  left = 0
  right = chars.length - 1

  while left < right
    chars[left], chars[right] = chars[right], chars[left]
    left += 1
    right -= 1
  end

  chars.join
end


def contains_duplicate(arr)
  # Check for duplicates using set.
  #
  # Time: O(n) - Single pass with O(1) set operations
  # Space: O(n) - Set stores unique elements
  #
  # Strategy: Add to set, if already exists, found duplicate
  seen = Set.new
  arr.each do |num|
    return true if seen.include?(num)
    seen.add(num)
  end
  false
end


# Alternative: One-liner
def contains_duplicate_v2(arr)
  # Compare set size to array length.
  arr.to_set.size < arr.length
end


# ============================================================================
# EXERCISE 4: Space-Time Tradeoffs - SOLUTIONS
# ============================================================================

def first_recurring_character_v1(s)
  # O(n²) time, O(1) space approach.
  #
  # For each character, check if it appears later in string.
  (0...s.length).each do |i|
    ((i + 1)...s.length).each do |j|
      return s[i] if s[i] == s[j]
    end
  end
  nil
end


def first_recurring_character_v2(s)
  # O(n) time, O(n) space approach.
  #
  # Use set to track seen characters.
  seen = Set.new
  s.each_char do |char|
    return char if seen.include?(char)
    seen.add(char)
  end
  nil
end


# ============================================================================
# EXERCISE 5: Analyze Recursive Functions - ANSWERS
# ============================================================================

# mystery_function_1:
# Does: Calculates sum of numbers from 1 to n (sum = n + (n-1) + ... + 1)
# Time: O(n) - Makes n recursive calls
# Space: O(n) - Call stack depth is n
#
# mystery_function_2:
# Time: O(2ⁿ) - Each call makes 2 recursive calls, tree has 2^n nodes
# Space: O(n) - Maximum call stack depth is n
# Note: This is extremely inefficient!
#
# mystery_function_3:
# Does: Binary search - finds target in sorted array
# Time: O(log n) - Halves search space each call
# Space: O(log n) - Recursive call stack (iterative would be O(1))


# ============================================================================
# EXERCISE 6: Complex Analysis - ANSWERS
# ============================================================================

# complex_function:
# Part 1: O(a) - Loop through arr1
# Part 2: O(a × b) - Nested loops
# Part 3: O(b log b) - Sort arr2
#
# Total: O(a + a×b + b log b) = O(a×b + b log b)
# If a and b are similar sizes: O(a×b) dominates
#
# nested_loops:
# Time: O(n²)
# Explanation: Outer loop runs n times
# Inner loop runs: n, n-1, n-2, ..., 1 times
# Total operations: n + (n-1) + (n-2) + ... + 1 = n(n+1)/2 = O(n²)


# ============================================================================
# EXERCISE 7: Implement Efficiently - SOLUTIONS
# ============================================================================

def move_zeros_to_end(arr)
  # Move zeros to end in-place.
  #
  # Time: O(n) - Single pass with two pointers
  # Space: O(1) - Only pointer variables
  #
  # Strategy: Use write pointer for next non-zero position
  write_pos = 0

  # Move all non-zeros to front
  (0...arr.length).each do |read_pos|
    if arr[read_pos] != 0
      arr[write_pos] = arr[read_pos]
      write_pos += 1
    end
  end

  # Fill remaining with zeros
  while write_pos < arr.length
    arr[write_pos] = 0
    write_pos += 1
  end

  arr
end


# Alternative: Swap approach
def move_zeros_to_end_v2(arr)
  # Swap non-zeros with zeros as we go.
  left = 0  # Position of next zero

  (0...arr.length).each do |right|
    if arr[right] != 0
      arr[left], arr[right] = arr[right], arr[left]
      left += 1
    end
  end

  arr
end


def find_intersection(arr1, arr2)
  # Find common elements.
  #
  # Time: O(n + m) - Create set from arr1, iterate arr2
  # Space: O(min(n, m)) - Set of smaller array
  #
  # Strategy: Convert smaller array to set, check larger array

  # Optimize by using smaller array for set
  arr1, arr2 = arr2, arr1 if arr1.length > arr2.length

  set1 = arr1.to_set
  intersection = []

  arr2.each do |num|
    if set1.include?(num)
      intersection << num
      set1.delete(num)  # Avoid duplicates in result
    end
  end

  intersection
end


# Alternative: Using set intersection
def find_intersection_v2(arr1, arr2)
  # Simpler using built-in set operations.
  (arr1.to_set & arr2.to_set).to_a
end


def is_anagram(s1, s2)
  # Check if anagrams.
  #
  # Time: O(n) - Where n is length of strings
  # Space: O(1) - Fixed size (26 letters) regardless of input
  #
  # Strategy: Count character frequencies
  return false if s1.length != s2.length

  # Count frequencies
  freq = Hash.new(0)
  s1.each_char do |char|
    freq[char] += 1
  end

  # Subtract frequencies
  s2.each_char do |char|
    return false unless freq.key?(char)
    freq[char] -= 1
    return false if freq[char] < 0
  end

  true
end


# Alternative: Using sorting (O(n log n))
def is_anagram_v2(s1, s2)
  # Sort both strings and compare.
  s1.chars.sort == s2.chars.sort
end


# Alternative: Using tally (cleanest, Ruby 2.7+)
def is_anagram_v3(s1, s2)
  # Using Ruby's tally method.
  s1.chars.tally == s2.chars.tally
end


# ============================================================================
# TESTING
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  require 'set'

  puts "=== Testing Exercise Solutions ===\n"

  # Exercise 2
  puts "Find pair with sum:"
  puts find_pair_with_sum_fast([1, 2, 3, 9], 8)  # false
  puts find_pair_with_sum_fast([1, 2, 4, 4], 8)  # true

  puts "\nFind duplicates:"
  p find_duplicates_fast([1, 2, 3, 1, 2, 4])  # [1, 2]

  # Exercise 3
  puts "\nIs sorted:"
  puts is_sorted([1, 2, 3, 4, 5])  # true
  puts is_sorted([1, 3, 2, 4])     # false

  puts "\nFind missing number:"
  puts find_missing_number([1, 2, 4, 5, 6], 6)  # 3

  puts "\nReverse string:"
  puts reverse_string("hello")  # "olleh"

  puts "\nContains duplicate:"
  puts contains_duplicate([1, 2, 3, 1])  # true
  puts contains_duplicate([1, 2, 3, 4])  # false

  # Exercise 4
  puts "\nFirst recurring character:"
  puts first_recurring_character_v2("abccba")  # "c"

  # Exercise 7
  puts "\nMove zeros to end:"
  arr = [0, 1, 0, 3, 12]
  p move_zeros_to_end(arr)  # [1, 3, 12, 0, 0]

  puts "\nFind intersection:"
  p find_intersection([1, 2, 3, 4], [3, 4, 5, 6])  # [3, 4]

  puts "\nIs anagram:"
  puts is_anagram("listen", "silent")  # true
  puts is_anagram("hello", "world")    # false
end
