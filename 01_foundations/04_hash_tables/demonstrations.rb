# frozen_string_literal: true

# Hash Tables - Code Demonstrations
#
# This file demonstrates common hash table patterns and operations.
# Study each function and its use case.

# ============================================================================
# BASIC OPERATIONS
# ============================================================================

def demo_hash_basics
  # Demonstrate basic hash operations.
  #
  # Time: O(1) for each operation
  # Space: O(n) for storing n key-value pairs

  # Creating hashes
  empty_hash = {}
  student_grades = { "Alice" => 95, "Bob" => 87, "Charlie" => 92 }

  # Insertion and update
  student_grades["David"] = 88  # Insert new
  student_grades["Alice"] = 98  # Update existing

  # Lookup
  alice_grade = student_grades["Alice"]  # Direct access (returns nil if missing)
  bob_grade = student_grades["Bob"]  # Safe access
  eve_grade = student_grades.fetch("Eve", 0)  # With default value

  # Check existence
  has_charlie = student_grades.key?("Charlie")  # true
  has_eve = student_grades.key?("Eve")  # false

  # Deletion
  removed = student_grades.delete("David")  # Remove and return (returns nil if missing)

  # Iteration
  student_grades.each_key do |name|  # Iterate over keys
    puts "#{name}: #{student_grades[name]}"
  end

  student_grades.each do |name, grade|  # Iterate over key-value pairs
    puts "#{name}: #{grade}"
  end

  student_grades
end

def demo_set_basics
  # Demonstrate basic set operations.
  #
  # Time: O(1) for each operation
  # Space: O(n) for storing n elements

  require 'set'

  # Creating sets
  empty_set = Set.new
  numbers = Set[1, 2, 3, 4, 5]

  # Insertion
  numbers.add(6)
  numbers.add(3)  # Duplicates are ignored

  # Check existence
  has_three = numbers.include?(3)  # true
  has_ten = numbers.include?(10)  # false

  # Deletion
  numbers.delete(6)
  numbers.delete(10)  # Safe removal (no error if not found)

  # Set operations
  set1 = Set[1, 2, 3, 4]
  set2 = Set[3, 4, 5, 6]

  union = set1 | set2  # Set[1, 2, 3, 4, 5, 6]
  intersection = set1 & set2  # Set[3, 4]
  difference = set1 - set2  # Set[1, 2]
  symmetric_diff = set1 ^ set2  # Set[1, 2, 5, 6]

  numbers
end

# ============================================================================
# PATTERN 1: CHECKING FOR DUPLICATES
# ============================================================================

def contains_duplicate(arr)
  # Check if array contains any duplicates.
  #
  # Time: O(n) - Single pass through array
  # Space: O(n) - Set can store up to n elements
  #
  # Pattern: Use set to track seen elements

  seen = Set.new
  arr.each do |num|
    return true if seen.include?(num)
    seen.add(num)
  end
  false
end

def find_duplicates(arr)
  # Find all elements that appear more than once.
  #
  # Time: O(n) - Two passes
  # Space: O(n) - Hash for counts
  #
  # Pattern: Frequency counting

  freq = Hash.new(0)
  arr.each { |num| freq[num] += 1 }

  freq.select { |_num, count| count > 1 }.keys
end

def first_duplicate(arr)
  # Find the first element that appears twice.
  #
  # Time: O(n) - Single pass
  # Space: O(n) - Set for tracking
  #
  # Example: [2, 1, 3, 5, 3, 2] → returns 3 (first to appear twice)

  seen = Set.new
  arr.each do |num|
    return num if seen.include?(num)
    seen.add(num)
  end
  nil
end

# ============================================================================
# PATTERN 2: FREQUENCY COUNTING
# ============================================================================

def character_frequency(s)
  # Count frequency of each character.
  #
  # Time: O(n) - Single pass through string
  # Space: O(k) - k unique characters (at most 26 for lowercase letters)

  freq = Hash.new(0)
  s.each_char { |char| freq[char] += 1 }
  freq
end

def most_frequent_element(arr)
  # Find the most frequently occurring element.
  #
  # Time: O(n) - Count frequencies then find max
  # Space: O(n) - Frequency map

  return nil if arr.empty?

  freq = Hash.new(0)
  arr.each { |num| freq[num] += 1 }

  freq.max_by { |_num, count| count }&.first
end

