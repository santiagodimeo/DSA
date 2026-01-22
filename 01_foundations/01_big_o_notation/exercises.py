"""
Big O Notation - Exercises

For each function below:
1. Analyze the time complexity
2. Analyze the space complexity
3. Try to optimize if possible

After attempting, check solutions.py for answers and explanations.
"""


# ============================================================================
# EXERCISE 1: Analyze Complexity
# ============================================================================

def exercise_1a(arr):
    """
    What is the time complexity of this function?
    What is the space complexity?
    """
    result = 0
    for num in arr:
        result += num
    return result

# Your answer:
# Time:
# Space:


def exercise_1b(arr):
    """
    What is the time complexity?
    What is the space complexity?
    """
    for i in range(len(arr)):
        for j in range(len(arr)):
            if i != j and arr[i] == arr[j]:
                return True
    return False

# Your answer:
# Time:
# Space:


def exercise_1c(arr):
    """
    What is the time complexity?
    What is the space complexity?
    """
    n = len(arr)
    while n > 1:
        n = n // 2
    return n

# Your answer:
# Time:
# Space:


def exercise_1d(arr):
    """
    What is the time complexity?
    Consider both the sort and the loop.
    """
    arr.sort()  # Python's sort is O(n log n)
    for num in arr:
        print(num)

# Your answer:
# Time:
# Space:


# ============================================================================
# EXERCISE 2: Optimize These Functions
# ============================================================================

def find_pair_with_sum_slow(arr, target):
    """
    Find if any two numbers in arr sum to target.

    Current: O(n²) time, O(1) space

    TODO: Optimize to O(n) time using a hash set
    Hint: For each number, check if (target - number) exists
    """
    n = len(arr)
    for i in range(n):
        for j in range(i + 1, n):
            if arr[i] + arr[j] == target:
                return True
    return False

# Your optimized solution:
def find_pair_with_sum_fast(arr, target):
    """
    TODO: Implement O(n) solution
    """
    pass


def find_duplicates_slow(arr):
    """
    Return list of duplicate elements.

    Current: O(n²) time, O(n) space

    TODO: Optimize to O(n) time using a hash map
    """
    duplicates = []
    n = len(arr)
    for i in range(n):
        for j in range(i + 1, n):
            if arr[i] == arr[j] and arr[i] not in duplicates:
                duplicates.append(arr[i])
    return duplicates

# Your optimized solution:
def find_duplicates_fast(arr):
    """
    TODO: Implement O(n) solution
    Hint: Use a frequency map
    """
    pass


# ============================================================================
# EXERCISE 3: Implement with Given Complexity
# ============================================================================

def is_sorted(arr):
    """
    Check if array is sorted in ascending order.

    Requirements:
    - Time: O(n)
    - Space: O(1)

    TODO: Implement
    """
    pass


def find_missing_number(arr, n):
    """
    Array contains numbers from 1 to n with one missing.
    Find the missing number.

    Example: [1, 2, 4, 5, 6] with n=6 → returns 3

    Requirements:
    - Time: O(n)
    - Space: O(1)

    Hint: Use math - sum of 1 to n is n*(n+1)/2
    TODO: Implement
    """
    pass


def reverse_string(s):
    """
    Reverse a string.

    Requirements:
    - Time: O(n)
    - Space: O(n) - creating new string is acceptable

    TODO: Implement
    """
    pass


def contains_duplicate(arr):
    """
    Return True if any element appears at least twice.

    Requirements:
    - Time: O(n)
    - Space: O(n)

    TODO: Implement using a set
    """
    pass


# ============================================================================
# EXERCISE 4: Space-Time Tradeoffs
# ============================================================================

def first_recurring_character_v1(s):
    """
    Find first character that repeats.
    Example: "abccba" → "c"

    Implement with O(n²) time, O(1) space
    TODO: Implement
    """
    pass


def first_recurring_character_v2(s):
    """
    Find first character that repeats.
    Example: "abccba" → "c"

    Implement with O(n) time, O(n) space
    TODO: Implement using a set
    """
    pass


# ============================================================================
# EXERCISE 5: Analyze Recursive Functions
# ============================================================================

def mystery_function_1(n):
    """
    What does this do?
    What is the time complexity?
    What is the space complexity (consider call stack)?
    """
    if n <= 0:
        return 0
    return n + mystery_function_1(n - 1)

# Your answer:
# Does:
# Time:
# Space:


def mystery_function_2(n):
    """
    What is the time complexity?
    What is the space complexity?
    """
    if n <= 1:
        return 1
    return mystery_function_2(n - 1) + mystery_function_2(n - 1)

# Your answer:
# Time:
# Space:


def mystery_function_3(arr, target, left, right):
    """
    What does this do?
    What is the time complexity?
    What is the space complexity?
    """
    if left > right:
        return -1

    mid = (left + right) // 2

    if arr[mid] == target:
        return mid
    elif arr[mid] < target:
        return mystery_function_3(arr, target, mid + 1, right)
    else:
        return mystery_function_3(arr, target, left, mid - 1)

# Your answer:
# Does:
# Time:
# Space:


# ============================================================================
# EXERCISE 6: Complex Analysis
# ============================================================================

def complex_function(arr1, arr2):
    """
    Analyze the time complexity.
    Consider both inputs separately.
    """
    # Part 1
    for x in arr1:
        print(x)

    # Part 2
    for i in range(len(arr1)):
        for j in range(len(arr2)):
            print(arr1[i], arr2[j])

    # Part 3
    arr2.sort()

# Your answer:
# Time complexity in terms of len(arr1)=a and len(arr2)=b:


def nested_loops(n):
    """
    What is the time complexity?
    """
    count = 0
    for i in range(n):
        for j in range(i, n):
            count += 1
    return count

# Your answer:
# Time:


# ============================================================================
# EXERCISE 7: Implement Efficiently
# ============================================================================

def move_zeros_to_end(arr):
    """
    Move all zeros to the end while maintaining order of non-zero elements.

    Example: [0, 1, 0, 3, 12] → [1, 3, 12, 0, 0]

    Requirements:
    - Time: O(n)
    - Space: O(1) - modify in-place
    - Maintain relative order of non-zero elements

    TODO: Implement
    Hint: Use two pointers
    """
    pass


def find_intersection(arr1, arr2):
    """
    Find common elements between two arrays.

    Example: [1, 2, 3, 4], [3, 4, 5, 6] → [3, 4]

    Requirements:
    - Time: O(n + m) where n and m are array lengths
    - Space: O(min(n, m))

    TODO: Implement using a set
    """
    pass


def is_anagram(s1, s2):
    """
    Check if two strings are anagrams.

    Example: "listen", "silent" → True

    Requirements:
    - Time: O(n)
    - Space: O(1) - assuming fixed character set (26 letters)

    TODO: Implement
    Hint: Use frequency counting or sorting
    """
    pass


# ============================================================================
# TESTING YOUR SOLUTIONS
# ============================================================================

if __name__ == "__main__":
    # Test your implementations here
    print("Test your solutions by running this file!")
    print("Compare with solutions.py when done.")

    # Example test
    test_arr = [1, 2, 3, 4, 5]
    # print(is_sorted(test_arr))  # Should return True
