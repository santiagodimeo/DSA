# frozen_string_literal: true

# Hash Tables - Solutions
#
# Complete solutions with explanations for all exercises.
# Study the approach and complexity analysis for each problem.

require 'set'

# ============================================================================
# EXERCISE 1: Basic Hash Table Operations
# ============================================================================

def contains_duplicate(arr)
  # Check if array contains any duplicate values.
  #
  # Time: O(n) - Single pass through array
  # Space: O(n) - Set stores up to n elements
  #
  # Approach:
  # - Use set to track seen elements
  # - If element already in set, found duplicate
  # - Add each element to set as we go

  seen = Set.new
  arr.each do |num|
    return true if seen.include?(num)
    seen.add(num)
  end
  false
end

def first_unique_character(s)
  # Find the first non-repeating character in a string.
  #
  # Time: O(n) - Two passes through string
  # Space: O(1) - At most 26 lowercase letters
  #
  # Approach:
  # - First pass: Count frequency of each character
  # - Second pass: Find first character with count 1

  freq = Hash.new(0)
  s.each_char { |char| freq[char] += 1 }

  s.each_char.with_index do |char, i|
    return i if freq[char] == 1
  end

  -1
end

def majority_element(arr)
  # Find the element that appears more than n/2 times.
  #
  # Time: O(n) - Single pass to count
  # Space: O(n) - Frequency map
  #
  # Approach:
  # - Count frequency of each element
  # - Find element with count > n/2
  #
  # Alternative: Boyer-Moore Voting Algorithm for O(1) space

  freq = Hash.new(0)
  arr.each do |num|
    freq[num] += 1
    return num if freq[num] > arr.length / 2
  end

  nil
end

# ============================================================================
# EXERCISE 2: Two Sum Variations
# ============================================================================

def two_sum(arr, target)
  # Find indices of two numbers that add up to target.
  #
  # Time: O(n) - Single pass
  # Space: O(n) - Hash map stores up to n elements
  #
  # Approach:
  # - For each number, calculate complement = target - number
  # - Check if complement exists in hash map
  # - If yes, return indices; if no, add current number to map
  #
  # Key insight: Hash map provides O(1) lookup vs O(n) for array scan

  seen = {}  # Maps value → index

  arr.each_with_index do |num, i|
    complement = target - num
    return [seen[complement], i] if seen.key?(complement)
    seen[num] = i
  end

  nil
end

def two_sum_count_pairs(arr, target)
  # Count how many pairs of numbers sum to target.
  #
  # Time: O(n) - Single pass after counting
  # Space: O(n) - Frequency map
  #
  # Approach:
  # - Count frequency of each number
  # - For each unique number, check if complement exists
  # - Count pairs: freq[num] * freq[complement]
  # - Handle special case: num + num = target (same number twice)

  freq = Hash.new(0)
  arr.each { |num| freq[num] += 1 }

  count = 0
  seen = Set.new

  freq.each do |num, _count|
    complement = target - num

    if freq.key?(complement) && !seen.include?(num)
      if num == complement
        # Same number used twice: nC2 combinations
        count += freq[num] * (freq[num] - 1) / 2
      else
        count += freq[num] * freq[complement]
        seen.add(complement)  # Avoid counting twice
      end
      seen.add(num)
    end
  end

  count
end

def three_sum_count(arr, target)
  # Count how many triplets sum to target.
  #
  # Time: O(n²) - n iterations × O(n) two sum each
  # Space: O(n) - Set for two sum lookups
  #
  # Approach:
  # - Fix first element (i)
  # - Use two sum pattern on remaining elements
  # - Look for pairs that sum to (target - arr[i])

  count = 0

  (0..arr.length - 3).each do |i|
    # Two sum for target - arr[i]
    seen = Set.new
    remaining = target - arr[i]

    (i + 1...arr.length).each do |j|
      complement = remaining - arr[j]
      count += 1 if seen.include?(complement)
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
  #
  # Time: O(n) - Count characters in both strings
  # Space: O(1) - At most 26 letters for lowercase alphabet
  #
  # Approach:
  # - Count frequency of characters in both strings
  # - Compare frequency maps
  #
  # Alternative: Sort both strings and compare - O(n log n)

  return false if s1.length != s2.length

  freq = Hash.new(0)

  # Add counts from s1
  s1.each_char { |char| freq[char] += 1 }

  # Subtract counts from s2
  s2.each_char do |char|
    return false unless freq.key?(char)
    freq[char] -= 1
    freq.delete(char) if freq[char].zero?
  end

  freq.empty?