def k_most_frequent(arr, k)
  # Find k most frequent elements.
  #
  # Time: O(n log n) - Due to sorting
  # Space: O(n) - Frequency map
  #
  # Better approach: Use heap for O(n log k)

  freq = Hash.new(0)
  arr.each { |num| freq[num] += 1 }

  # Sort by frequency (descending)
  sorted_items = freq.sort_by { |_num, count| -count }

  sorted_items.take(k).map(&:first)
end

# ============================================================================
# PATTERN 3: TWO SUM / COMPLEMENT PATTERN
# ============================================================================

def two_sum(arr, target)
  # Find indices of two numbers that sum to target.
  #
  # Time: O(n) - Single pass
  # Space: O(n) - Hash map for seen numbers
  #
  # Key insight: For each number, check if (target - number) exists

  seen = {}  # Maps number → index

  arr.each_with_index do |num, i|
    complement = target - num
    return [seen[complement], i] if seen.key?(complement)
    seen[num] = i
  end

  nil
end

def two_sum_all_pairs(arr, target)
  # Find all unique pairs that sum to target.
  #
  # Time: O(n) - Single pass
  # Space: O(n) - Set for seen numbers and pairs

  seen = Set.new
  pairs = Set.new

  arr.each do |num|
    complement = target - num
    if seen.include?(complement)
      # Store as sorted array to avoid duplicates
      pair = [num, complement].sort
      pairs.add(pair)
    end
    seen.add(num)
  end

  pairs.to_a
end

def three_sum_exists(arr, target)
  # Check if three numbers sum to target.
  #
  # Time: O(n²) - n iterations × O(n) two sum
  # Space: O(n) - Hash set for lookups
  #
  # Pattern: Fix one number, do two sum on remaining

  arr.sort!  # Optional: helps with optimization

  (0..arr.length - 3).each do |i|
    # Look for two numbers that sum to (target - arr[i])
    remaining = target - arr[i]
    seen = Set.new

    (i + 1...arr.length).each do |j|
      complement = remaining - arr[j]
      return true if seen.include?(complement)
      seen.add(arr[j])
    end
  end

  false
end

# ============================================================================
# PATTERN 4: ANAGRAMS
# ============================================================================

def anagram?(s1, s2)
  # Check if two strings are anagrams.
  #
  # Time: O(n) - Count characters in both strings
  # Space: O(1) - Fixed size (26 letters) or O(n) for general case
  #
  # Anagram: Same characters, different order
  # Example: "listen" and "silent"

  return false if s1.length != s2.length

  freq1 = Hash.new(0)
  freq2 = Hash.new(0)

  s1.each_char { |char| freq1[char] += 1 }
  s2.each_char { |char| freq2[char] += 1 }

  freq1 == freq2
end

def anagram_optimized?(s1, s2)
  # Check anagram with single frequency map.
  #
  # Time: O(n)
  # Space: O(1) for lowercase letters

  return false if s1.length != s2.length

  freq = Hash.new(0)

  # Add counts for s1
  s1.each_char { |char| freq[char] += 1 }

  # Subtract counts for s2
  s2.each_char do |char|
    return false unless freq.key?(char)
    freq[char] -= 1
    freq.delete(char) if freq[char].zero?
  end

  freq.empty?
end

def group_anagrams(words)
  # Group words that are anagrams of each other.
  #
  # Time: O(n × k log k) - n words, k average length, sorting each
  # Space: O(n × k) - Store all words
  #
  # Example: ["eat", "tea", "tan", "ate", "nat", "bat"]
  #      → [["eat", "tea", "ate"], ["tan", "nat"], ["bat"]]
  #
  # Key insight: Sorted string is same for all anagrams

  groups = Hash.new { |hash, key| hash[key] = [] }

  words.each do |word|
    # Use sorted characters as key
    key = word.chars.sort.join
    groups[key] << word
  end

  groups.values
end

# ============================================================================
# PATTERN 5: SUBARRAY PROBLEMS WITH PREFIX SUMS
# ============================================================================

def subarray_sum_equals_k(arr, k)
  # Count subarrays with sum equal to k.
  #
  # Time: O(n) - Single pass
  # Space: O(n) - Hash map for prefix sums
  #
  # Key insight: If prefix_sum[j] - prefix_sum[i] = k,
  #              then subarray from i+1 to j has sum k

  count = 0
  prefix_sum = 0
  sum_freq = Hash.new(0)
  sum_freq[0] = 1  # Initialize with 0 sum

  arr.each do |num|
    prefix_sum += num

    # Check if (prefix_sum - k) exists
    # If yes, there's a subarray ending here with sum k
    count += sum_freq[prefix_sum - k] if sum_freq.key?(prefix_sum - k)

    # Add current prefix sum to map
    sum_freq[prefix_sum] += 1
  end

  count
