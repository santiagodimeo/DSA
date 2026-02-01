"""
Hash Tables - Exercises

For each function below, implement the solution using hash tables (dict/set).
Focus on achieving the optimal time complexity.

After attempting, check solutions.py for answers and explanations.
"""

# ============================================================================
# EXERCISE 1: Basic Hash Table Operations
# ============================================================================


def contains_duplicate(arr):
    """
    Check if array contains any duplicate values.

    Example: [1, 2, 3, 1] → True
    Example: [1, 2, 3, 4] → False

    Requirements:
    - Time: O(n)
    - Space: O(n)

    TODO: Implement using a set
    """
    seen = set()
    for n in arr:
        if n in seen:
            return True
        seen.add(n)
    return False


def first_unique_character(s):
    """
    Find the first non-repeating character in a string.
    Return its index, or -1 if it doesn't exist.

    Example: "leetcode" → 0 (first 'l' appears once)
    Example: "loveleetcode" → 2 (first 'v' appears once)
    Example: "aabb" → -1

    Requirements:
    - Time: O(n)
    - Space: O(1) - at most 26 letters

    TODO: Implement using frequency map
    Hint: Two passes - count frequencies, then find first with count 1
    """
    freq = {}
    for char in s:
        freq[char] = freq.get(char, 0) + 1

    for i, char in enumerate(s):
        if freq[char] == 1:
            return i

    return -1


def majority_element(arr):
    """
    Find the element that appears more than n/2 times.
    You may assume such an element always exists.

    Example: [3, 2, 3] → 3
    Example: [2, 2, 1, 1, 1, 2, 2] → 2

    Requirements:
    - Time: O(n)
    - Space: O(n)

    TODO: Implement using frequency counting
    """
    pass


# ============================================================================
# EXERCISE 2: Two Sum Variations
# ============================================================================


def two_sum(arr, target):
    """
    Find indices of two numbers that add up to target.
    You may assume exactly one solution exists.

    Example: [2, 7, 11, 15], target=9 → [0, 1]

    Requirements:
    - Time: O(n)
    - Space: O(n)

    TODO: Implement using hash map to store (value → index)
    Hint: For each number, check if (target - number) exists in map
    """
    pass


def two_sum_count_pairs(arr, target):
    """
    Count how many pairs of numbers sum to target.

    Example: [1, 5, 7, -1, 5], target=6 → 3
    Pairs: (1, 5), (1, 5), (7, -1)

    Requirements:
    - Time: O(n)
    - Space: O(n)

    TODO: Implement using hash map
    Hint: Count frequency of each number, then check complements
    """
    pass


def three_sum_count(arr, target):
    """
    Count how many triplets sum to target.

    Example: [1, 2, 3, 4], target=6 → 1
    Triplet: (1, 2, 3)

    Requirements:
    - Time: O(n²)
    - Space: O(n)

    TODO: Fix one element, then do two sum on rest
    """
    count = 0

    for i in range(len(arr)):
        first = arr[i]
        remaining = target - first

        seen = set()
        for j in range(i + 1, len(arr)):
            complement = remaining - arr[j]
            if complement in seen:
                count += 1
            seen.add(arr[j])

        return count


# ============================================================================
# EXERCISE 3: Anagrams
# ============================================================================


def is_anagram(s1, s2):
    """
    Check if two strings are anagrams.
    """
    if len(s1) != len(s2):
        return False

    freq = {}

    # Count frequencies in s1
    for char in s1:
        freq[char] = freq.get(char, 0) + 1  # ← Count, not just add

    # Subtract frequencies from s2
    for char in s2:
        if char not in freq:  # ← Character doesn't exist in s1
            return False
        freq[char] -= 1  # ← Decrement count
        if freq[char] == 0:  # ← Remove when count reaches 0
            del freq[char]  # ← Use 'del', not 'delete'

    # If freq is empty, all characters matched
    if len(freq) == 0:
        return True
    return False


def group_anagrams(words):
    """
    Group strings that are anagrams of each other.

    Example: ["eat", "tea", "tan", "ate", "nat", "bat"]
         → [["eat", "tea", "ate"], ["tan", "nat"], ["bat"]]

    Requirements:
    - Time: O(n × k log k) where n=number of words, k=average length
    - Space: O(n × k)

    TODO: Implement using dict with sorted string as key
    Hint: All anagrams have the same sorted characters
    """
    pass