end

def group_anagrams(words)
  # Group strings that are anagrams of each other.
  #
  # Time: O(n × k log k) - n words, k avg length, sort each word
  # Space: O(n × k) - Store all words in groups
  #
  # Approach:
  # - Key insight: All anagrams have same sorted characters
  # - Use sorted string as key in hash map
  # - Group words by their sorted key
  #
  # Example: "eat" and "tea" both become "aet" when sorted

  groups = Hash.new { |hash, key| hash[key] = [] }

  words.each do |word|
    # Sort characters to get canonical form
    key = word.chars.sort.join
    groups[key] << word
  end

  groups.values
end

def find_anagrams_in_string(s, p)
  # Find all start indices of anagrams of p in s.
  #
  # Time: O(n) - Sliding window with O(1) comparison
  # Space: O(1) - Fixed alphabet size (26 letters)
  #
  # Approach:
  # - Use sliding window of length p.length
  # - Maintain frequency map of characters in window
  # - Compare window frequency with p's frequency
  # - Slide window and update frequencies incrementally

  return [] if p.length > s.length

  # Count frequency of characters in p
  p_freq = Hash.new(0)
  p.each_char { |char| p_freq[char] += 1 }

  # Initialize window
  window_freq = Hash.new(0)
  (0...p.length).each do |i|
    char = s[i]
    window_freq[char] += 1
  end

  result = []
  result << 0 if window_freq == p_freq

  # Slide window
  (p.length...s.length).each do |i|
    # Add new character
    new_char = s[i]
    window_freq[new_char] += 1

    # Remove old character
    old_char = s[i - p.length]
    window_freq[old_char] -= 1
    window_freq.delete(old_char) if window_freq[old_char].zero?

    # Check if anagram
    result << (i - p.length + 1) if window_freq == p_freq
  end

  result
end

# ============================================================================
# EXERCISE 4: Subarray Problems
# ============================================================================

def subarray_sum_equals_k(arr, k)
  # Count number of continuous subarrays whose sum equals k.
  #
  # Time: O(n) - Single pass
  # Space: O(n) - Store prefix sums
  #
  # Approach:
  # - Use prefix sum technique
  # - Key insight: If prefix_sum[j] - prefix_sum[i] = k,
  #                then subarray from i+1 to j has sum k
  # - Store frequency of each prefix sum in hash map
  # - For each position, check if (current_sum - k) exists
  #
  # Example: arr=[1, 1, 1], k=2
  # - At index 1: sum=2, check if sum-k=0 exists → yes (1 subarray)
  # - At index 2: sum=3, check if sum-k=1 exists → yes (1 subarray)
  # - Total: 2 subarrays

  count = 0
  prefix_sum = 0
  sum_freq = Hash.new(0)
  sum_freq[0] = 1  # Initialize with 0 for subarrays starting at index 0

  arr.each do |num|
    prefix_sum += num

    # Check how many times (prefix_sum - k) has appeared
    # Each occurrence means a subarray ending here with sum k
    count += sum_freq[prefix_sum - k] if sum_freq.key?(prefix_sum - k)

    # Add current prefix sum to map
    sum_freq[prefix_sum] += 1
  end

  count
end

def longest_consecutive_sequence(arr)
  # Find length of longest consecutive elements sequence.
  #
  # Time: O(n) - Each element checked at most twice
  # Space: O(n) - Set stores all elements
  #
  # Approach:
  # - Put all elements in set for O(1) lookup
  # - For each number, check if it's start of sequence (num-1 not in set)
  # - If start, count consecutive numbers
  # - Track maximum length
  #
  # Key insight: Only start counting from sequence start to avoid recounting

  return 0 if arr.empty?

  num_set = arr.to_set
  max_length = 0

  num_set.each do |num|
    # Only start counting if this is the beginning of a sequence
    unless num_set.include?(num - 1)
      current = num
      length = 1

      # Count consecutive numbers
      while num_set.include?(current + 1)
        current += 1
        length += 1
      end

      max_length = [max_length, length].max
    end
  end

  max_length
end