end

def longest_subarray_sum_k(arr, k)
  # Find length of longest subarray with sum k.
  #
  # Time: O(n) - Single pass
  # Space: O(n) - Hash map for prefix sums
  #
  # Store first occurrence of each prefix sum

  max_length = 0
  prefix_sum = 0
  sum_index = { 0 => -1 }  # Map prefix_sum → first index

  arr.each_with_index do |num, i|
    prefix_sum += num

    # Check if there's a subarray ending at i with sum k
    if sum_index.key?(prefix_sum - k)
      length = i - sum_index[prefix_sum - k]
      max_length = [max_length, length].max
    end

    # Store first occurrence only
    sum_index[prefix_sum] = i unless sum_index.key?(prefix_sum)
  end

  max_length
end

# ============================================================================
# PATTERN 6: CACHING / MEMOIZATION
# ============================================================================

def fibonacci_with_memo(n, memo = {})
  # Calculate Fibonacci with memoization.
  #
  # Time: O(n) - Each number calculated once
  # Space: O(n) - Recursion stack + memo hash
  #
  # Without memo: O(2ⁿ) - exponential time
  # With memo: O(n) - linear time

  return memo[n] if memo.key?(n)
  return n if n <= 1

  memo[n] = fibonacci_with_memo(n - 1, memo) + fibonacci_with_memo(n - 2, memo)
  memo[n]
end

# ============================================================================
# PATTERN 7: UNIQUE ELEMENTS
# ============================================================================

def intersection_of_arrays(arr1, arr2)
  # Find common elements between two arrays.
  #
  # Time: O(n + m) - Linear in both array sizes
  # Space: O(min(n, m)) - Set for smaller array

  set1 = arr1.to_set
  result = Set.new

  arr2.each do |num|
    result.add(num) if set1.include?(num)
  end

  result.to_a
end

def union_of_arrays(arr1, arr2)
  # Find all unique elements from both arrays.
  #
  # Time: O(n + m)
  # Space: O(n + m)

  (arr1.to_set | arr2.to_set).to_a
end

def remove_duplicates(arr)
  # Remove duplicates while preserving order.
  #
  # Time: O(n)
  # Space: O(n)

  seen = Set.new
  result = []

  arr.each do |num|
    unless seen.include?(num)
      result << num
      seen.add(num)
    end
  end

  result
end

# ============================================================================
# TESTING
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  require 'set'

  puts "=== Basic Operations ==="
  puts "Hash: #{demo_hash_basics}"
  puts "Set: #{demo_set_basics}"

  puts "\n=== Pattern 1: Duplicates ==="
  puts "Contains duplicate: #{contains_duplicate([1, 2, 3, 1])}"
  puts "Find duplicates: #{find_duplicates([1, 2, 2, 3, 4, 4, 5])}"
  puts "First duplicate: #{first_duplicate([2, 1, 3, 5, 3, 2])}"

  puts "\n=== Pattern 2: Frequency ==="
  puts "Char frequency: #{character_frequency('hello')}"
  puts "Most frequent: #{most_frequent_element([1, 3, 3, 2, 3, 1])}"
  puts "K most frequent: #{k_most_frequent([1, 1, 1, 2, 2, 3], 2)}"

  puts "\n=== Pattern 3: Two Sum ==="
  puts "Two sum: #{two_sum([2, 7, 11, 15], 9)}"
  puts "All pairs: #{two_sum_all_pairs([1, 2, 3, 4, 5], 7)}"

  puts "\n=== Pattern 4: Anagrams ==="
  puts "Is anagram: #{anagram?('listen', 'silent')}"
  puts "Group anagrams: #{group_anagrams(['eat', 'tea', 'tan', 'ate', 'nat', 'bat'])}"

  puts "\n=== Pattern 5: Subarray Sum ==="
  puts "Subarray sum count: #{subarray_sum_equals_k([1, 1, 1], 2)}"
  puts "Longest subarray: #{longest_subarray_sum_k([1, -1, 5, -2, 3], 3)}"

  puts "\n=== Pattern 6: Memoization ==="
  puts "Fibonacci(10): #{fibonacci_with_memo(10)}"

  puts "\n=== Pattern 7: Unique Elements ==="
  puts "Intersection: #{intersection_of_arrays([1, 2, 3], [2, 3, 4])}"
  puts "Remove duplicates: #{remove_duplicates([1, 2, 2, 3, 1, 4])}"
end
