# Arrays

## What is an Array?

An array is a **contiguous block of memory** that stores elements of the same type. It's the most fundamental data structure in programming.

```
Index:  0    1    2    3    4
Array: [10] [20] [30] [40] [50]
Memory: ↓    ↓    ↓    ↓    ↓
       0x00 0x04 0x08 0x0C 0x10
```

## Key Properties

1. **Fixed Size** (in most languages, Python lists are dynamic)
2. **O(1) Random Access** - Can access any element by index instantly
3. **Contiguous Memory** - Elements stored next to each other
4. **Same Type** - All elements same data type

## Time Complexity

| Operation | Time Complexity | Notes |
|-----------|----------------|-------|
| Access by index | O(1) | arr[i] |
| Search | O(n) | Must check each element |
| Insert at end | O(1)* | Python list amortized |
| Insert at beginning | O(n) | Shift all elements |
| Delete from end | O(1) | |
| Delete from middle | O(n) | Shift remaining elements |

## Python Lists vs Arrays

Python lists are **dynamic arrays** - they automatically resize:

```python
arr = []        # Start empty
arr.append(1)   # O(1) amortized - may resize internally
arr.append(2)
arr.append(3)
```

## Common Patterns

### 1. Two Pointers

Use two indices to traverse array efficiently.

**When to use:**
- Sorted array problems
- Palindrome checking
- Pair finding
- In-place modifications

```
Left                    Right
  ↓                       ↓
 [1, 2, 3, 4, 5, 6, 7, 8, 9]
```

### 2. Sliding Window

Maintain a window of elements as you traverse.

**When to use:**
- Subarray problems
- Consecutive elements
- Maximum/minimum in window

```
Window size = 3
    [--Window--]
    ↓  ↓  ↓
   [1, 2, 3, 4, 5, 6]
       [--Window--]
       ↓  ↓  ↓
   [1, 2, 3, 4, 5, 6]
```

### 3. Prefix Sum

Pre-compute cumulative sums for fast range queries.

```
Original:  [1, 2, 3, 4, 5]
Prefix:    [1, 3, 6, 10, 15]

Sum of range [1:3] = prefix[3] - prefix[0] = 9 - 1 = 8
```

### 4. Fast & Slow Pointers

Two pointers moving at different speeds.

**When to use:**
- Finding middle element
- Cycle detection
- Remove duplicates

```
Slow   Fast
  ↓     ↓
 [1, 2, 3, 4, 5, 6, 7, 8]

      Slow      Fast
        ↓        ↓
 [1, 2, 3, 4, 5, 6, 7, 8]
```

## In-Place vs Extra Space

### In-Place (O(1) space)
Modify the original array without using extra data structures.

```python
# Good: O(1) space
def reverse_in_place(arr):
    left, right = 0, len(arr) - 1
    while left < right:
        arr[left], arr[right] = arr[right], arr[left]
        left += 1
        right -= 1
```

### Extra Space (O(n) space)
Create new array for result.

```python
# Uses O(n) space
def reverse_with_new_array(arr):
    return arr[::-1]  # Creates new array
```

## Common Algorithms

### Linear Search - O(n)
```python
def linear_search(arr, target):
    for i, num in enumerate(arr):
        if num == target:
            return i
    return -1
```

### Binary Search - O(log n)
**Requires sorted array**

```python
def binary_search(arr, target):
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
```

## Common Pitfalls

### 1. Off-by-One Errors
```python
# Wrong: misses last element
for i in range(len(arr) - 1):  # Stops at len(arr) - 2

# Correct
for i in range(len(arr)):
```

### 2. Index Out of Bounds
```python
# Dangerous
if arr[i + 1] > arr[i]:  # What if i is last index?

# Safe
if i + 1 < len(arr) and arr[i + 1] > arr[i]:
```

### 3. Modifying While Iterating
```python
# Dangerous: skips elements
for i in range(len(arr)):
    if arr[i] == 0:
        arr.pop(i)  # Changes array size during iteration

# Safe: iterate backwards or use new array
for i in range(len(arr) - 1, -1, -1):
    if arr[i] == 0:
        arr.pop(i)
```

## Interview Tips

1. **Ask about constraints:**
   - Array size?
   - Element range?
   - Can array be empty?
   - Sorted or unsorted?

2. **Start with brute force:**
   - Get working solution first
   - Then optimize

3. **Consider edge cases:**
   - Empty array
   - Single element
   - All same elements
   - All different elements

4. **Time-Space Tradeoff:**
   - Can you use O(n) space to get O(n) time?
   - Is in-place modification required?

## Common Interview Problems

- **Two Sum** - Find pair with given sum
- **Best Time to Buy/Sell Stock** - Max profit from price array
- **Maximum Subarray** - Largest sum of contiguous subarray
- **Product of Array Except Self** - Products without division
- **Merge Sorted Arrays** - Combine two sorted arrays
- **Remove Duplicates** - In-place removal from sorted array
- **Rotate Array** - Shift elements k positions

## Optimization Techniques

### 1. Hash Map for O(1) Lookup
```python
# Slow: O(n²)
def has_pair_sum(arr, target):
    for i in range(len(arr)):
        for j in range(i + 1, len(arr)):
            if arr[i] + arr[j] == target:
                return True
    return False

# Fast: O(n)
def has_pair_sum_optimized(arr, target):
    seen = set()
    for num in arr:
        if target - num in seen:
            return True
        seen.add(num)
    return False
```

### 2. Two Pointers for Sorted Arrays
```python
# After sorting: O(n log n) + O(n) = O(n log n)
def has_pair_sum_sorted(arr, target):
    arr.sort()
    left, right = 0, len(arr) - 1
    while left < right:
        current_sum = arr[left] + arr[right]
        if current_sum == target:
            return True
        elif current_sum < target:
            left += 1
        else:
            right -= 1
    return False
```

## Next Steps

- Review `demonstrations.py` for practical examples
- Practice with `exercises.py`
- Compare your solutions with `solutions.py`
- Move to Strings after mastering arrays