def subarray_with_zero_sum?(arr)
  # Check if there exists a subarray with sum 0.
  #
  # Time: O(n) - Single pass
  # Space: O(n) - Store prefix sums
  #
  # Approach:
  # - Use prefix sums
  # - Key insight: If same prefix sum appears twice,
  #                the subarray between those positions has sum 0
  # - Also check if prefix sum itself is 0 (subarray from start)

  prefix_sum = 0
  seen = Set[0]  # Include 0 for subarrays starting at index 0

  arr.each do |num|
    prefix_sum += num
    return true if seen.include?(prefix_sum)
    seen.add(prefix_sum)
  end

  false
end

# ============================================================================
# EXERCISE 5: String Problems
# ============================================================================

def longest_substring_without_repeating(s)
  # Find length of longest substring without repeating characters.
  #
  # Time: O(n) - Each character visited at most twice
  # Space: O(min(n, m)) - m is charset size
  #
  # Approach:
  # - Use sliding window with hash map
  # - Map character → last seen index
  # - When duplicate found, move left pointer past previous occurrence
  # - Track maximum window size

  char_index = {}
  max_length = 0
  left = 0

  s.each_char.with_index do |char, right|
    # If character seen and within current window
    if char_index.key?(char) && char_index[char] >= left
      left = char_index[char] + 1
    end

    char_index[char] = right
    max_length = [max_length, right - left + 1].max
  end

  max_length
end

def character_replacement(s, k)
  # Find length of longest substring with same letter after k replacements.
  #
  # Time: O(n) - Sliding window
  # Space: O(1) - Fixed alphabet (26 letters)
  #
  # Approach:
  # - Use sliding window with frequency map
  # - Window is valid if: (window_size - max_frequency) <= k
  # - This means we can replace the minority characters
  # - Expand window when valid, contract when invalid

  freq = Hash.new(0)
  max_length = 0
  max_freq = 0
  left = 0

  s.each_char.with_index do |char, right|
    freq[char] += 1
    max_freq = [max_freq, freq[char]].max

    # Window size - most frequent char count = replacements needed
    window_size = right - left + 1
    if window_size - max_freq > k
      # Shrink window
      freq[s[left]] -= 1
      left += 1
    end

    max_length = [max_length, right - left + 1].max
  end

  max_length
end

def minimum_window_substring(s, t)
  # Find minimum window in s that contains all characters from t.
  #
  # Time: O(n + m) - n=s.length, m=t.length
  # Space: O(m) - Store character frequencies from t
  #
  # Approach:
  # - Use two pointers (sliding window)
  # - Expand right to include characters
  # - Contract left while window is valid
  # - Track minimum window that contains all characters from t

  return '' if s.empty? || t.empty?

  # Count characters needed from t
  need = Hash.new(0)
  t.each_char { |char| need[char] += 1 }

  have = Hash.new(0)
  required = need.length
  formed = 0

  left = 0
  min_len = Float::INFINITY
  min_left = 0

  s.each_char.with_index do |char, right|
    # Add character to window
    have[char] += 1

    # Check if this character's frequency matches requirement
    formed += 1 if need.key?(char) && have[char] == need[char]

    # Contract window while valid
    while left <= right && formed == required
      # Update result if this is smaller window
      if right - left + 1 < min_len
        min_len = right - left + 1
        min_left = left
      end

      # Remove leftmost character
      char = s[left]
      have[char] -= 1
      formed -= 1 if need.key?(char) && have[char] < need[char]

      left += 1
    end
  end

  min_len == Float::INFINITY ? '' : s[min_left, min_len]
end

# ============================================================================
# EXERCISE 6: Array Operations
# ============================================================================

def intersection_of_two_arrays(arr1, arr2)
  # Find intersection of two arrays (unique elements).
  #
  # Time: O(n + m) - Convert to set + iterate
  # Space: O(min(n, m)) - Store smaller array in set
  #
  # Approach:
  # - Convert one array to set
  # - Iterate other array and check membership
  # - Use set for result to ensure uniqueness

  set1 = arr1.to_set
  result = Set.new

  arr2.each do |num|
    result.add(num) if set1.include?(num)
  end

  result.to_a
end

def single_number(arr)
  # Find the element that appears once while others appear twice.
  #
  # Time: O(n)
  # Space: O(1) - Using XOR
  #
  # Approach using XOR:
  # - XOR properties: a ^ a = 0, a ^ 0 = a
  # - XOR all numbers together
  # - Pairs cancel out, single number remains
  #
  # Alternative with set: O(n) space

  result = 0
  arr.each { |num| result ^= num }
  result
