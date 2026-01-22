"""
Big O Notation - Solutions

Complete solutions with detailed explanations for all exercises.
"""


# ============================================================================
# EXERCISE 1: Analyze Complexity - ANSWERS
# ============================================================================

"""
Exercise 1a:
Time: O(n) - Single loop through array
Space: O(1) - Only storing one variable (result)

Exercise 1b:
Time: O(n²) - Nested loops, both iterate over entire array
Space: O(1) - No extra data structures

Exercise 1c:
Time: O(log n) - Dividing n by 2 each iteration
Space: O(1) - Only one variable

Exercise 1d:
Time: O(n log n) - Sort is O(n log n), loop is O(n), total is O(n log n)
       When adding complexities, take the larger one
Space: O(1) or O(n) depending on sort implementation
"""


# ============================================================================
# EXERCISE 2: Optimize These Functions - SOLUTIONS
# ============================================================================

def find_pair_with_sum_fast(arr, target):
    """
    Optimized to O(n) using hash set.

    Time: O(n) - Single pass through array with O(1) lookups
    Space: O(n) - Set stores up to n elements

    Strategy: For each number, check if complement (target - num) exists
    """
    seen = set()

    for num in arr:
        complement = target - num
        if complement in seen:
            return True
        seen.add(num)

    return False


def find_duplicates_fast(arr):
    """
    Optimized to O(n) using frequency map.

    Time: O(n) - Two passes through array
    Space: O(n) - Map stores frequencies

    Strategy: Count frequencies, then collect elements with count > 1
    """
    freq = {}
    for num in arr:
        freq[num] = freq.get(num, 0) + 1

    duplicates = []
    for num, count in freq.items():
        if count > 1:
            duplicates.append(num)

    return duplicates


# Alternative one-pass solution
def find_duplicates_fast_v2(arr):
    """
    One-pass solution using set to track seen and duplicates.

    Time: O(n)
    Space: O(n)
    """
    seen = set()
    duplicates = set()

    for num in arr:
        if num in seen:
            duplicates.add(num)
        else:
            seen.add(num)

    return list(duplicates)


# ============================================================================
# EXERCISE 3: Implement with Given Complexity - SOLUTIONS
# ============================================================================

def is_sorted(arr):
    """
    Check if array is sorted.

    Time: O(n) - Single pass, return early if unsorted found
    Space: O(1) - No extra space

    Strategy: Compare each adjacent pair
    """
    for i in range(len(arr) - 1):
        if arr[i] > arr[i + 1]:
            return False
    return True


def find_missing_number(arr, n):
    """
    Find missing number using mathematical approach.

    Time: O(n) - Single pass to calculate sum
    Space: O(1) - Only variables for sums

    Strategy: Expected sum - Actual sum = Missing number
    Expected sum of 1 to n: n * (n + 1) / 2
    """
    expected_sum = n * (n + 1) // 2
    actual_sum = sum(arr)
    return expected_sum - actual_sum


# Alternative using XOR (also O(n) time, O(1) space)
def find_missing_number_xor(arr, n):
    """
    Using XOR property: a ^ a = 0, a ^ 0 = a

    XOR all numbers from 1 to n and all array elements.
    Duplicates cancel out, leaving only the missing number.
    """
    xor_all = 0
    xor_arr = 0

    for i in range(1, n + 1):
        xor_all ^= i

    for num in arr:
        xor_arr ^= num

    return xor_all ^ xor_arr


def reverse_string(s):
    """
    Reverse a string.

    Time: O(n) - Process each character once
    Space: O(n) - New string of same length

    Python strings are immutable, so we need new string.
    """
    return s[::-1]


# Alternative: Using list for clearer logic
def reverse_string_v2(s):
    """More explicit two-pointer approach."""
    chars = list(s)
    left, right = 0, len(chars) - 1

    while left < right:
        chars[left], chars[right] = chars[right], chars[left]
        left += 1
        right -= 1

    return ''.join(chars)


def contains_duplicate(arr):
    """
    Check for duplicates using set.

    Time: O(n) - Single pass with O(1) set operations
    Space: O(n) - Set stores unique elements

    Strategy: Add to set, if already exists, found duplicate
    """
    seen = set()
    for num in arr:
        if num in seen:
            return True
        seen.add(num)
    return False


# Alternative: One-liner
def contains_duplicate_v2(arr):
    """Compare set size to array length."""
    return len(set(arr)) < len(arr)


# ============================================================================
# EXERCISE 4: Space-Time Tradeoffs - SOLUTIONS
# ============================================================================

def first_recurring_character_v1(s):
    """
    O(n²) time, O(1) space approach.

    For each character, check if it appears later in string.
    """
    for i in range(len(s)):
        for j in range(i + 1, len(s)):
            if s[i] == s[j]:
                return s[i]
    return None


def first_recurring_character_v2(s):
    """
    O(n) time, O(n) space approach.

    Use set to track seen characters.
    """
    seen = set()
    for char in s:
        if char in seen:
            return char
        seen.add(char)
    return None


# ============================================================================
# EXERCISE 5: Analyze Recursive Functions - ANSWERS
# ============================================================================

