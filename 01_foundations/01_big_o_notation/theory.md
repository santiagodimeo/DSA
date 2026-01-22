# Big O Notation

## What is Big O?

Big O notation describes the **worst-case** performance of an algorithm as the input size grows. It helps us:
- Compare different algorithms
- Predict how code will scale
- Make optimization decisions

## Why It Matters

Understanding complexity is crucial for:
- Writing efficient code
- Passing technical interviews
- Making informed architectural decisions
- Avoiding performance bottlenecks

## Common Time Complexities

From fastest to slowest:

### O(1) - Constant Time
**Performance**: Same time regardless of input size

```
Examples:
- Array access by index
- Hash table lookup
- Push/Pop from stack
```

### O(log n) - Logarithmic Time
**Performance**: Doubles input, adds one operation

```
Examples:
- Binary search on sorted array
- Balanced binary search tree operations
- Finding element in heap
```

### O(n) - Linear Time
**Performance**: Time grows directly with input

```
Examples:
- Single loop through array
- Linear search
- Finding min/max in unsorted array
```

### O(n log n) - Linearithmic Time
**Performance**: Efficient sorting algorithms

```
Examples:
- Merge sort
- Quick sort (average case)
- Heap sort
```

### O(n²) - Quadratic Time
**Performance**: Nested loops over input

```
Examples:
- Bubble sort
- Selection sort
- Checking all pairs in array
```

### O(2ⁿ) - Exponential Time
**Performance**: Doubles with each additional input

```
Examples:
- Recursive fibonacci (naive)
- Generating all subsets
- Solving traveling salesman (brute force)
```

### O(n!) - Factorial Time
**Performance**: Extremely slow, avoid if possible

```
Examples:
- Generating all permutations
- Solving traveling salesman (all routes)
```

## Visual Comparison

```
Operations for different input sizes:

n=10          n=100         n=1000
O(1)      1             1             1
O(log n)  3             7             10
O(n)      10            100           1,000
O(n log n)30            700           10,000
O(n²)     100           10,000        1,000,000
O(2ⁿ)     1,024         1.3×10³⁰      infinity (practically)
```

## Space Complexity

Space complexity measures memory usage:

### O(1) - Constant Space
```python
def sum_array(arr):
    total = 0  # Only one variable
    for num in arr:
        total += num
    return total
```

### O(n) - Linear Space
```python
def copy_array(arr):
    new_arr = []  # Creates new array of size n
    for num in arr:
        new_arr.append(num)
    return new_arr
```

### O(n²) - Quadratic Space
```python
def create_matrix(n):
    matrix = []  # n×n matrix
    for i in range(n):
        matrix.append([0] * n)
    return matrix
```

## Rules for Calculating Big O

### 1. Drop Constants
```python
# O(2n) → O(n)
for i in range(n):
    print(i)
for i in range(n):
    print(i)
```

### 2. Drop Non-Dominant Terms
```python
# O(n² + n) → O(n²)
for i in range(n):
    for j in range(n):
        print(i, j)  # O(n²)
for i in range(n):
    print(i)  # O(n)
```

### 3. Different Inputs = Different Variables
```python
# O(a + b), NOT O(n)
def process(arr1, arr2):
    for x in arr1:  # O(a)
        print(x)
    for y in arr2:  # O(b)
        print(y)
```

### 4. Nested Loops = Multiply
```python
# O(a × b)
for i in arr1:
    for j in arr2:
        print(i, j)
```

## Best, Average, Worst Case

### Quick Sort Example:
- **Best Case**: O(n log n) - Pivot divides evenly
- **Average Case**: O(n log n) - Random pivots
- **Worst Case**: O(n²) - Already sorted, bad pivot

**Big O always refers to WORST CASE** unless specified otherwise.

## Common Patterns to Recognize

### Single Loop → O(n)
```python
for i in range(n):
    # constant work
```

### Nested Loops → O(n²)
```python
for i in range(n):
    for j in range(n):
        # constant work
```

### Halving Input → O(log n)
```python
while n > 1:
    n = n // 2
```

### Recursion with Multiple Branches → O(2ⁿ)
```python
def fibonacci(n):
    if n <= 1:
        return n
    return fibonacci(n-1) + fibonacci(n-2)
```

## Interview Tips

1. **Always analyze complexity** when presenting a solution
2. **Start with brute force**, then optimize
3. **Explain trade-offs** between time and space
4. **Use correct notation**: "O(n)" not "Big O of n"
5. **Consider both** time and space complexity

## Common Optimizations

| From | To | Technique |
|------|-----|-----------|
| O(n²) | O(n) | Hash map for lookups |
| O(n) | O(log n) | Binary search (if sorted) |
| O(2ⁿ) | O(n) | Dynamic programming |
| O(n²) space | O(n) space | In-place algorithm |

## Quick Reference

**When you see:**
- Single loop: O(n)
- Nested loops: O(n²)
- Dividing in half: O(log n)
- Sorting: O(n log n)
- Hash map lookup: O(1)
- Recursion tree: Count branches and depth

## Practice Strategy

1. Look at code, identify loops and recursion
2. Count how many times operations execute
3. Express in terms of input size
4. Simplify using Big O rules
5. Verify with different input sizes

## Next Steps

- Review `demonstrations.py` for code examples
- Practice analyzing complexity in `exercises.py`
- Move to Arrays once comfortable with Big O analysis