def find_anagrams_in_string(s, p):
    """
    Find all start indices of anagrams of p in s.

    Example: s="cbaebabacd", p="abc" → [0, 6]
    Explanation: "cba" at index 0, "bac" at index 6

    Requirements:
    - Time: O(n) where n is length of s
    - Space: O(1) - fixed alphabet size

    TODO: Use sliding window with frequency map
    Hint: Compare character frequencies in window vs p
    """
    pass


# ============================================================================
# EXERCISE 4: Subarray Problems
# ============================================================================


def subarray_sum_equals_k(arr, k):
    """
    Count number of continuous subarrays whose sum equals k.

    Example: [1, 1, 1], k=2 → 2
    Subarrays: [1, 1] at indices 0-1 and 1-2

    Requirements:
    - Time: O(n)
    - Space: O(n)

    TODO: Use prefix sum with hash map
    Hint: If prefix_sum[j] - prefix_sum[i] = k,
          then subarray from i+1 to j has sum k
    """
    pass


def longest_consecutive_sequence(arr):
    """
    Find length of longest consecutive elements sequence.

    Example: [100, 4, 200, 1, 3, 2] → 4
    Sequence: [1, 2, 3, 4]

    Requirements:
    - Time: O(n)
    - Space: O(n)

    TODO: Use set for O(1) lookups
    Hint: For each number, check if it's start of sequence (num-1 not in set)
          Then count consecutive numbers
    """
    pass


def subarray_with_zero_sum(arr):
    """
    Check if there exists a subarray with sum 0.

    Example: [4, 2, -3, 1, 6] → True
    Subarray: [2, -3, 1] sums to 0

    Requirements:
    - Time: O(n)
    - Space: O(n)

    TODO: Use prefix sums
    Hint: If same prefix sum appears twice, subarray between them sums to 0
    """
    pass


# ============================================================================
# EXERCISE 5: String Problems
# ============================================================================


def longest_substring_without_repeating(s):
    """
    Find length of longest substring without repeating characters.

    Example: "abcabcbb" → 3 (substring "abc")
    Example: "bbbbb" → 1 (substring "b")
    Example: "pwwkew" → 3 (substring "wke")

    Requirements:
    - Time: O(n)
    - Space: O(min(n, m)) where m is charset size

    TODO: Use sliding window with set/dict
    Hint: Expand window by adding chars, contract when duplicate found
    """
    pass


def character_replacement(s, k):
    """
    Find length of longest substring with same letter after k replacements.

    Example: s="AABABBA", k=1 → 4
    Replace one 'B' to get "AAAA"

    Requirements:
    - Time: O(n)
    - Space: O(1) - fixed alphabet

    TODO: Use sliding window with frequency map
    Hint: Window is valid if (window_size - max_frequency) <= k
    """
    pass


def minimum_window_substring(s, t):
    """
    Find minimum window in s that contains all characters from t.

    Example: s="ADOBECODEBANC", t="ABC" → "BANC"

    Requirements:
    - Time: O(n + m) where n=len(s), m=len(t)
    - Space: O(m)

    TODO: Use two pointers with frequency maps
    This is a hard problem - try your best!
    """
    pass


# ============================================================================
# EXERCISE 6: Array Operations
# ============================================================================


def intersection_of_two_arrays(arr1, arr2):
    """
    Find intersection of two arrays (unique elements).

    Example: [1, 2, 2, 1], [2, 2] → [2]
    Example: [4, 9, 5], [9, 4, 9, 8, 4] → [9, 4]

    Requirements:
    - Time: O(n + m)
    - Space: O(min(n, m))

    TODO: Convert one to set, check elements from other
    """
    pass


def single_number(arr):
    """
    Find the element that appears once while others appear twice.

    Example: [2, 2, 1] → 1
    Example: [4, 1, 2, 1, 2] → 4

    Requirements:
    - Time: O(n)
    - Space: O(1)

    TODO: This can be solved WITHOUT hash table using XOR
    Hint: a ^ a = 0, a ^ 0 = a
    But you can also use a set for O(n) space solution
    """
    pass


