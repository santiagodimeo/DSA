# frozen_string_literal: true

# Binary Search Templates
#
# These templates cover the most common binary search patterns.
# Memorize these and adapt for specific problems.

# ============================================================================
# TEMPLATE 1: Basic Binary Search
# ============================================================================

def binary_search_basic(arr, target)
  # Find exact match of target in sorted array.
  #
  # Time: O(log n)
  # Space: O(1)
  #
  # Returns: Index of target, or -1 if not found
  left = 0
  right = arr.length - 1

  while left <= right
    mid = left + (right - left) / 2  # Avoid overflow

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

# ============================================================================
# TEMPLATE 2: Find First Occurrence
# ============================================================================

def find_first_occurrence(arr, target)
  # Find leftmost (first) occurrence of target.
  #
  # Use case: Find first position in sorted array with duplicates
  # Example: [1, 2, 2, 2, 3], target=2 → returns 1
  #
  # Time: O(log n)
  left = 0
  right = arr.length - 1
  result = -1

  while left <= right
    mid = left + (right - left) / 2

    if arr[mid] == target
      result = mid
      right = mid - 1  # Keep searching left
    elsif arr[mid] < target
      left = mid + 1
    else
      right = mid - 1
    end
  end

  result
end

# ============================================================================
# TEMPLATE 3: Find Last Occurrence
# ============================================================================

def find_last_occurrence(arr, target)
  # Find rightmost (last) occurrence of target.
  #
  # Example: [1, 2, 2, 2, 3], target=2 → returns 3
  #
  # Time: O(log n)
  left = 0
  right = arr.length - 1
  result = -1

  while left <= right
    mid = left + (right - left) / 2

    if arr[mid] == target
      result = mid
      left = mid + 1  # Keep searching right
    elsif arr[mid] < target
      left = mid + 1
    else
      right = mid - 1
    end
  end

  result
end

# ============================================================================
# TEMPLATE 4: Find Insert Position
# ============================================================================

def find_insert_position(arr, target)
  # Find position where target should be inserted to maintain sorted order.
  #
  # Example: [1, 3, 5, 6], target=5 → returns 2
  # Example: [1, 3, 5, 6], target=2 → returns 1
  # Example: [1, 3, 5, 6], target=7 → returns 4
  #
  # Time: O(log n)
  left = 0
  right = arr.length  # Note: right = arr.length, not arr.length - 1

  while left < right  # Note: left < right, not left <= right
    mid = left + (right - left) / 2

    if arr[mid] < target
      left = mid + 1
    else
      right = mid
    end
  end

  left
end

# ============================================================================
# TEMPLATE 5: Search in Rotated Sorted Array
# ============================================================================

def search_rotated_array(arr, target)
  # Search in rotated sorted array.
  #
  # Example: [4, 5, 6, 7, 0, 1, 2], target=0 → returns 4
  #
  # Time: O(log n)
  left = 0
  right = arr.length - 1

  while left <= right
    mid = left + (right - left) / 2

    return mid if arr[mid] == target

    # Determine which half is sorted
    if arr[left] <= arr[mid]  # Left half is sorted
      if arr[left] <= target && target < arr[mid]
        right = mid - 1  # Target in left half
      else
        left = mid + 1   # Target in right half
      end
    else  # Right half is sorted
      if arr[mid] < target && target <= arr[right]
        left = mid + 1   # Target in right half
      else
        right = mid - 1  # Target in left half
      end
    end
  end

  -1
end

# ============================================================================
# TEMPLATE 6: Find Minimum in Rotated Array
# ============================================================================

def find_min_rotated(arr)
  # Find minimum element in rotated sorted array.
  #
  # Example: [4, 5, 6, 7, 0, 1, 2] → returns 0
  #
  # Time: O(log n)
  left = 0
  right = arr.length - 1

  while left < right
    mid = left + (right - left) / 2

    if arr[mid] > arr[right]
      left = mid + 1  # Min is in right half
    else
      right = mid     # Min could be mid or in left half
    end
  end

  arr[left]
end

# ============================================================================
# TEMPLATE 7: Binary Search on Answer Space
# ============================================================================