end

def happy_number?(n)
  # Check if a number is happy.
  #
  # Time: O(log n) - Number of digits decreases
  # Space: O(log n) - Store seen numbers to detect cycle
  #
  # Approach:
  # - Keep calculating sum of squares of digits
  # - Use set to detect if we enter a cycle
  # - If we reach 1, it's happy
  # - If we see a repeated number, it's not happy (stuck in cycle)

  get_next = lambda do |num|
    total = 0
    while num > 0
      digit = num % 10
      total += digit * digit
      num /= 10
    end
    total
  end

  seen = Set.new
  while n != 1 && !seen.include?(n)
    seen.add(n)
    n = get_next.call(n)
  end

  n == 1
end

# ============================================================================
# EXERCISE 7: Advanced Problems
# ============================================================================

def top_k_frequent_elements(arr, k)
  # Find k most frequent elements.
  #
  # Time: O(n) - Using bucket sort
  # Space: O(n) - Frequency map + buckets
  #
  # Approach (Bucket Sort - Optimal):
  # - Count frequency of each element
  # - Create buckets: index = frequency, value = list of elements
  # - Collect k elements from highest frequency buckets
  #
  # Alternative: Use heap for O(n log k)

  # Count frequencies
  freq = Hash.new(0)
  arr.each { |num| freq[num] += 1 }

  # Bucket sort: index is frequency
  buckets = Array.new(arr.length + 1) { [] }
  freq.each do |num, count|
    buckets[count] << num
  end

  # Collect k elements from highest frequencies
  result = []
  (buckets.length - 1).downto(0) do |i|
    buckets[i].each do |num|
      result << num
      return result if result.length == k
    end
  end

  result
end

def valid_sudoku?(board)
  # Check if a 9x9 Sudoku board is valid.
  #
  # Time: O(1) - Fixed 9x9 board (81 cells)
  # Space: O(1) - Fixed size sets
  #
  # Approach:
  # - Use sets to track seen numbers in each row/column/box
  # - For each cell, check if number already seen
  # - Box index: (row / 3, col / 3)

  rows = Array.new(9) { Set.new }
  cols = Array.new(9) { Set.new }
  boxes = Array.new(9) { Set.new }

  (0...9).each do |r|
    (0...9).each do |c|
      next if board[r][c] == '.'

      num = board[r][c]
      box_index = (r / 3) * 3 + (c / 3)

      # Check if number already exists
      return false if rows[r].include?(num) || cols[c].include?(num) || boxes[box_index].include?(num)

      rows[r].add(num)
      cols[c].add(num)
      boxes[box_index].add(num)
    end
  end

  true
end

def word_pattern?(pattern, s)
  # Check if string s follows the same pattern.
  #
  # Time: O(n) - n is length of pattern/words
  # Space: O(n) - Two hash maps
  #
  # Approach:
  # - Need bijection (one-to-one mapping both ways)
  # - Use two hash maps: pattern→word and word→pattern
  # - Check both mappings are consistent

  words = s.split

  return false if pattern.length != words.length

  char_to_word = {}
  word_to_char = {}

  pattern.chars.zip(words).each do |char, word|
    if char_to_word.key?(char)
      return false if char_to_word[char] != word
    else
      char_to_word[char] = word
    end

    if word_to_char.key?(word)
      return false if word_to_char[word] != char
    else
      word_to_char[word] = char
    end
  end

  true
end

def isomorphic_strings?(s, t)
  # Check if two strings are isomorphic.
  #
  # Time: O(n)
  # Space: O(1) - Fixed charset
  #
  # Approach:
  # - Similar to word_pattern
  # - Need one-to-one mapping in both directions
  # - Use two hash maps

  return false if s.length != t.length

  s_to_t = {}
  t_to_s = {}

  s.chars.zip(t.chars).each do |char_s, char_t|
    if s_to_t.key?(char_s)
      return false if s_to_t[char_s] != char_t
    else
      s_to_t[char_s] = char_t
    end

    if t_to_s.key?(char_t)
      return false if t_to_s[char_t] != char_s
    else
      t_to_s[char_t] = char_s
    end
  end

  true
end

