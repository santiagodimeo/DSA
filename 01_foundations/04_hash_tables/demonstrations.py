"""
Hash Tables - Code Demonstrations

This file demonstrates common hash table patterns and operations.
Study each function and its use case.
"""

# ============================================================================
# BASIC OPERATIONS
# ============================================================================


def demo_dictionary_basics():
    """
    Demonstrate basic dictionary operations.

    Time: O(1) for each operation
    Space: O(n) for storing n key-value pairs
    """
    # Creating dictionaries
    empty_dict = {}
    student_grades = {"Alice": 95, "Bob": 87, "Charlie": 92}

    # Insertion and update
    student_grades["David"] = 88  # Insert new
    student_grades["Alice"] = 98  # Update existing

    # Lookup
    alice_grade = student_grades["Alice"]  # Direct access (raises KeyError if missing)
    bob_grade = student_grades.get("Bob")  # Safe access (returns None if missing)
    eve_grade = student_grades.get("Eve", 0)  # With default value

    # Check existence
    has_charlie = "Charlie" in student_grades  # True
    has_eve = "Eve" in student_grades  # False

    # Deletion
    removed = student_grades.pop("David", None)  # Remove and return (safe)
    # del student_grades["Charlie"]  # Remove (raises KeyError if missing)

    # Iteration
    for name in student_grades:  # Iterate over keys
        print(f"{name}: {student_grades[name]}")

    for name, grade in student_grades.items():  # Iterate over key-value pairs
        print(f"{name}: {grade}")

    return student_grades


def demo_set_basics():
    """
    Demonstrate basic set operations.

    Time: O(1) for each operation
    Space: O(n) for storing n elements
    """
    # Creating sets
    empty_set = set()
    numbers = {1, 2, 3, 4, 5}

    # Insertion
    numbers.add(6)
    numbers.add(3)  # Duplicates are ignored

    # Check existence
    has_three = 3 in numbers  # True
    has_ten = 10 in numbers  # False

    # Deletion
    numbers.remove(6)  # Raises KeyError if not found
    numbers.discard(10)  # Safe removal (no error if not found)

    # Set operations
    set1 = {1, 2, 3, 4}
    set2 = {3, 4, 5, 6}

    union = set1 | set2  # {1, 2, 3, 4, 5, 6}
    intersection = set1 & set2  # {3, 4}
    difference = set1 - set2  # {1, 2}
    symmetric_diff = set1 ^ set2  # {1, 2, 5, 6}

    return numbers


# ============================================================================
# PATTERN 1: CHECKING FOR DUPLICATES
# ============================================================================


def contains_duplicate(arr):
    """
    Check if array contains any duplicates.

    Time: O(n) - Single pass through array
    Space: O(n) - Set can store up to n elements

    Pattern: Use set to track seen elements
    """
    seen = set()
    for num in arr:
        if num in seen:
            return True
        seen.add(num)
    return False


def find_duplicates(arr):
    """
    Find all elements that appear more than once.

    Time: O(n) - Two passes
    Space: O(n) - Dictionary for counts

    Pattern: Frequency counting
    """
    freq = {}
    for num in arr:
        freq[num] = freq.get(num, 0) + 1

    duplicates = [num for num, count in freq.items() if count > 1]
    return duplicates


def first_duplicate(arr):
    """
    Find the first element that appears twice.

    Time: O(n) - Single pass
    Space: O(n) - Set for tracking

    Example: [2, 1, 3, 5, 3, 2] → returns 3 (first to appear twice)
    """
    seen = set()
    for num in arr:
        if num in seen:
            return num
        seen.add(num)
    return None


# ============================================================================
# PATTERN 2: FREQUENCY COUNTING
# ============================================================================


def character_frequency(s):
    """
    Count frequency of each character.

    Time: O(n) - Single pass through string
    Space: O(k) - k unique characters (at most 26 for lowercase letters)
    """
    freq = {}
    for char in s:
        freq[char] = freq.get(char, 0) + 1
    return freq


def most_frequent_element(arr):
    """
    Find the most frequently occurring element.

    Time: O(n) - Count frequencies then find max
    Space: O(n) - Frequency map
    """
    if not arr:
        return None

    freq = {}
    for num in arr:
        freq[num] = freq.get(num, 0) + 1

    max_count = 0
    most_frequent = None
    for num, count in freq.items():
        if count > max_count:
            max_count = count
            most_frequent = num

    return most_frequent


def k_most_frequent(arr, k):
    """
    Find k most frequent elements.

    Time: O(n log n) - Due to sorting
    Space: O(n) - Frequency map

    Better approach: Use heap for O(n log k)
    """
    freq = {}
    for num in arr:
        freq[num] = freq.get(num, 0) + 1

    # Sort by frequency (descending)
    sorted_items = sorted(freq.items(), key=lambda x: x[1], reverse=True)

    return [num for num, count in sorted_items[:k]]