def binary_search_answer_space(arr, k)
  # Template for searching on answer space (not array indices).
  #
  # Use when: Finding a value that satisfies a condition, where
  # values are in a range and have monotonic property.
  #
  # Example problems:
  # - Koko eating bananas
  # - Minimum days to make bouquets
  # - Capacity to ship packages
  #
  # This is a generic template - adapt condition for specific problem.

  # Returns True if mid satisfies the condition.
  # Implement based on specific problem.
  condition = lambda do |mid|
    # Example: Check if mid is valid answer
    true  # Replace with actual logic
  end

  left = arr.min
  right = arr.max  # Or other range

  while left < right
    mid = left + (right - left) / 2

    if condition.call(mid)
      right = mid  # Try to find smaller valid answer
    else
      left = mid + 1  # Need larger answer
    end
  end

  left
end

# ============================================================================
# TEMPLATE 8: Find Peak Element
# ============================================================================

def find_peak_element(arr)
  # Find a peak element (greater than neighbors).
  #
  # Example: [1, 2, 3, 1] → returns index 2 (value 3)
  #
  # Time: O(log n)
  left = 0
  right = arr.length - 1

  while left < right
    mid = left + (right - left) / 2

    if arr[mid] > arr[mid + 1]
      right = mid  # Peak is in left half (including mid)
    else
      left = mid + 1  # Peak is in right half
    end
  end

  left  # left == right at the peak
end

# ============================================================================
# TEMPLATE 9: Search in 2D Matrix
# ============================================================================

def search_2d_matrix(matrix, target)
  # Search in matrix where:
  # - Each row is sorted
  # - First element of each row > last element of previous row
  #
  # Example:
  # [[1,  3,  5,  7],
  #  [10, 11, 16, 20],
  #  [23, 30, 34, 60]]
  #
  # Treat as single sorted array.
  #
  # Time: O(log(m × n))
  return false if matrix.nil? || matrix.empty? || matrix[0].empty?

  m = matrix.length
  n = matrix[0].length
  left = 0
  right = m * n - 1

  while left <= right
    mid = left + (right - left) / 2
    # Convert to 2D coordinates
    mid_value = matrix[mid / n][mid % n]

    if mid_value == target
      return true
    elsif mid_value < target
      left = mid + 1
    else
      right = mid - 1
    end
  end

  false
end

# ============================================================================
# KEY TAKEAWAYS
# ============================================================================

# 1. Binary Search requires SORTED or MONOTONIC data
# 2. Three main variations:
#    - Basic: left <= right, return -1 if not found
#    - Find boundary: left < right, return left
#    - Find first/last: Track result, keep searching
#
# 3. Common mistakes:
#    - Integer overflow: Use left + (right - left) / 2
#    - Infinite loop: Check loop condition and updates
#    - Off-by-one: Be careful with left <= right vs left < right
#
# 4. When to use:
#    - Sorted array search
#    - Find boundary/threshold
#    - Minimize/maximize with condition
#    - Rotated sorted array
#    - 2D matrix search
#
# 5. Time complexity: Always O(log n) for binary search

# ============================================================================
# TESTING
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  # Test basic binary search
  arr = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  puts "Basic search for 5: #{binary_search_basic(arr, 5)}"  # 4
  puts "Basic search for 10: #{binary_search_basic(arr, 10)}"  # -1

  # Test with duplicates
  arr_dup = [1, 2, 2, 2, 3, 4, 5]
  puts "First occurrence of 2: #{find_first_occurrence(arr_dup, 2)}"  # 1
  puts "Last occurrence of 2: #{find_last_occurrence(arr_dup, 2)}"  # 3

  # Test insert position
  arr_insert = [1, 3, 5, 6]
  puts "Insert position for 5: #{find_insert_position(arr_insert, 5)}"  # 2
  puts "Insert position for 2: #{find_insert_position(arr_insert, 2)}"  # 1

  # Test rotated array
  arr_rotated = [4, 5, 6, 7, 0, 1, 2]
  puts "Search 0 in rotated: #{search_rotated_array(arr_rotated, 0)}"  # 4
  puts "Min in rotated array: #{find_min_rotated(arr_rotated)}"  # 0

  # Test peak element
  arr_peak = [1, 2, 3, 1]
  puts "Peak element index: #{find_peak_element(arr_peak)}"  # 2
end
