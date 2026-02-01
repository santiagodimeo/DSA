# frozen_string_literal: true

# Hash Tables - Exercises
#
# For each function below, implement the solution using hash tables (Hash/Set).
# Focus on achieving the optimal time complexity.
#
# After attempting, check solutions.rb for answers and explanations.

require 'set'

# ============================================================================
# EXERCISE 1: Basic Hash Table Operations
# ============================================================================

def contains_duplicate(arr)
  # Check if array contains any duplicate values.
  #
  # Example: [1, 2, 3, 1] → true
  # Example: [1, 2, 3, 4] → false
  #
  # Requirements:
  # - Time: O(n)
  # - Space: O(n)
  #
  # TODO: Implement using a Set

  seen = Set.new
  arr.each do |n|
    return true if seen.include?(n)
    seen.add(n)
  end
  false
end

def first_unique_character(s)
  # Find the first non-repeating character in a string.
  # Return its index, or -1 if it doesn't exist.
  #
  # Example: "leetcode" → 0 (first 'l' appears once)
  # Example: "loveleetcode" → 2 (first 'v' appears once)
  # Example: "aabb" → -1
  #
  # Requirements:
  # - Time: O(n)
  # - Space: O(1) - at most 26 letters
  #
  # TODO: Implement using frequency map
  # Hint: Two passes - count frequencies, then find first with count 1

  freq = Hash.new(0)
  s.each_char { |char| freq[char] += 1 }

  s.each_char.with_index do |char, i|
    return i if freq[char] == 1
  end

  -1
end

def majority_element(arr)
  # Find the element that appears more than n/2 times.
  # You may assume such an element always exists.
  #
  # Example: [3, 2, 3] → 3
  # Example: [2, 2, 1, 1, 1, 2, 2] → 2
  #
  # Requirements:
  # - Time: O(n)
  # - Space: O(n)
  #
  # TODO: Implement using frequency counting

  # TODO: Your implementation here
end

# ============================================================================
# EXERCISE 2: Two Sum Variations
# ============================================================================

def two_sum(arr, target)
  # Find indices of two numbers that add up to target.
  # You may assume exactly one solution exists.
  #
  # Example: [2, 7, 11, 15], target=9 → [0, 1]
  #
  # Requirements:
  # - Time: O(n)
  # - Space: O(n)
  #
  # TODO: Implement using hash map to store (value → index)
  # Hint: For each number, check if (target - number) exists in map

  # TODO: Your implementation here
end

def two_sum_count_pairs(arr, target)
  # Count how many pairs of numbers sum to target.
  #
  # Example: [1, 5, 7, -1, 5], target=6 → 3
  # Pairs: (1, 5), (1, 5), (7, -1)
  #
  # Requirements:
  # - Time: O(n)
  # - Space: O(n)
  #
  # TODO: Implement using hash map
  # Hint: Count frequency of each number, then check complements

  # TODO: Your implementation here
end

def three_sum_count(arr, target)
  # Count how many triplets sum to target.
  #
  # Example: [1, 2, 3, 4], target=6 → 1
  # Triplet: (1, 2, 3)
  #
  # Requirements:
  # - Time: O(n²)
  # - Space: O(n)
  #
  # TODO: Fix one element, then do two sum on rest

  count = 0

  arr.each_with_index do |first, i|
    remaining = target - first

    seen = Set.new
    (i + 1...arr.length).each do |j|
      complement = remaining - arr[j]
      if seen.include?(complement)
        count += 1
      end
      seen.add(arr[j])
    end
  end

  count
end

# ============================================================================
# EXERCISE 3: Anagrams
# ============================================================================

def anagram?(s1, s2)
  # Check if two strings are anagrams.

  return false if s1.length != s2.length

  freq = Hash.new(0)

  # Count frequencies in s1
  s1.each_char { |char| freq[char] += 1 }  # ← Count, not just add

  # Subtract frequencies from s2
  s2.each_char do |char|
    return false unless freq.key?(char)  # ← Character doesn't exist in s1
    freq[char] -= 1  # ← Decrement count
    freq.delete(char) if freq[char].zero?  # ← Remove when count reaches 0
  end

  # If freq is empty, all characters matched
  freq.empty?
end

def group_anagrams(words)
  # Group strings that are anagrams of each other.
  #
  # Example: ["eat", "tea", "tan", "ate", "nat", "bat"]
  #      → [["eat", "tea", "ate"], ["tan", "nat"], ["bat"]]
  #
  # Requirements:
  # - Time: O(n × k log k) where n=number of words, k=average length
  # - Space: O(n × k)
  #
  # TODO: Implement using hash with sorted string as key
  # Hint: All anagrams have the same sorted characters

  # TODO: Your implementation here
end