def happy_number(n):
    """
    Check if a number is happy.
    A happy number is defined by:
    - Replace number with sum of squares of its digits
    - Repeat until number equals 1, or loops endlessly
    - Return True if reaches 1

    Example: 19 → 1² + 9² = 82 → 8² + 2² = 68 → ... → 1 (True)
    Example: 2 → 4 → 16 → 37 → 58 → 89 → 145 → 42 → 20 → 4 (False, loops)

    Requirements:
    - Time: O(log n) - number of digits decreases
    - Space: O(log n) - store seen numbers

    TODO: Use set to detect cycles
    """
    pass


# ============================================================================
# EXERCISE 7: Advanced Problems
# ============================================================================


def top_k_frequent_elements(arr, k):
    """
    Find k most frequent elements.

    Example: [1, 1, 1, 2, 2, 3], k=2 → [1, 2]

    Requirements:
    - Time: O(n log k) using heap, or O(n) using bucket sort
    - Space: O(n)

    TODO: Count frequencies, then find top k
    Hint: Can use sorted() or heap, but bucket sort is optimal
    """
    pass


def valid_sudoku(board):
    """
    Check if a 9x9 Sudoku board is valid.
    Only check filled cells (not '.').

    Rules:
    - Each row must have unique digits 1-9
    - Each column must have unique digits 1-9
    - Each 3x3 sub-box must have unique digits 1-9

    Requirements:
    - Time: O(1) - fixed 9x9 board
    - Space: O(1) - fixed size sets

    TODO: Use sets to track seen numbers in rows/cols/boxes
    """
    pass


def word_pattern(pattern, s):
    """
    Check if string s follows the same pattern.

    Example: pattern="abba", s="dog cat cat dog" → True
    Example: pattern="abba", s="dog cat cat fish" → False

    Requirements:
    - Time: O(n)
    - Space: O(n)

    TODO: Use two hash maps (pattern→word and word→pattern)
    Hint: Need bijection - both directions must match
    """
    pass


def isomorphic_strings(s, t):
    """
    Check if two strings are isomorphic.
    Characters can be mapped to each other (must be consistent).

    Example: "egg", "add" → True (e→a, g→d)
    Example: "foo", "bar" → False (o maps to both o and a)

    Requirements:
    - Time: O(n)
    - Space: O(1) - fixed charset

    TODO: Similar to word_pattern, use two mappings
    """
    pass


# ============================================================================
# EXERCISE 8: Design Problems
# ============================================================================


class Logger:
    """
    Design a logger that receives messages with timestamps.
    Print message only if it hasn't been printed in last 10 seconds.

    Example:
    logger = Logger()
    logger.should_print_message(1, "foo")  # True
    logger.should_print_message(2, "bar")  # True
    logger.should_print_message(3, "foo")  # False (within 10 seconds)
    logger.should_print_message(11, "foo") # True (10+ seconds passed)

    Requirements:
    - Time: O(1) per call
    - Space: O(M) where M is number of unique messages

    TODO: Implement using hash map (message → last_timestamp)
    """

    def __init__(self):
        """Initialize your data structure here."""
        pass

    def should_print_message(self, timestamp, message):
        """Returns true if the message should be printed, false otherwise."""
        pass


class TwoSum:
    """
    Design a data structure that supports:
    - add(number): Add number to data structure
    - find(value): Find if there exists any pair that sums to value

    Example:
    obj = TwoSum()
    obj.add(1)
    obj.add(3)
    obj.add(5)
    obj.find(4)  # True (1 + 3)
    obj.find(7)  # False

    Requirements:
    - add: O(1)
    - find: O(n)
    - Space: O(n)

    TODO: Use dict to store frequencies
    """

    def __init__(self):
        """Initialize your data structure here."""
        pass

    def add(self, number):
        """Add number to internal data structure."""
        pass

    def find(self, value):
        """Find if there exists any pair of numbers which sum is equal to value."""
        pass


# ============================================================================
# TESTING YOUR SOLUTIONS
# ============================================================================

if __name__ == "__main__":
    # Test your implementations here
    print("Test your solutions!")
    print("Run: python exercises.py")
    print("Compare with solutions.py when done.")

    # Example tests
    print("\nExample test - contains_duplicate:")
    # print(contains_duplicate([1, 2, 3, 1]))  # Should be True
    # print(contains_duplicate([1, 2, 3, 4]))  # Should be False

    print("\nExample test - two_sum:")
    # print(two_sum([2, 7, 11, 15], 9))  # Should be [0, 1]

    print("\nExample test - is_anagram:")
    # print(is_anagram("anagram", "nagaram"))  # Should be True
