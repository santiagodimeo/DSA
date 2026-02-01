"""
Hash Tables - Solutions

Complete solutions with explanations for all exercises.
Study the approach and complexity analysis for each problem.
"""

# ============================================================================
# EXERCISE 1: Basic Hash Table Operations
# ============================================================================


def contains_duplicate(arr):
    """
    Check if array contains any duplicate values.

    Time: O(n) - Single pass through array
    Space: O(n) - Set stores up to n elements

    Approach:
    - Use set to track seen elements
    - If element already in set, found duplicate
    - Add each element to set as we go
    """
    seen = set()
    for num in arr:
        if num in seen:
            return True
        seen.add(num)
    return False


def first_unique_character(s):
    """
    Find the first non-repeating character in a string.

    Time: O(n) - Two passes through string
    Space: O(1) - At most 26 lowercase letters

    Approach:
    - First pass: Count frequency of each character
    - Second pass: Find first character with count 1
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

    Time: O(n) - Single pass to count
    Space: O(n) - Frequency map

    Approach:
    - Count frequency of each element
    - Find element with count > n/2

    Alternative: Boyer-Moore Voting Algorithm for O(1) space
    """
    freq = {}
    for num in arr:
        freq[num] = freq.get(num, 0) + 1
        if freq[num] > len(arr) // 2:
            return num

    return None


# ============================================================================
# EXERCISE 2: Two Sum Variations
# ============================================================================


def two_sum(arr, target):
    """
    Find indices of two numbers that add up to target.

    Time: O(n) - Single pass
    Space: O(n) - Hash map stores up to n elements

    Approach:
    - For each number, calculate complement = target - number
    - Check if complement exists in hash map
    - If yes, return indices; if no, add current number to map

    Key insight: Hash map provides O(1) lookup vs O(n) for array scan
    """
    seen = {}  # Maps value → index

    for i, num in enumerate(arr):
        complement = target - num
        if complement in seen:
            return [seen[complement], i]
        seen[num] = i

    return None


def two_sum_count_pairs(arr, target):
    """
    Count how many pairs of numbers sum to target.

    Time: O(n) - Single pass after counting
    Space: O(n) - Frequency map

    Approach:
    - Count frequency of each number
    - For each unique number, check if complement exists
    - Count pairs: freq[num] * freq[complement]
    - Handle special case: num + num = target (same number twice)
    """
    freq = {}
    for num in arr:
        freq[num] = freq.get(num, 0) + 1

    count = 0
    seen = set()

    for num in freq:
        complement = target - num

        if complement in freq and num not in seen:
            if num == complement:
                # Same number used twice: nC2 combinations
                count += freq[num] * (freq[num] - 1) // 2
            else:
                count += freq[num] * freq[complement]
                seen.add(complement)  # Avoid counting twice
            seen.add(num)

    return count