def find_anagrams_in_string(s, p)
  # Find all start indices of anagrams of p in s.
  #
  # Example: s="cbaebabacd", p="abc" → [0, 6]
  # Explanation: "cba" at index 0, "bac" at index 6
  #
  # Requirements:
  # - Time: O(n) where n is length of s
  # - Space: O(1) - fixed alphabet size
  #
  # TODO: Use sliding window with frequency map
  # Hint: Compare character frequencies in window vs p

  # TODO: Your implementation here
end

# ============================================================================
# EXERCISE 4: Subarray Problems
# ============================================================================

def subarray_sum_equals_k(arr, k)
  # Count number of continuous subarrays whose sum equals k.
  #
  # Example: [1, 1, 1], k=2 → 2
  # Subarrays: [1, 1] at indices 0-1 and 1-2
  #
  # Requirements:
  # - Time: O(n)
  # - Space: O(n)
  #
  # TODO: Use prefix sum with hash map
  # Hint: If prefix_sum[j] - prefix_sum[i] = k,
  #       then subarray from i+1 to j has sum k

  # TODO: Your implementation here
end

def longest_consecutive_sequence(arr)
  # Find length of longest consecutive elements sequence.
  #
  # Example: [100, 4, 200, 1, 3, 2] → 4
  # Sequence: [1, 2, 3, 4]
  #
  # Requirements:
  # - Time: O(n)
  # - Space: O(n)
  #
  # TODO: Use set for O(1) lookups
  # Hint: For each number, check if it's start of sequence (num-1 not in set)
  #       Then count consecutive numbers

  # TODO: Your implementation here
end

def subarray_with_zero_sum?(arr)
  # Check if there exists a subarray with sum 0.
  #
  # Example: [4, 2, -3, 1, 6] → true
  # Subarray: [2, -3, 1] sums to 0
  #
  # Requirements:
  # - Time: O(n)
  # - Space: O(n)
  #
  # TODO: Use prefix sums
  # Hint: If same prefix sum appears twice, subarray between them sums to 0

  # TODO: Your implementation here
end

# ============================================================================
# EXERCISE 5: String Problems
# ============================================================================

def longest_substring_without_repeating(s)
  # Find length of longest substring without repeating characters.
  #
  # Example: "abcabcbb" → 3 (substring "abc")
  # Example: "bbbbb" → 1 (substring "b")
  # Example: "pwwkew" → 3 (substring "wke")
  #
  # Requirements:
  # - Time: O(n)
  # - Space: O(min(n, m)) where m is charset size
  #
  # TODO: Use sliding window with set/hash
  # Hint: Expand window by adding chars, contract when duplicate found

  # TODO: Your implementation here
end

def character_replacement(s, k)
  # Find length of longest substring with same letter after k replacements.
  #
  # Example: s="AABABBA", k=1 → 4
  # Replace one 'B' to get "AAAA"
  #
  # Requirements:
  # - Time: O(n)
  # - Space: O(1) - fixed alphabet
  #
  # TODO: Use sliding window with frequency map
  # Hint: Window is valid if (window_size - max_frequency) <= k

  # TODO: Your implementation here
end

def minimum_window_substring(s, t)
  # Find minimum window in s that contains all characters from t.
  #
  # Example: s="ADOBECODEBANC", t="ABC" → "BANC"
  #
  # Requirements:
  # - Time: O(n + m) where n=len(s), m=len(t)
  # - Space: O(m)
  #
  # TODO: Use two pointers with frequency maps
  # This is a hard problem - try your best!

  # TODO: Your implementation here
end

# ============================================================================
# EXERCISE 6: Array Operations
# ============================================================================

def intersection_of_two_arrays(arr1, arr2)
  # Find intersection of two arrays (unique elements).
  #
  # Example: [1, 2, 2, 1], [2, 2] → [2]
  # Example: [4, 9, 5], [9, 4, 9, 8, 4] → [9, 4]
  #
  # Requirements:
  # - Time: O(n + m)
  # - Space: O(min(n, m))
  #
  # TODO: Convert one to set, check elements from other

  # TODO: Your implementation here
end

def single_number(arr)
  # Find the element that appears once while others appear twice.
  #
  # Example: [2, 2, 1] → 1
  # Example: [4, 1, 2, 1, 2] → 4
  #
  # Requirements:
  # - Time: O(n)
  # - Space: O(1)
  #
  # TODO: This can be solved WITHOUT hash table using XOR
  # Hint: a ^ a = 0, a ^ 0 = a
  # But you can also use a set for O(n) space solution

  # TODO: Your implementation here
end

