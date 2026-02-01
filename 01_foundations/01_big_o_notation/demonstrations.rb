# frozen_string_literal: true

# Big O Notation - Code Demonstrations
#
# This file demonstrates different time complexities with working examples.
# Study each function and its complexity analysis.

# ============================================================================
# O(1) - CONSTANT TIME
# ============================================================================

# Access first element of array.
#
# Time: O(1) - Single operation regardless of array size
# Space: O(1) - No extra space used
def get_first_element(arr)
  return nil if arr.empty?

  arr[0]
end

# Look up value in hash map.
#
# Time: O(1) - Hash table provides constant-time access
# Space: O(1) - No extra space
def hash_lookup(dictionary, key)
  dictionary[key]
end

# ============================================================================
# O(log n) - LOGARITHMIC TIME
# ============================================================================

# Search for target in sorted array using binary search.
#
# Time: O(log n) - Halves search space each iteration
# Space: O(1) - Only uses pointers
#
# Example: Array of 1000 elements takes ~10 comparisons
def binary_search(arr, target)
  left = 0
  right = arr.length - 1

  while left <= right
    mid = (left + right) / 2

    if arr[mid] == target
      return mid
    elsif arr[mid] < target
      left = mid + 1
    else
      right = mid - 1
    end
  end

  -1
end

# Find largest power of 2 less than or equal to n.
#
# Time: O(log n) - Divides by 2 each iteration
# Space: O(1)
def find_power_of_two(n)
  power = 1
  power *= 2 while power * 2 <= n
  power
end

# ============================================================================
# O(n) - LINEAR TIME
# ============================================================================

# Find maximum element in array.
#
# Time: O(n) - Must check every element once
# Space: O(1) - Only stores max value
def find_max(arr)
  return nil if arr.empty?

  max_val = arr[0]
  arr.each do |num|
    max_val = num if num > max_val
  end
  max_val
end

# Count how many times target appears.
#
# Time: O(n) - Single pass through array
# Space: O(1)
def count_occurrences(arr, target)
  count = 0
  arr.each do |num|
    count += 1 if num == target
  end
  count
end

# Reverse array in-place.
#
# Time: O(n) - Visit each element once
# Space: O(1) - In-place modification
def reverse_array(arr)
  left = 0
  right = arr.length - 1

  while left < right
    arr[left], arr[right] = arr[right], arr[left]
    left += 1
    right -= 1
  end

  arr
end

# ============================================================================
# O(n log n) - LINEARITHMIC TIME
# ============================================================================

# Sort array using merge sort.
#
# Time: O(n log n) - Divides array (log n) and merges (n) at each level
# Space: O(n) - Requires temporary arrays
#
# This is optimal for comparison-based sorting.
def merge_sort(arr)
  return arr if arr.length <= 1

  # Divide
  mid = arr.length / 2
  left = merge_sort(arr[0...mid])
  right = merge_sort(arr[mid..])

  # Conquer (merge)
  merge(left, right)
end

# Helper function for merge sort.
def merge(left, right)
  result = []
  i = 0
  j = 0

  while i < left.length && j < right.length
    if left[i] <= right[j]
      result << left[i]
      i += 1
    else
      result << right[j]
      j += 1
    end
  end

  result.concat(left[i..])
  result.concat(right[j..])
  result
end

# ============================================================================
# O(n²) - QUADRATIC TIME
# ============================================================================

# Sort using bubble sort.
#
# Time: O(n²) - Nested loops, each O(n)
# Space: O(1) - In-place sorting
#
# Avoid in practice - use O(n log n) algorithms instead.
def bubble_sort(arr)
  n = arr.length
  n.times do |i|
    (n - i - 1).times do |j|
      if arr[j] > arr[j + 1]
        arr[j], arr[j + 1] = arr[j + 1], arr[j]
      end
    end
  end
  arr
end

# Print all pairs of elements.
#
# Time: O(n²) - Nested loop over same array
# Space: O(1) - Only stores pair indices
def find_all_pairs(arr)
  pairs = []
  arr.length.times do |i|
    ((i + 1)...arr.length).each do |j|
      pairs << [arr[i], arr[j]]
    end
  end
  pairs
end