# ============================================================================
# PATTERN 3: TWO SUM / COMPLEMENT PATTERN
# ============================================================================


def two_sum(arr, target):
    """
    Find indices of two numbers that sum to target.

    Time: O(n) - Single pass
    Space: O(n) - Hash map for seen numbers

    Key insight: For each number, check if (target - number) exists
    """
    seen = {}  # Maps number → index

    for i, num in enumerate(arr):
        complement = target - num
        if complement in seen:
            return [seen[complement], i]
        seen[num] = i

    return None


def two_sum_all_pairs(arr, target):
    """
    Find all unique pairs that sum to target.

    Time: O(n) - Single pass
    Space: O(n) - Set for seen numbers and pairs
    """
    seen = set()
    pairs = set()

    for num in arr:
        complement = target - num
        if complement in seen:
            # Store as sorted tuple to avoid duplicates
            pair = tuple(sorted([num, complement]))
            pairs.add(pair)
        seen.add(num)

    return list(pairs)


def three_sum_exists(arr, target):
    """
    Check if three numbers sum to target.

    Time: O(n²) - n iterations × O(n) two sum
    Space: O(n) - Hash set for lookups

    Pattern: Fix one number, do two sum on remaining
    """
    arr.sort()  # Optional: helps with optimization

    for i in range(len(arr) - 2):
        # Look for two numbers that sum to (target - arr[i])
        remaining = target - arr[i]
        seen = set()

        for j in range(i + 1, len(arr)):
            complement = remaining - arr[j]
            if complement in seen:
                return True
            seen.add(arr[j])

    return False


# ============================================================================
# PATTERN 4: ANAGRAMS
# ============================================================================


def is_anagram(s1, s2):
    """
    Check if two strings are anagrams.

    Time: O(n) - Count characters in both strings
    Space: O(1) - Fixed size (26 letters) or O(n) for general case

    Anagram: Same characters, different order
    Example: "listen" and "silent"
    """
    if len(s1) != len(s2):
        return False

    freq1 = {}
    freq2 = {}

    for char in s1:
        freq1[char] = freq1.get(char, 0) + 1

    for char in s2:
        freq2[char] = freq2.get(char, 0) + 1

    return freq1 == freq2


def is_anagram_optimized(s1, s2):
    """
    Check anagram with single frequency map.

    Time: O(n)
    Space: O(1) for lowercase letters
    """
    if len(s1) != len(s2):
        return False

    freq = {}

    # Add counts for s1
    for char in s1:
        freq[char] = freq.get(char, 0) + 1

    # Subtract counts for s2
    for char in s2:
        if char not in freq:
            return False
        freq[char] -= 1
        if freq[char] == 0:
            del freq[char]

    return len(freq) == 0


def group_anagrams(words):
    """
    Group words that are anagrams of each other.

    Time: O(n × k log k) - n words, k average length, sorting each
    Space: O(n × k) - Store all words

    Example: ["eat", "tea", "tan", "ate", "nat", "bat"]
         → [["eat", "tea", "ate"], ["tan", "nat"], ["bat"]]

    Key insight: Sorted string is same for all anagrams
    """
    groups = {}

    for word in words:
        # Use sorted characters as key
        key = "".join(sorted(word))

        if key not in groups:
            groups[key] = []
        groups[key].append(word)

    return list(groups.values())


# ============================================================================
# PATTERN 5: SUBARRAY PROBLEMS WITH PREFIX SUMS
# ============================================================================


def subarray_sum_equals_k(arr, k):
    """
    Count subarrays with sum equal to k.

    Time: O(n) - Single pass
    Space: O(n) - Hash map for prefix sums

    Key insight: If prefix_sum[j] - prefix_sum[i] = k,
                 then subarray from i+1 to j has sum k
    """
    count = 0
    prefix_sum = 0
    sum_freq = {0: 1}  # Initialize with 0 sum

    for num in arr:
        prefix_sum += num

        # Check if (prefix_sum - k) exists
        # If yes, there's a subarray ending here with sum k
        if prefix_sum - k in sum_freq:
            count += sum_freq[prefix_sum - k]

        # Add current prefix sum to map
        sum_freq[prefix_sum] = sum_freq.get(prefix_sum, 0) + 1

    return count


def longest_subarray_sum_k(arr, k):
    """
    Find length of longest subarray with sum k.

    Time: O(n) - Single pass
    Space: O(n) - Hash map for prefix sums

    Store first occurrence of each prefix sum
    """
    max_length = 0
    prefix_sum = 0
    sum_index = {0: -1}  # Map prefix_sum → first index

    for i, num in enumerate(arr):
        prefix_sum += num

        # Check if there's a subarray ending at i with sum k
        if prefix_sum - k in sum_index:
            length = i - sum_index[prefix_sum - k]
            max_length = max(max_length, length)

        # Store first occurrence only
        if prefix_sum not in sum_index:
            sum_index[prefix_sum] = i

    return max_length


