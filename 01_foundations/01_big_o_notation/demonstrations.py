"""
Big O Notation - Code Demonstrations

This file demonstrates different time complexities with working examples.
Study each function and its complexity analysis.
"""

# ============================================================================
# O(1) - CONSTANT TIME
# ============================================================================

def get_first_element(arr):
    """
    Access first element of array.

    Time: O(1) - Single operation regardless of array size
    Space: O(1) - No extra space used
    """
    if not arr:
        return None
    return arr[0]


def hash_lookup(dictionary, key):
    """
    Look up value in hash map.

    Time: O(1) - Hash table provides constant-time access
    Space: O(1) - No extra space
    """
    return dictionary.get(key)


# ============================================================================
# O(log n) - LOGARITHMIC TIME
# ============================================================================

def binary_search(arr, target):
    """
    Search for target in sorted array using binary search.

    Time: O(log n) - Halves search space each iteration
    Space: O(1) - Only uses pointers

    Example: Array of 1000 elements takes ~10 comparisons
    """
    left, right = 0, len(arr) - 1

    while left <= right:
        mid = (left + right) // 2

        if arr[mid] == target:
            return mid
        elif arr[mid] < target:
            left = mid + 1
        else:
            right = mid - 1

    return -1


def find_power_of_two(n):
    """
    Find largest power of 2 less than or equal to n.

    Time: O(log n) - Divides by 2 each iteration
    Space: O(1)
    """
    power = 1
    while power * 2 <= n:
        power *= 2
    return power


# ============================================================================
# O(n) - LINEAR TIME
# ============================================================================

def find_max(arr):
    """
    Find maximum element in array.

    Time: O(n) - Must check every element once
    Space: O(1) - Only stores max value
    """
    if not arr:
        return None

    max_val = arr[0]
    for num in arr:
        if num > max_val:
            max_val = num
    return max_val


def count_occurrences(arr, target):
    """
    Count how many times target appears.

    Time: O(n) - Single pass through array
    Space: O(1)
    """
    count = 0
    for num in arr:
        if num == target:
            count += 1
    return count


def reverse_array(arr):
    """
    Reverse array in-place.

    Time: O(n) - Visit each element once
    Space: O(1) - In-place modification
    """
    left, right = 0, len(arr) - 1
    while left < right:
        arr[left], arr[right] = arr[right], arr[left]
        left += 1
        right -= 1
    return arr


# ============================================================================
# O(n log n) - LINEARITHMIC TIME
# ============================================================================

def merge_sort(arr):
    """
    Sort array using merge sort.

    Time: O(n log n) - Divides array (log n) and merges (n) at each level
    Space: O(n) - Requires temporary arrays

    This is optimal for comparison-based sorting.
    """
    if len(arr) <= 1:
        return arr

    # Divide
    mid = len(arr) // 2
    left = merge_sort(arr[:mid])
    right = merge_sort(arr[mid:])

    # Conquer (merge)
    return merge(left, right)


def merge(left, right):
    """Helper function for merge sort."""
    result = []
    i = j = 0

    while i < len(left) and j < len(right):
        if left[i] <= right[j]:
            result.append(left[i])
            i += 1
        else:
            result.append(right[j])
            j += 1

    result.extend(left[i:])
    result.extend(right[j:])
    return result


# ============================================================================
# O(n²) - QUADRATIC TIME
# ============================================================================

def bubble_sort(arr):
    """
    Sort using bubble sort.

    Time: O(n²) - Nested loops, each O(n)
    Space: O(1) - In-place sorting

    Avoid in practice - use O(n log n) algorithms instead.
    """
    n = len(arr)
    for i in range(n):
        for j in range(n - i - 1):
            if arr[j] > arr[j + 1]:
                arr[j], arr[j + 1] = arr[j + 1], arr[j]
    return arr


def find_all_pairs(arr):
    """
    Print all pairs of elements.

    Time: O(n²) - Nested loop over same array
    Space: O(1) - Only stores pair indices
    """
    pairs = []
    for i in range(len(arr)):
        for j in range(i + 1, len(arr)):
            pairs.append((arr[i], arr[j]))
    return pairs