def three_sum_count(arr, target):
    """
    Count how many triplets sum to target.

    Time: O(n²) - n iterations × O(n) two sum each
    Space: O(n) - Set for two sum lookups

    Approach:
    - Fix first element (i)
    - Use two sum pattern on remaining elements
    - Look for pairs that sum to (target - arr[i])
    """
    count = 0

    for i in range(len(arr) - 2):
        # Two sum for target - arr[i]
        seen = set()
        remaining = target - arr[i]

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

    Time: O(n) - Count characters in both strings
    Space: O(1) - At most 26 letters for lowercase alphabet

    Approach:
    - Count frequency of characters in both strings
    - Compare frequency maps

    Alternative: Sort both strings and compare - O(n log n)
    """
    if len(s1) != len(s2):
        return False

    freq = {}

    # Add counts from s1
    for char in s1:
        freq[char] = freq.get(char, 0) + 1

    # Subtract counts from s2
    for char in s2:
        if char not in freq:
            return False
        freq[char] -= 1
        if freq[char] == 0:
            del freq[char]

    return len(freq) == 0


def group_anagrams(words):
    """
    Group strings that are anagrams of each other.

    Time: O(n × k log k) - n words, k avg length, sort each word
    Space: O(n × k) - Store all words in groups

    Approach:
    - Key insight: All anagrams have same sorted characters
    - Use sorted string as key in hash map
    - Group words by their sorted key

    Example: "eat" and "tea" both become "aet" when sorted
    """
    groups = {}

    for word in words:
        # Sort characters to get canonical form
        key = "".join(sorted(word))

        if key not in groups:
            groups[key] = []
        groups[key].append(word)

    return list(groups.values())


def find_anagrams_in_string(s, p):
    """
    Find all start indices of anagrams of p in s.

    Time: O(n) - Sliding window with O(1) comparison
    Space: O(1) - Fixed alphabet size (26 letters)

    Approach:
    - Use sliding window of length len(p)
    - Maintain frequency map of characters in window
    - Compare window frequency with p's frequency
    - Slide window and update frequencies incrementally
    """
    if len(p) > len(s):
        return []

    # Count frequency of characters in p
    p_freq = {}
    for char in p:
        p_freq[char] = p_freq.get(char, 0) + 1

    # Initialize window
    window_freq = {}
    for i in range(len(p)):
        char = s[i]
        window_freq[char] = window_freq.get(char, 0) + 1

    result = []
    if window_freq == p_freq:
        result.append(0)

    # Slide window
    for i in range(len(p), len(s)):
        # Add new character
        new_char = s[i]
        window_freq[new_char] = window_freq.get(new_char, 0) + 1

        # Remove old character
        old_char = s[i - len(p)]
        window_freq[old_char] -= 1
        if window_freq[old_char] == 0:
            del window_freq[old_char]

        # Check if anagram
        if window_freq == p_freq:
            result.append(i - len(p) + 1)

    return result


# ============================================================================
# EXERCISE 4: Subarray Problems
# ============================================================================


def subarray_sum_equals_k(arr, k):
    """
    Count number of continuous subarrays whose sum equals k.

    Time: O(n) - Single pass
    Space: O(n) - Store prefix sums

    Approach:
    - Use prefix sum technique
    - Key insight: If prefix_sum[j] - prefix_sum[i] = k,
                   then subarray from i+1 to j has sum k
    - Store frequency of each prefix sum in hash map
    - For each position, check if (current_sum - k) exists

    Example: arr=[1, 1, 1], k=2
    - At index 1: sum=2, check if sum-k=0 exists → yes (1 subarray)
    - At index 2: sum=3, check if sum-k=1 exists → yes (1 subarray)
    - Total: 2 subarrays
    """
    count = 0
    prefix_sum = 0
    sum_freq = {0: 1}  # Initialize with 0 for subarrays starting at index 0

    for num in arr:
        prefix_sum += num

        # Check how many times (prefix_sum - k) has appeared
        # Each occurrence means a subarray ending here with sum k
        if prefix_sum - k in sum_freq:
            count += sum_freq[prefix_sum - k]

        # Add current prefix sum to map
        sum_freq[prefix_sum] = sum_freq.get(prefix_sum, 0) + 1

    return count


def longest_consecutive_sequence(arr):
    """
    Find length of longest consecutive elements sequence.

    Time: O(n) - Each element checked at most twice
    Space: O(n) - Set stores all elements

    Approach:
    - Put all elements in set for O(1) lookup
    - For each number, check if it's start of sequence (num-1 not in set)
    - If start, count consecutive numbers
    - Track maximum length

    Key insight: Only start counting from sequence start to avoid recounting
    """
    if not arr:
        return 0

    num_set = set(arr)
    max_length = 0

    for num in num_set:
        # Only start counting if this is the beginning of a sequence
        if num - 1 not in num_set:
            current = num
            length = 1

            # Count consecutive numbers
            while current + 1 in num_set:
                current += 1
                length += 1

            max_length = max(max_length, length)

    return max_length


def subarray_with_zero_sum(arr):
    """
    Check if there exists a subarray with sum 0.

    Time: O(n) - Single pass
    Space: O(n) - Store prefix sums

    Approach:
    - Use prefix sums
    - Key insight: If same prefix sum appears twice,
                   the subarray between those positions has sum 0
    - Also check if prefix sum itself is 0 (subarray from start)
    """
    prefix_sum = 0
    seen = {0}  # Include 0 for subarrays starting at index 0

    for num in arr:
        prefix_sum += num
        if prefix_sum in seen:
            return True
        seen.add(prefix_sum)

    return False


# ============================================================================
# EXERCISE 5: String Problems
# ============================================================================


def longest_substring_without_repeating(s):
    """
    Find length of longest substring without repeating characters.

    Time: O(n) - Each character visited at most twice
    Space: O(min(n, m)) - m is charset size

    Approach:
    - Use sliding window with hash map
    - Map character → last seen index
    - When duplicate found, move left pointer past previous occurrence
    - Track maximum window size
    """
    char_index = {}
    max_length = 0
    left = 0

    for right, char in enumerate(s):
        # If character seen and within current window
        if char in char_index and char_index[char] >= left:
            left = char_index[char] + 1

        char_index[char] = right
        max_length = max(max_length, right - left + 1)

    return max_length


def character_replacement(s, k):
    """
    Find length of longest substring with same letter after k replacements.

    Time: O(n) - Sliding window
    Space: O(1) - Fixed alphabet (26 letters)

    Approach:
    - Use sliding window with frequency map
    - Window is valid if: (window_size - max_frequency) <= k
    - This means we can replace the minority characters
    - Expand window when valid, contract when invalid
    """
    freq = {}
    max_length = 0
    max_freq = 0
    left = 0

    for right, char in enumerate(s):
        freq[char] = freq.get(char, 0) + 1
        max_freq = max(max_freq, freq[char])

        # Window size - most frequent char count = replacements needed
        window_size = right - left + 1
        if window_size - max_freq > k:
            # Shrink window
            freq[s[left]] -= 1
            left += 1

        max_length = max(max_length, right - left + 1)

    return max_length


def minimum_window_substring(s, t):
    """
    Find minimum window in s that contains all characters from t.

    Time: O(n + m) - n=len(s), m=len(t)
    Space: O(m) - Store character frequencies from t

    Approach:
    - Use two pointers (sliding window)
    - Expand right to include characters
    - Contract left while window is valid
    - Track minimum window that contains all characters from t
    """
    if not s or not t:
        return ""

    # Count characters needed from t
    need = {}
    for char in t:
        need[char] = need.get(char, 0) + 1

    have = {}
    required = len(need)
    formed = 0

    left = 0
    min_len = float("inf")
    min_left = 0

    for right, char in enumerate(s):
        # Add character to window
        have[char] = have.get(char, 0) + 1

        # Check if this character's frequency matches requirement
        if char in need and have[char] == need[char]:
            formed += 1

        # Contract window while valid
        while left <= right and formed == required:
            # Update result if this is smaller window
            if right - left + 1 < min_len:
                min_len = right - left + 1
                min_left = left

            # Remove leftmost character
            char = s[left]
            have[char] -= 1
            if char in need and have[char] < need[char]:
                formed -= 1

            left += 1

    return "" if min_len == float("inf") else s[min_left : min_left + min_len]


# ============================================================================
# EXERCISE 6: Array Operations
# ============================================================================


def intersection_of_two_arrays(arr1, arr2):
    """
    Find intersection of two arrays (unique elements).

    Time: O(n + m) - Convert to set + iterate
    Space: O(min(n, m)) - Store smaller array in set

    Approach:
    - Convert one array to set
    - Iterate other array and check membership
    - Use set for result to ensure uniqueness
    """
    set1 = set(arr1)
    result = set()

    for num in arr2:
        if num in set1:
            result.add(num)

    return list(result)


def single_number(arr):
    """
    Find the element that appears once while others appear twice.

    Time: O(n)
    Space: O(1) - Using XOR

    Approach using XOR:
    - XOR properties: a ^ a = 0, a ^ 0 = a
    - XOR all numbers together
    - Pairs cancel out, single number remains

    Alternative with set: O(n) space
    """
    result = 0
    for num in arr:
        result ^= num
    return result


def happy_number(n):
    """
    Check if a number is happy.

    Time: O(log n) - Number of digits decreases
    Space: O(log n) - Store seen numbers to detect cycle

    Approach:
    - Keep calculating sum of squares of digits
    - Use set to detect if we enter a cycle
    - If we reach 1, it's happy
    - If we see a repeated number, it's not happy (stuck in cycle)
    """

    def get_next(num):
        total = 0
        while num > 0:
            digit = num % 10
            total += digit * digit
            num //= 10
        return total

    seen = set()
    while n != 1 and n not in seen:
        seen.add(n)
        n = get_next(n)

    return n == 1


# ============================================================================
# EXERCISE 7: Advanced Problems
# ============================================================================


def top_k_frequent_elements(arr, k):
    """
    Find k most frequent elements.

    Time: O(n) - Using bucket sort
    Space: O(n) - Frequency map + buckets

    Approach (Bucket Sort - Optimal):
    - Count frequency of each element
    - Create buckets: index = frequency, value = list of elements
    - Collect k elements from highest frequency buckets

    Alternative: Use heap for O(n log k)
    """
    # Count frequencies
    freq = {}
    for num in arr:
        freq[num] = freq.get(num, 0) + 1

    # Bucket sort: index is frequency
    buckets = [[] for _ in range(len(arr) + 1)]
    for num, count in freq.items():
        buckets[count].append(num)

    # Collect k elements from highest frequencies
    result = []
    for i in range(len(buckets) - 1, -1, -1):
        for num in buckets[i]:
            result.append(num)
            if len(result) == k:
                return result

    return result


def valid_sudoku(board):
    """
    Check if a 9x9 Sudoku board is valid.

    Time: O(1) - Fixed 9x9 board (81 cells)
    Space: O(1) - Fixed size sets

    Approach:
    - Use sets to track seen numbers in each row/column/box
    - For each cell, check if number already seen
    - Box index: (row // 3, col // 3)
    """
    rows = [set() for _ in range(9)]
    cols = [set() for _ in range(9)]
    boxes = [set() for _ in range(9)]

    for r in range(9):
        for c in range(9):
            if board[r][c] == ".":
                continue

            num = board[r][c]
            box_index = (r // 3) * 3 + (c // 3)

            # Check if number already exists
            if num in rows[r] or num in cols[c] or num in boxes[box_index]:
                return False

            rows[r].add(num)
            cols[c].add(num)
            boxes[box_index].add(num)

    return True


def word_pattern(pattern, s):
    """
    Check if string s follows the same pattern.

    Time: O(n) - n is length of pattern/words
    Space: O(n) - Two hash maps

    Approach:
    - Need bijection (one-to-one mapping both ways)
    - Use two hash maps: pattern→word and word→pattern
    - Check both mappings are consistent
    """
    words = s.split()

    if len(pattern) != len(words):
        return False

    char_to_word = {}
    word_to_char = {}

    for char, word in zip(pattern, words):
        if char in char_to_word:
            if char_to_word[char] != word:
                return False
        else:
            char_to_word[char] = word

        if word in word_to_char:
            if word_to_char[word] != char:
                return False
        else:
            word_to_char[word] = char

    return True


def isomorphic_strings(s, t):
    """
    Check if two strings are isomorphic.

    Time: O(n)
    Space: O(1) - Fixed charset

    Approach:
    - Similar to word_pattern
    - Need one-to-one mapping in both directions
    - Use two hash maps
    """
    if len(s) != len(t):
        return False

    s_to_t = {}
    t_to_s = {}

    for char_s, char_t in zip(s, t):
        if char_s in s_to_t:
            if s_to_t[char_s] != char_t:
                return False
        else:
            s_to_t[char_s] = char_t

        if char_t in t_to_s:
            if t_to_s[char_t] != char_s:
                return False
        else:
            t_to_s[char_t] = char_s

    return True


# ============================================================================
# EXERCISE 8: Design Problems
# ============================================================================


class Logger:
    """
    Design a logger that rate-limits messages.

    Approach:
    - Use hash map: message → last_timestamp
    - When message arrives, check if 10+ seconds passed
    - Update timestamp if printing
    """

    def __init__(self):
        self.message_times = {}

    def should_print_message(self, timestamp, message):
        """
        Time: O(1)
        Space: O(M) where M is number of unique messages
        """
        if message not in self.message_times:
            self.message_times[message] = timestamp
            return True

        last_time = self.message_times[message]
        if timestamp - last_time >= 10:
            self.message_times[message] = timestamp
            return True

        return False


class TwoSum:
    """
    Design a data structure for two sum queries.

    Approach:
    - Store frequency of each number
    - For find(), check all numbers and their complements
    - Handle case where same number is used twice
    """

    def __init__(self):
        self.freq = {}

    def add(self, number):
        """Time: O(1)"""
        self.freq[number] = self.freq.get(number, 0) + 1

    def find(self, value):
        """Time: O(n) where n is number of unique values"""
        for num in self.freq:
            complement = value - num

            if complement in self.freq:
                # If same number, need at least 2 occurrences
                if num == complement:
                    if self.freq[num] >= 2:
                        return True
                else:
                    return True

        return False


# ============================================================================
# TESTING
# ============================================================================

if __name__ == "__main__":
    print("=== Exercise 1: Basic Operations ===")
    print("Contains duplicate:", contains_duplicate([1, 2, 3, 1]))
    print("First unique char:", first_unique_character("leetcode"))
    print("Majority element:", majority_element([3, 2, 3]))

    print("\n=== Exercise 2: Two Sum ===")
    print("Two sum:", two_sum([2, 7, 11, 15], 9))
    print("Count pairs:", two_sum_count_pairs([1, 5, 7, -1, 5], 6))
    print("Three sum count:", three_sum_count([1, 2, 3, 4], 6))

    print("\n=== Exercise 3: Anagrams ===")
    print("Is anagram:", is_anagram("anagram", "nagaram"))
    print("Group anagrams:", group_anagrams(["eat", "tea", "tan", "ate", "nat", "bat"]))
    print("Find anagrams:", find_anagrams_in_string("cbaebabacd", "abc"))

    print("\n=== Exercise 4: Subarrays ===")
    print("Subarray sum k:", subarray_sum_equals_k([1, 1, 1], 2))
    print("Longest consecutive:", longest_consecutive_sequence([100, 4, 200, 1, 3, 2]))
    print("Zero sum exists:", subarray_with_zero_sum([4, 2, -3, 1, 6]))

    print("\n=== Exercise 5: Strings ===")
    print("Longest substring:", longest_substring_without_repeating("abcabcbb"))
    print("Character replacement:", character_replacement("AABABBA", 1))
    print("Min window:", minimum_window_substring("ADOBECODEBANC", "ABC"))

    print("\n=== Exercise 6: Arrays ===")
    print("Intersection:", intersection_of_two_arrays([1, 2, 2, 1], [2, 2]))
    print("Single number:", single_number([2, 2, 1]))
    print("Happy number:", happy_number(19))

    print("\n=== Exercise 7: Advanced ===")
    print("Top k frequent:", top_k_frequent_elements([1, 1, 1, 2, 2, 3], 2))
    print("Word pattern:", word_pattern("abba", "dog cat cat dog"))
    print("Isomorphic:", isomorphic_strings("egg", "add"))

    print("\n=== Exercise 8: Design ===")
    logger = Logger()
    print("Logger 1:", logger.should_print_message(1, "foo"))
    print("Logger 3:", logger.should_print_message(3, "foo"))
    print("Logger 11:", logger.should_print_message(11, "foo"))

    two_sum = TwoSum()
    two_sum.add(1)
    two_sum.add(3)
    two_sum.add(5)
    print("TwoSum find 4:", two_sum.find(4))
    print("TwoSum find 7:", two_sum.find(7))