def happy_number?(n)
  # Check if a number is happy.
  # A happy number is defined by:
  # - Replace number with sum of squares of its digits
  # - Repeat until number equals 1, or loops endlessly
  # - Return true if reaches 1
  #
  # Example: 19 → 1² + 9² = 82 → 8² + 2² = 68 → ... → 1 (true)
  # Example: 2 → 4 → 16 → 37 → 58 → 89 → 145 → 42 → 20 → 4 (false, loops)
  #
  # Requirements:
  # - Time: O(log n) - number of digits decreases
  # - Space: O(log n) - store seen numbers
  #
  # TODO: Use set to detect cycles

  # TODO: Your implementation here
end

# ============================================================================
# EXERCISE 7: Advanced Problems
# ============================================================================

def top_k_frequent_elements(arr, k)
  # Find k most frequent elements.
  #
  # Example: [1, 1, 1, 2, 2, 3], k=2 → [1, 2]
  #
  # Requirements:
  # - Time: O(n log k) using heap, or O(n) using bucket sort
  # - Space: O(n)
  #
  # TODO: Count frequencies, then find top k
  # Hint: Can use sort or bucket sort, but bucket sort is optimal

  # TODO: Your implementation here
end

def valid_sudoku?(board)
  # Check if a 9x9 Sudoku board is valid.
  # Only check filled cells (not '.').
  #
  # Rules:
  # - Each row must have unique digits 1-9
  # - Each column must have unique digits 1-9
  # - Each 3x3 sub-box must have unique digits 1-9
  #
  # Requirements:
  # - Time: O(1) - fixed 9x9 board
  # - Space: O(1) - fixed size sets
  #
  # TODO: Use sets to track seen numbers in rows/cols/boxes

  # TODO: Your implementation here
end

def word_pattern?(pattern, s)
  # Check if string s follows the same pattern.
  #
  # Example: pattern="abba", s="dog cat cat dog" → true
  # Example: pattern="abba", s="dog cat cat fish" → false
  #
  # Requirements:
  # - Time: O(n)
  # - Space: O(n)
  #
  # TODO: Use two hash maps (pattern→word and word→pattern)
  # Hint: Need bijection - both directions must match

  # TODO: Your implementation here
end

def isomorphic_strings?(s, t)
  # Check if two strings are isomorphic.
  # Characters can be mapped to each other (must be consistent).
  #
  # Example: "egg", "add" → true (e→a, g→d)
  # Example: "foo", "bar" → false (o maps to both o and a)
  #
  # Requirements:
  # - Time: O(n)
  # - Space: O(1) - fixed charset
  #
  # TODO: Similar to word_pattern, use two mappings

  # TODO: Your implementation here
end

# ============================================================================
# EXERCISE 8: Design Problems
# ============================================================================

class Logger
  # Design a logger that receives messages with timestamps.
  # Print message only if it hasn't been printed in last 10 seconds.
  #
  # Example:
  # logger = Logger.new
  # logger.should_print_message?(1, "foo")  # true
  # logger.should_print_message?(2, "bar")  # true
  # logger.should_print_message?(3, "foo")  # false (within 10 seconds)
  # logger.should_print_message?(11, "foo") # true (10+ seconds passed)
  #
  # Requirements:
  # - Time: O(1) per call
  # - Space: O(M) where M is number of unique messages
  #
  # TODO: Implement using hash map (message → last_timestamp)

  def initialize
    # Initialize your data structure here
    # TODO: Your implementation here
  end

  def should_print_message?(timestamp, message)
    # Returns true if the message should be printed, false otherwise
    # TODO: Your implementation here
  end
end

class TwoSum
  # Design a data structure that supports:
  # - add(number): Add number to data structure
  # - find(value): Find if there exists any pair that sums to value
  #
  # Example:
  # obj = TwoSum.new
  # obj.add(1)
  # obj.add(3)
  # obj.add(5)
  # obj.find(4)  # true (1 + 3)
  # obj.find(7)  # false
  #
  # Requirements:
  # - add: O(1)
  # - find: O(n)
  # - Space: O(n)
  #
  # TODO: Use hash to store frequencies

  def initialize
    # Initialize your data structure here
    # TODO: Your implementation here
  end

  def add(number)
    # Add number to internal data structure
    # TODO: Your implementation here
  end

  def find(value)
    # Find if there exists any pair of numbers which sum is equal to value
    # TODO: Your implementation here
  end
end

# ============================================================================
# TESTING YOUR SOLUTIONS
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  # Test your implementations here
  puts "Test your solutions!"
  puts "Run: ruby exercises.rb"
  puts "Compare with solutions.rb when done."

  # Example tests
  puts "\nExample test - contains_duplicate:"
  # puts contains_duplicate([1, 2, 3, 1])  # Should be true
  # puts contains_duplicate([1, 2, 3, 4])  # Should be false

  puts "\nExample test - two_sum:"
  # puts two_sum([2, 7, 11, 15], 9).inspect  # Should be [0, 1]

  puts "\nExample test - anagram?:"
  # puts anagram?("anagram", "nagaram")  # Should be true
end