# ============================================================================
# PATTERN 6: CACHING / MEMOIZATION
# ============================================================================


def fibonacci_with_memo(n, memo=None):
    """
    Calculate Fibonacci with memoization.

    Time: O(n) - Each number calculated once
    Space: O(n) - Recursion stack + memo dictionary

    Without memo: O(2ⁿ) - exponential time
    With memo: O(n) - linear time
    """
    if memo is None:
        memo = {}

    if n in memo:
        return memo[n]

    if n <= 1:
        return n

    memo[n] = fibonacci_with_memo(n - 1, memo) + fibonacci_with_memo(n - 2, memo)
    return memo[n]


# ============================================================================
# PATTERN 7: UNIQUE ELEMENTS
# ============================================================================


def intersection_of_arrays(arr1, arr2):
    """
    Find common elements between two arrays.

    Time: O(n + m) - Linear in both array sizes
    Space: O(min(n, m)) - Set for smaller array
    """
    set1 = set(arr1)
    result = set()

    for num in arr2:
        if num in set1:
            result.add(num)

    return list(result)


def union_of_arrays(arr1, arr2):
    """
    Find all unique elements from both arrays.

    Time: O(n + m)
    Space: O(n + m)
    """
    return list(set(arr1) | set(arr2))


def remove_duplicates(arr):
    """
    Remove duplicates while preserving order.

    Time: O(n)
    Space: O(n)
    """
    seen = set()
    result = []

    for num in arr:
        if num not in seen:
            result.append(num)
            seen.add(num)

    return result


# ============================================================================
# ADVANCED: COLLECTIONS MODULE
# ============================================================================


def demo_defaultdict():
    """
    Demonstrate defaultdict usage.
    """
    from collections import defaultdict

    # Auto-initialize with int (default 0)
    freq = defaultdict(int)
    for char in "hello":
        freq[char] += 1  # No need to check if key exists

    # Auto-initialize with list
    groups = defaultdict(list)
    groups["even"].append(2)
    groups["odd"].append(1)

    return dict(freq), dict(groups)


def demo_counter():
    """
    Demonstrate Counter usage.
    """
    from collections import Counter

    # Count elements
    arr = [1, 2, 2, 3, 3, 3, 4, 4, 4, 4]
    freq = Counter(arr)  # Counter({4: 4, 3: 3, 2: 2, 1: 1})

    # Most common elements
    top_2 = freq.most_common(2)  # [(4, 4), (3, 3)]

    # Arithmetic operations
    c1 = Counter(["a", "b", "c"])
    c2 = Counter(["a", "b", "d"])
    combined = c1 + c2  # Counter({'a': 2, 'b': 2, 'c': 1, 'd': 1})

    return freq, top_2, combined


# ============================================================================
# TESTING
# ============================================================================

if __name__ == "__main__":
    print("=== Basic Operations ===")
    print("Dict:", demo_dictionary_basics())
    print("Set:", demo_set_basics())

    print("\n=== Pattern 1: Duplicates ===")
    print("Contains duplicate:", contains_duplicate([1, 2, 3, 1]))
    print("Find duplicates:", find_duplicates([1, 2, 2, 3, 4, 4, 5]))
    print("First duplicate:", first_duplicate([2, 1, 3, 5, 3, 2]))

    print("\n=== Pattern 2: Frequency ===")
    print("Char frequency:", character_frequency("hello"))
    print("Most frequent:", most_frequent_element([1, 3, 3, 2, 3, 1]))
    print("K most frequent:", k_most_frequent([1, 1, 1, 2, 2, 3], 2))

    print("\n=== Pattern 3: Two Sum ===")
    print("Two sum:", two_sum([2, 7, 11, 15], 9))
    print("All pairs:", two_sum_all_pairs([1, 2, 3, 4, 5], 7))

    print("\n=== Pattern 4: Anagrams ===")
    print("Is anagram:", is_anagram("listen", "silent"))
    print("Group anagrams:", group_anagrams(["eat", "tea", "tan", "ate", "nat", "bat"]))

    print("\n=== Pattern 5: Subarray Sum ===")
    print("Subarray sum count:", subarray_sum_equals_k([1, 1, 1], 2))
    print("Longest subarray:", longest_subarray_sum_k([1, -1, 5, -2, 3], 3))

    print("\n=== Pattern 6: Memoization ===")
    print("Fibonacci(10):", fibonacci_with_memo(10))

    print("\n=== Pattern 7: Unique Elements ===")
    print("Intersection:", intersection_of_arrays([1, 2, 3], [2, 3, 4]))
    print("Remove duplicates:", remove_duplicates([1, 2, 2, 3, 1, 4]))

    print("\n=== Advanced Collections ===")
    print("defaultdict:", demo_defaultdict())
    print("Counter:", demo_counter())