# ============================================================================
# EXERCISE 8: Design Problems
# ============================================================================

class Logger
  # Design a logger that rate-limits messages.
  #
  # Approach:
  # - Use hash map: message → last_timestamp
  # - When message arrives, check if 10+ seconds passed
  # - Update timestamp if printing

  def initialize
    @message_times = {}
  end

  def should_print_message?(timestamp, message)
    # Time: O(1)
    # Space: O(M) where M is number of unique messages

    unless @message_times.key?(message)
      @message_times[message] = timestamp
      return true
    end

    last_time = @message_times[message]
    if timestamp - last_time >= 10
      @message_times[message] = timestamp
      return true
    end

    false
  end
end

class TwoSum
  # Design a data structure for two sum queries.
  #
  # Approach:
  # - Store frequency of each number
  # - For find, check all numbers and their complements
  # - Handle case where same number is used twice

  def initialize
    @freq = Hash.new(0)
  end

  def add(number)
    # Time: O(1)
    @freq[number] += 1
  end

  def find(value)
    # Time: O(n) where n is number of unique values
    @freq.each do |num, _count|
      complement = value - num

      if @freq.key?(complement)
        # If same number, need at least 2 occurrences
        if num == complement
          return true if @freq[num] >= 2
        else
          return true
        end
      end
    end

    false
  end
end

# ============================================================================
# TESTING
# ============================================================================

if __FILE__ == $PROGRAM_NAME
  puts "=== Exercise 1: Basic Operations ==="
  puts "Contains duplicate: #{contains_duplicate([1, 2, 3, 1])}"
  puts "First unique char: #{first_unique_character('leetcode')}"
  puts "Majority element: #{majority_element([3, 2, 3])}"

  puts "\n=== Exercise 2: Two Sum ==="
  puts "Two sum: #{two_sum([2, 7, 11, 15], 9)}"
  puts "Count pairs: #{two_sum_count_pairs([1, 5, 7, -1, 5], 6)}"
  puts "Three sum count: #{three_sum_count([1, 2, 3, 4], 6)}"

  puts "\n=== Exercise 3: Anagrams ==="
  puts "Is anagram: #{anagram?('anagram', 'nagaram')}"
  puts "Group anagrams: #{group_anagrams(['eat', 'tea', 'tan', 'ate', 'nat', 'bat'])}"
  puts "Find anagrams: #{find_anagrams_in_string('cbaebabacd', 'abc')}"

  puts "\n=== Exercise 4: Subarrays ==="
  puts "Subarray sum k: #{subarray_sum_equals_k([1, 1, 1], 2)}"
  puts "Longest consecutive: #{longest_consecutive_sequence([100, 4, 200, 1, 3, 2])}"
  puts "Zero sum exists: #{subarray_with_zero_sum?([4, 2, -3, 1, 6])}"

  puts "\n=== Exercise 5: Strings ==="
  puts "Longest substring: #{longest_substring_without_repeating('abcabcbb')}"
  puts "Character replacement: #{character_replacement('AABABBA', 1)}"
  puts "Min window: #{minimum_window_substring('ADOBECODEBANC', 'ABC')}"

  puts "\n=== Exercise 6: Arrays ==="
  puts "Intersection: #{intersection_of_two_arrays([1, 2, 2, 1], [2, 2])}"
  puts "Single number: #{single_number([2, 2, 1])}"
  puts "Happy number: #{happy_number?(19)}"

  puts "\n=== Exercise 7: Advanced ==="
  puts "Top k frequent: #{top_k_frequent_elements([1, 1, 1, 2, 2, 3], 2)}"
  puts "Word pattern: #{word_pattern?('abba', 'dog cat cat dog')}"
  puts "Isomorphic: #{isomorphic_strings?('egg', 'add')}"

  puts "\n=== Exercise 8: Design ==="
  logger = Logger.new
  puts "Logger 1: #{logger.should_print_message?(1, 'foo')}"
  puts "Logger 3: #{logger.should_print_message?(3, 'foo')}"
  puts "Logger 11: #{logger.should_print_message?(11, 'foo')}"

  two_sum = TwoSum.new
  two_sum.add(1)
  two_sum.add(3)
  two_sum.add(5)
  puts "TwoSum find 4: #{two_sum.find(4)}"
  puts "TwoSum find 7: #{two_sum.find(7)}"
end
