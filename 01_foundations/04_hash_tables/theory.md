# Hash Tables (Hash Maps / Dictionaries)

## What is a Hash Table?

A hash table is a data structure that stores **key-value pairs** and provides **O(1) average-case** lookup, insertion, and deletion.

In Python: `dict` and `set`

## Why Hash Tables Matter

Hash tables are one of the most important data structures in programming:
- **Fast lookups**: Check if element exists in O(1)
- **Frequency counting**: Count occurrences efficiently
- **Caching/Memoization**: Store computed results
- **Indexing**: Map keys to values instantly

**Interview frequency**: Extremely high - appears in 40%+ of coding problems

## How Hash Tables Work

### The Hash Function

A hash function converts a key into an array index:

```
Key → Hash Function → Index → Value

"apple" → hash("apple") → 3 → "red"
"banana" → hash("banana") → 7 → "yellow"
```

**Properties of good hash functions:**
1. **Deterministic**: Same key always produces same hash
2. **Fast**: O(1) computation
3. **Uniform distribution**: Minimizes collisions

### Collision Handling

**Collision**: When two keys hash to the same index

**Common techniques:**

1. **Chaining**: Store multiple items at same index (linked list)
2. **Open Addressing**: Find next available slot

Python's `dict` uses open addressing with sophisticated probing.

## Time Complexity

| Operation | Average | Worst Case |
|-----------|---------|------------|
| Lookup    | O(1)    | O(n)       |
| Insert    | O(1)    | O(n)       |
| Delete    | O(1)    | O(n)       |
| Space     | O(n)    | O(n)       |

**Worst case occurs** when many collisions happen (rare with good hash function)

## Python Implementation

### Dictionary (dict) - Key-Value Pairs

```python
# Creating
hash_map = {}
hash_map = {"apple": 5, "banana": 3}

# Insertion / Update
hash_map["orange"] = 7
hash_map["apple"] = 10  # Update existing

# Lookup
value = hash_map["apple"]  # Raises KeyError if not found
value = hash_map.get("apple")  # Returns None if not found
value = hash_map.get("apple", 0)  # Returns 0 if not found

# Check existence
if "apple" in hash_map:
    print("Found")

# Deletion
del hash_map["apple"]
value = hash_map.pop("banana", None)  # Remove and return

# Iteration
for key in hash_map:
    print(key, hash_map[key])

for key, value in hash_map.items():
    print(key, value)
```

### Set - Unique Elements Only

```python
# Creating
hash_set = set()
hash_set = {1, 2, 3, 4}

# Insertion
hash_set.add(5)

# Check existence
if 3 in hash_set:
    print("Found")

# Deletion
hash_set.remove(3)  # Raises KeyError if not found
hash_set.discard(3)  # Does nothing if not found

# Set operations
set1 = {1, 2, 3}
set2 = {3, 4, 5}

union = set1 | set2         # {1, 2, 3, 4, 5}
intersection = set1 & set2   # {3}
difference = set1 - set2     # {1, 2}
```

## Common Patterns

### Pattern 1: Check if Element Exists

**Problem**: Find if array contains duplicate
**Solution**: Use set to track seen elements

```python
def has_duplicate(arr):
    seen = set()
    for num in arr:
        if num in seen:
            return True
        seen.add(num)
    return False
```

**Complexity**: O(n) time, O(n) space
**Alternative**: O(n²) time, O(1) space with nested loops (too slow)

### Pattern 2: Frequency Counting

**Problem**: Count occurrences of each element
**Solution**: Use dict with counts

```python
def frequency_map(arr):
    freq = {}
    for num in arr:
        freq[num] = freq.get(num, 0) + 1
    return freq
```

**Use cases**: Finding most common element, checking anagrams

### Pattern 3: Two Sum Pattern

**Problem**: Find two numbers that sum to target
**Solution**: Store complements in hash map

```python
def two_sum(arr, target):
    seen = {}
    for i, num in enumerate(arr):
        complement = target - num
        if complement in seen:
            return [seen[complement], i]
        seen[num] = i
    return None
```

**Key insight**: Trade O(n) space for O(n) time (vs O(n²) brute force)

### Pattern 4: Grouping / Bucketing

**Problem**: Group anagrams together
**Solution**: Use sorted string as key

```python
def group_anagrams(words):
    groups = {}
    for word in words:
        key = ''.join(sorted(word))
        if key not in groups:
            groups[key] = []
        groups[key].append(word)
    return list(groups.values())
```