def has_duplicate_brute_force(arr):
    """
    Check if array has duplicates (inefficient way).

    Time: O(n²) - Compare each element with all others
    Space: O(1)

    Better approach: Use hash set for O(n) time
    """
    n = len(arr)
    for i in range(n):
        for j in range(i + 1, n):
            if arr[i] == arr[j]:
                return True
    return False


# ============================================================================
# O(2ⁿ) - EXPONENTIAL TIME
# ============================================================================

def fibonacci_recursive(n):
    """
    Calculate Fibonacci number recursively (naive approach).

    Time: O(2ⁿ) - Each call branches into 2 more calls
    Space: O(n) - Recursion stack depth

    VERY SLOW for n > 30. Use dynamic programming instead.
    """
    if n <= 1:
        return n
    return fibonacci_recursive(n - 1) + fibonacci_recursive(n - 2)


def generate_all_subsets(arr):
    """
    Generate all possible subsets (power set).

    Time: O(2ⁿ) - Each element can be included or excluded
    Space: O(2ⁿ) - Stores all subsets

    For n=3: [1,2,3] → [], [1], [2], [3], [1,2], [1,3], [2,3], [1,2,3]
    """
    result = []

    def backtrack(index, current):
        if index == len(arr):
            result.append(current[:])
            return

        # Exclude current element
        backtrack(index + 1, current)

        # Include current element
        current.append(arr[index])
        backtrack(index + 1, current)
        current.pop()

    backtrack(0, [])
    return result


# ============================================================================
# COMPARING APPROACHES
# ============================================================================

def has_duplicate_optimized(arr):
    """
    Check if array has duplicates (optimized with hash set).

    Time: O(n) - Single pass with O(1) lookups
    Space: O(n) - Hash set stores elements

    Trade space for time: O(n²) → O(n) by using O(n) space
    """
    seen = set()
    for num in arr:
        if num in seen:
            return True
        seen.add(num)
    return False


def fibonacci_optimized(n):
    """
    Calculate Fibonacci with dynamic programming.

    Time: O(n) - Calculate each number once
    Space: O(1) - Only store last two numbers

    Optimization: O(2ⁿ) → O(n) using memoization
    """
    if n <= 1:
        return n

    prev, curr = 0, 1
    for _ in range(2, n + 1):
        prev, curr = curr, prev + curr

    return curr


# ============================================================================
# SPACE COMPLEXITY EXAMPLES
# ============================================================================

def sum_array_constant_space(arr):
    """
    Sum array elements.

    Time: O(n)
    Space: O(1) - Only one variable for sum
    """
    total = 0
    for num in arr:
        total += num
    return total


def create_copy_linear_space(arr):
    """
    Create copy of array.

    Time: O(n)
    Space: O(n) - New array of same size
    """
    return arr[:]


def create_frequency_map(arr):
    """
    Create frequency map of elements.

    Time: O(n)
    Space: O(n) - In worst case, all elements unique
    """
    freq = {}
    for num in arr:
        freq[num] = freq.get(num, 0) + 1
    return freq


# ============================================================================
# TESTING
# ============================================================================

if __name__ == "__main__":
    # Test different complexities
    test_arr = [5, 2, 8, 1, 9, 3, 7, 4, 6]

    print("O(1) - Get first:", get_first_element(test_arr))
    print("O(log n) - Binary search:", binary_search(sorted(test_arr), 7))
    print("O(n) - Find max:", find_max(test_arr))
    print("O(n log n) - Merge sort:", merge_sort(test_arr[:]))
    print("O(n²) - All pairs count:", len(find_all_pairs(test_arr)))
    print("O(2ⁿ) - Subsets of [1,2,3]:", len(generate_all_subsets([1, 2, 3])))

    # Compare optimizations
    print("\nDuplicate check - Brute force O(n²):", has_duplicate_brute_force([1, 2, 3, 4, 5]))
    print("Duplicate check - Optimized O(n):", has_duplicate_optimized([1, 2, 3, 4, 5]))

    print("\nFibonacci(10) - Recursive O(2ⁿ):", fibonacci_recursive(10))
    print("Fibonacci(10) - Optimized O(n):", fibonacci_optimized(10))