"""
mystery_function_1:
Does: Calculates sum of numbers from 1 to n (sum = n + (n-1) + ... + 1)
Time: O(n) - Makes n recursive calls
Space: O(n) - Call stack depth is n

mystery_function_2:
Time: O(2ⁿ) - Each call makes 2 recursive calls, tree has 2^n nodes
Space: O(n) - Maximum call stack depth is n
Note: This is extremely inefficient!

mystery_function_3:
Does: Binary search - finds target in sorted array
Time: O(log n) - Halves search space each call
Space: O(log n) - Recursive call stack (iterative would be O(1))
"""


# ============================================================================
# EXERCISE 6: Complex Analysis - ANSWERS
# ============================================================================

"""
complex_function:
Part 1: O(a) - Loop through arr1
Part 2: O(a × b) - Nested loops
Part 3: O(b log b) - Sort arr2

Total: O(a + a×b + b log b) = O(a×b + b log b)
If a and b are similar sizes: O(a×b) dominates

nested_loops:
Time: O(n²)
Explanation: Outer loop runs n times
Inner loop runs: n, n-1, n-2, ..., 1 times
Total operations: n + (n-1) + (n-2) + ... + 1 = n(n+1)/2 = O(n²)
"""


# ============================================================================
# EXERCISE 7: Implement Efficiently - SOLUTIONS
# ============================================================================

def move_zeros_to_end(arr):
    """
    Move zeros to end in-place.

    Time: O(n) - Single pass with two pointers
    Space: O(1) - Only pointer variables

    Strategy: Use write pointer for next non-zero position
    """
    write_pos = 0

    # Move all non-zeros to front
    for read_pos in range(len(arr)):
        if arr[read_pos] != 0:
            arr[write_pos] = arr[read_pos]
            write_pos += 1

    # Fill remaining with zeros
    while write_pos < len(arr):
        arr[write_pos] = 0
        write_pos += 1

    return arr


# Alternative: Swap approach
def move_zeros_to_end_v2(arr):
    """Swap non-zeros with zeros as we go."""
    left = 0  # Position of next zero

    for right in range(len(arr)):
        if arr[right] != 0:
            arr[left], arr[right] = arr[right], arr[left]
            left += 1

    return arr


def find_intersection(arr1, arr2):
    """
    Find common elements.

    Time: O(n + m) - Create set from arr1, iterate arr2
    Space: O(min(n, m)) - Set of smaller array

    Strategy: Convert smaller array to set, check larger array
    """
    # Optimize by using smaller array for set
    if len(arr1) > len(arr2):
        arr1, arr2 = arr2, arr1

    set1 = set(arr1)
    intersection = []

    for num in arr2:
        if num in set1:
            intersection.append(num)
            set1.remove(num)  # Avoid duplicates in result

    return intersection


# Alternative: Using set intersection
def find_intersection_v2(arr1, arr2):
    """Simpler using built-in set operations."""
    return list(set(arr1) & set(arr2))


def is_anagram(s1, s2):
    """
    Check if anagrams.

    Time: O(n) - Where n is length of strings
    Space: O(1) - Fixed size (26 letters) regardless of input

    Strategy: Count character frequencies
    """
    if len(s1) != len(s2):
        return False

    # Count frequencies
    freq = {}
    for char in s1:
        freq[char] = freq.get(char, 0) + 1

    # Subtract frequencies
    for char in s2:
        if char not in freq:
            return False
        freq[char] -= 1
        if freq[char] < 0:
            return False

    return True


# Alternative: Using sorting (O(n log n))
def is_anagram_v2(s1, s2):
    """Sort both strings and compare."""
    return sorted(s1) == sorted(s2)


# Alternative: Using Counter (cleanest)
from collections import Counter

def is_anagram_v3(s1, s2):
    """Using Python's Counter class."""
    return Counter(s1) == Counter(s2)


# ============================================================================
# TESTING
# ============================================================================

if __name__ == "__main__":
    print("=== Testing Exercise Solutions ===\n")

    # Exercise 2
    print("Find pair with sum:")
    print(find_pair_with_sum_fast([1, 2, 3, 9], 8))  # False
    print(find_pair_with_sum_fast([1, 2, 4, 4], 8))  # True

    print("\nFind duplicates:")
    print(find_duplicates_fast([1, 2, 3, 1, 2, 4]))  # [1, 2]

    # Exercise 3
    print("\nIs sorted:")
    print(is_sorted([1, 2, 3, 4, 5]))  # True
    print(is_sorted([1, 3, 2, 4]))     # False

    print("\nFind missing number:")
    print(find_missing_number([1, 2, 4, 5, 6], 6))  # 3

    print("\nReverse string:")
    print(reverse_string("hello"))  # "olleh"

    print("\nContains duplicate:")
    print(contains_duplicate([1, 2, 3, 1]))  # True
    print(contains_duplicate([1, 2, 3, 4]))  # False

    # Exercise 4
    print("\nFirst recurring character:")
    print(first_recurring_character_v2("abccba"))  # "c"

    # Exercise 7
    print("\nMove zeros to end:")
    arr = [0, 1, 0, 3, 12]
    print(move_zeros_to_end(arr))  # [1, 3, 12, 0, 0]

    print("\nFind intersection:")
    print(find_intersection([1, 2, 3, 4], [3, 4, 5, 6]))  # [3, 4]

    print("\nIs anagram:")
    print(is_anagram("listen", "silent"))  # True
    print(is_anagram("hello", "world"))    # False