### Pattern 5: Caching / Memoization

**Problem**: Avoid recomputing expensive function calls
**Solution**: Store results in hash map

```python
def fibonacci_memo(n, memo={}):
    if n in memo:
        return memo[n]
    if n <= 1:
        return n
    memo[n] = fibonacci_memo(n-1, memo) + fibonacci_memo(n-2, memo)
    return memo[n]
```

**Optimization**: O(2ⁿ) → O(n)

## When to Use Hash Tables

**Use hash tables when you need:**
- ✅ Fast lookups by key
- ✅ Check if element exists
- ✅ Count frequencies
- ✅ Remove duplicates
- ✅ Group related items
- ✅ Cache results

**Don't use hash tables when:**
- ❌ Need to maintain order (use list or OrderedDict)
- ❌ Need to find min/max quickly (use heap)
- ❌ Need range queries (use sorted array or tree)
- ❌ Keys aren't hashable (use list of tuples)

## Hash Table vs Array

| Feature | Array | Hash Table |
|---------|-------|------------|
| Access by index | O(1) | N/A |
| Access by value | O(n) | O(1) |
| Insertion | O(1) end, O(n) middle | O(1) |
| Search | O(n) unsorted, O(log n) sorted | O(1) |
| Ordered | Yes | No (dict is insertion-ordered in Python 3.7+) |
| Space | O(n) | O(n) with overhead |

## Common Gotchas

### 1. Mutable Keys
```python
# ❌ Lists are not hashable
# hash_map = {[1, 2]: "value"}  # TypeError

# ✅ Use tuples instead
hash_map = {(1, 2): "value"}
```

### 2. Default Values
```python
# ❌ KeyError if key doesn't exist
count = hash_map["key"]

# ✅ Use get() with default
count = hash_map.get("key", 0)
```

### 3. Modifying During Iteration
```python
# ❌ Don't modify dict while iterating
for key in hash_map:
    del hash_map[key]  # RuntimeError

# ✅ Create list of keys first
for key in list(hash_map.keys()):
    del hash_map[key]
```

## Advanced Techniques

### defaultdict
```python
from collections import defaultdict

# Automatically creates default value for missing keys
freq = defaultdict(int)
freq['a'] += 1  # No need to check if key exists

groups = defaultdict(list)
groups['key'].append(value)  # Auto-creates empty list
```

### Counter
```python
from collections import Counter

arr = [1, 2, 2, 3, 3, 3]
freq = Counter(arr)  # {3: 3, 2: 2, 1: 1}

# Get most common
most_common = freq.most_common(2)  # [(3, 3), (2, 2)]
```

## Problem-Solving Framework

When you see a problem that requires:
1. **"Find if exists"** → Use set
2. **"Count occurrences"** → Use dict with counts
3. **"Two sum / pair finding"** → Use dict to store complements
4. **"Group by property"** → Use dict with computed key
5. **"Optimize recursive function"** → Add memoization dict

## Interview Tips

1. **Always consider hash tables** for O(n²) → O(n) optimization
2. **Mention space-time tradeoff**: "Using O(n) space to achieve O(n) time"
3. **Ask about constraints**: Can we use extra space?
4. **Be careful with None**: `hash_map.get(key)` returns None, which is falsy
5. **Remember Python 3.7+**: dicts maintain insertion order

## Practice Problems

**Easy:**
- Contains Duplicate
- Two Sum
- Valid Anagram
- First Unique Character

**Medium:**
- Group Anagrams
- Top K Frequent Elements
- Subarray Sum Equals K
- Longest Substring Without Repeating Characters

**Hard:**
- LRU Cache
- Minimum Window Substring
- Substring with Concatenation of All Words

## Quick Reference

```python
# Dictionary cheat sheet
d = {}
d[key] = value           # Insert/Update
value = d.get(key, 0)    # Safe lookup
if key in d:             # Check exists
del d[key]               # Delete
value = d.pop(key, None) # Delete and return
d.keys()                 # All keys
d.values()               # All values
d.items()                # Key-value pairs

# Set cheat sheet
s = set()
s.add(item)              # Insert
if item in s:            # Check exists
s.remove(item)           # Delete (raises error)
s.discard(item)          # Delete (safe)
len(s)                   # Size
```

## Next Steps

- Review `demonstrations.py` for working examples
- Practice with `exercises.py`
- Focus on recognizing when to use hash tables
- Move to techniques (two pointers, sliding window) next