# Check if array has duplicates (inefficient way).
#
# Time: O(n²) - Compare each element with all others
# Space: O(1)
#
# Better approach: Use hash set for O(n) time
def has_duplicate_brute_force(arr)
  n = arr.length
  n.times do |i|
    ((i + 1)...n).each do |j|
      return true if arr[i] == arr[j]
    end
  end
  false
end

# ============================================================================
# O(2ⁿ) - EXPONENTIAL TIME
# ============================================================================

# Calculate Fibonacci number recursively (naive approach).
#
# Time: O(2ⁿ) - Each call branches into 2 more calls
# Space: O(n) - Recursion stack depth
#
# VERY SLOW for n > 30. Use dynamic programming instead.
def fibonacci_recursive(n)
  return n if n <= 1

  fibonacci_recursive(n - 1) + fibonacci_recursive(n - 2)
end

# Generate all possible subsets (power set).
#
# Time: O(2ⁿ) - Each element can be included or excluded
# Space: O(2ⁿ) - Stores all subsets
#
# For n=3: [1,2,3] → [], [1], [2], [3], [1,2], [1,3], [2,3], [1,2,3]
def generate_all_subsets(arr)
  result = []

  backtrack = lambda do |index, current|
    if index == arr.length
      result << current.dup
      return
    end

    # Exclude current element
    backtrack.call(index + 1, current)

    # Include current element
    current << arr[index]
    backtrack.call(index + 1, current)
    current.pop
  end

  backtrack.call(0, [])
  result
end

# ============================================================================
# COMPARING APPROACHES
# ============================================================================

# Check if array has duplicates (optimized with hash set).
#
# Time: O(n) - Single pass with O(1) lookups
# Space: O(n) - Hash set stores elements
#
# Trade space for time: O(n²) → O(n) by using O(n) space
def has_duplicate_optimized(arr)
  seen = Set.new
  arr.each do |num|
    return true if seen.include?(num)

    seen.add(num)
  end
  false
end

# Calculate Fibonacci with dynamic programming.
#
# Time: O(n) - Calculate each number once
# Space: O(1) - Only store last two numbers
#
# Optimization: O(2ⁿ) → O(n) using memoization
def fibonacci_optimized(n)
  return n if n <= 1

  prev = 0
  curr = 1

  (2..n).each do
    prev, curr = curr, prev + curr
  end

  curr
end

# ============================================================================
# SPACE COMPLEXITY EXAMPLES
# ============================================================================

# Sum array elements.
#
# Time: O(n)
# Space: O(1) - Only one variable for sum
def sum_array_constant_space(arr)
  total = 0
  arr.each do |num|
    total += num
  end
  total
end

# Create copy of array.
#
# Time: O(n)
# Space: O(n) - New array of same size
def create_copy_linear_space(arr)
  arr.dup
end

# Create frequency map of elements.
#
# Time: O(n)
# Space: O(n) - In worst case, all elements unique
def create_frequency_map(arr)
  freq = Hash.new(0)
  arr.each do |num|
    freq[num] += 1
  end
  freq
end

# ============================================================================
# TESTING
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  require 'set'

  # Test different complexities
  test_arr = [5, 2, 8, 1, 9, 3, 7, 4, 6]

  puts "O(1) - Get first: #{get_first_element(test_arr)}"
  puts "O(log n) - Binary search: #{binary_search(test_arr.sort, 7)}"
  puts "O(n) - Find max: #{find_max(test_arr)}"
  puts "O(n log n) - Merge sort: #{merge_sort(test_arr.dup)}"
  puts "O(n²) - All pairs count: #{find_all_pairs(test_arr).length}"
  puts "O(2ⁿ) - Subsets of [1,2,3]: #{generate_all_subsets([1, 2, 3]).length}"

  # Compare optimizations
  puts "\nDuplicate check - Brute force O(n²): #{has_duplicate_brute_force([1, 2, 3, 4, 5])}"
  puts "Duplicate check - Optimized O(n): #{has_duplicate_optimized([1, 2, 3, 4, 5])}"

  puts "\nFibonacci(10) - Recursive O(2ⁿ): #{fibonacci_recursive(10)}"
  puts "Fibonacci(10) - Optimized O(n): #{fibonacci_optimized(10)}"
end
