# frozen_string_literal: true

# Big O Notation - Exercises
#
# For each function below:
# 1. Analyze the time complexity
# 2. Analyze the space complexity
# 3. Try to optimize if possible
#
# After attempting, check solutions.rb for answers and explanations.

# ============================================================================
# EXERCISE 1: Analyze Complexity
# ============================================================================

def exercise_1a(arr)
  # What is the time complexity of this function?
  # What is the space complexity?
  result = 0
  arr.each do |num|
    result += num
  end
  result
end

# Your answer:
# Time:
# Space:


def exercise_1b(arr)
  # What is the time complexity?
  # What is the space complexity?
  (0...arr.length).each do |i|
    (0...arr.length).each do |j|
      return true if i != j && arr[i] == arr[j]
    end
  end
  false
end

# Your answer:
# Time:
# Space:


def exercise_1c(arr)
  # What is the time complexity?
  # What is the space complexity?
  n = arr.length
  while n > 1
    n /= 2
  end
  n
end

# Your answer:
# Time:
# Space:


def exercise_1d(arr)
  # What is the time complexity?
  # Consider both the sort and the loop.
  arr.sort! # Ruby's sort is O(n log n)
  arr.each do |num|
    puts num
  end
end

# Your answer:
# Time:
# Space:


# ============================================================================
# EXERCISE 2: Optimize These Functions
# ============================================================================

def find_pair_with_sum_slow(arr, target)
  # Find if any two numbers in arr sum to target.
  #
  # Current: O(n²) time, O(1) space
  #
  # TODO: Optimize to O(n) time using a hash set
  # Hint: For each number, check if (target - number) exists
  n = arr.length
  (0...n).each do |i|
    ((i + 1)...n).each do |j|
      return true if arr[i] + arr[j] == target
    end
  end
  false
end

# Your optimized solution:
def find_pair_with_sum_fast(arr, target)
  # TODO: Implement O(n) solution
  raise NotImplementedError
end


def find_duplicates_slow(arr)
  # Return list of duplicate elements.
  #
  # Current: O(n²) time, O(n) space
  #
  # TODO: Optimize to O(n) time using a hash map
  duplicates = []
  n = arr.length
  (0...n).each do |i|
    ((i + 1)...n).each do |j|
      if arr[i] == arr[j] && !duplicates.include?(arr[i])
        duplicates << arr[i]
      end
    end
  end
  duplicates
end

# Your optimized solution:
def find_duplicates_fast(arr)
  # TODO: Implement O(n) solution
  # Hint: Use a frequency map
  raise NotImplementedError
end


# ============================================================================
# EXERCISE 3: Implement with Given Complexity
# ============================================================================

def is_sorted(arr)
  # Check if array is sorted in ascending order.
  #
  # Requirements:
  # - Time: O(n)
  # - Space: O(1)
  #
  # TODO: Implement
  raise NotImplementedError
end


def find_missing_number(arr, n)
  # Array contains numbers from 1 to n with one missing.
  # Find the missing number.
  #
  # Example: [1, 2, 4, 5, 6] with n=6 → returns 3
  #
  # Requirements:
  # - Time: O(n)
  # - Space: O(1)
  #
  # Hint: Use math - sum of 1 to n is n*(n+1)/2
  # TODO: Implement
  raise NotImplementedError
end


def reverse_string(s)
  # Reverse a string.
  #
  # Requirements:
  # - Time: O(n)
  # - Space: O(n) - creating new string is acceptable
  #
  # TODO: Implement
  raise NotImplementedError
end


def contains_duplicate(arr)
  # Return true if any element appears at least twice.
  #
  # Requirements:
  # - Time: O(n)
  # - Space: O(n)
  #
  # TODO: Implement using a set
  raise NotImplementedError
end


# ============================================================================
# EXERCISE 4: Space-Time Tradeoffs
# ============================================================================

def first_recurring_character_v1(s)
  # Find first character that repeats.
  # Example: "abccba" → "c"
  #
  # Implement with O(n²) time, O(1) space
  # TODO: Implement
  raise NotImplementedError
end


def first_recurring_character_v2(s)
  # Find first character that repeats.
  # Example: "abccba" → "c"
  #
  # Implement with O(n) time, O(n) space
  # TODO: Implement using a set
  raise NotImplementedError
end


# ============================================================================
# EXERCISE 5: Analyze Recursive Functions
# ============================================================================

def mystery_function_1(n)
  # What does this do?
  # What is the time complexity?
  # What is the space complexity (consider call stack)?
  return 0 if n <= 0
  n + mystery_function_1(n - 1)
end

# Your answer:
# Does:
# Time:
# Space:


def mystery_function_2(n)
  # What is the time complexity?
  # What is the space complexity?
  return 1 if n <= 1
  mystery_function_2(n - 1) + mystery_function_2(n - 1)
end

# Your answer:
# Time:
# Space:


def mystery_function_3(arr, target, left, right)
  # What does this do?
  # What is the time complexity?
  # What is the space complexity?
  return -1 if left > right

  mid = (left + right) / 2

  if arr[mid] == target
    mid
  elsif arr[mid] < target
    mystery_function_3(arr, target, mid + 1, right)
  else
    mystery_function_3(arr, target, left, mid - 1)
  end
end

# Your answer:
# Does:
# Time:
# Space:


# ============================================================================
# EXERCISE 6: Complex Analysis
# ============================================================================

def complex_function(arr1, arr2)
  # Analyze the time complexity.
  # Consider both inputs separately.

  # Part 1
  arr1.each do |x|
    puts x
  end

  # Part 2
  (0...arr1.length).each do |i|
    (0...arr2.length).each do |j|
      puts "#{arr1[i]} #{arr2[j]}"
    end
  end

  # Part 3
  arr2.sort!
end

# Your answer:
# Time complexity in terms of len(arr1)=a and len(arr2)=b:


def nested_loops(n)
  # What is the time complexity?
  count = 0
  (0...n).each do |i|
    (i...n).each do |_j|
      count += 1
    end
  end
  count
end

# Your answer:
# Time:


# ============================================================================
# EXERCISE 7: Implement Efficiently
# ============================================================================

def move_zeros_to_end(arr)
  # Move all zeros to the end while maintaining order of non-zero elements.
  #
  # Example: [0, 1, 0, 3, 12] → [1, 3, 12, 0, 0]
  #
  # Requirements:
  # - Time: O(n)
  # - Space: O(1) - modify in-place
  # - Maintain relative order of non-zero elements
  #
  # TODO: Implement
  # Hint: Use two pointers
  raise NotImplementedError
end


def find_intersection(arr1, arr2)
  # Find common elements between two arrays.
  #
  # Example: [1, 2, 3, 4], [3, 4, 5, 6] → [3, 4]
  #
  # Requirements:
  # - Time: O(n + m) where n and m are array lengths
  # - Space: O(min(n, m))
  #
  # TODO: Implement using a set
  raise NotImplementedError
end


def is_anagram(s1, s2)
  # Check if two strings are anagrams.
  #
  # Example: "listen", "silent" → true
  #
  # Requirements:
  # - Time: O(n)
  # - Space: O(1) - assuming fixed character set (26 letters)
  #
  # TODO: Implement
  # Hint: Use frequency counting or sorting
  raise NotImplementedError
end


# ============================================================================
# TESTING YOUR SOLUTIONS
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  # Test your implementations here
  puts "Test your solutions by running this file!"
  puts "Compare with solutions.rb when done."

  # Example test
  test_arr = [1, 2, 3, 4, 5]
  # puts is_sorted(test_arr)  # Should return true
end
