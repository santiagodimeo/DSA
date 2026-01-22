# LRU Cache

## Problem Statement

Design a data structure that follows the constraints of a **Least Recently Used (LRU) cache**.

Implement the `LRUCache` class:

- `LRUCache(int capacity)` Initialize the LRU cache with positive size capacity.
- `int get(int key)` Return the value of the key if the key exists, otherwise return -1.
- `void put(int key, int value)` Update the value of the key if the key exists. Otherwise, add the key-value pair to the cache. If the number of keys exceeds the capacity from this operation, evict the least recently used key.

**The functions `get` and `put` must each run in O(1) average time complexity.**

## Examples

### Example 1:
```python
cache = LRUCache(2)  # capacity = 2

cache.put(1, 1)  # cache is {1=1}
cache.put(2, 2)  # cache is {1=1, 2=2}
cache.get(1)     # return 1, cache is {2=2, 1=1} (1 is now most recent)
cache.put(3, 3)  # evicts key 2, cache is {1=1, 3=3}
cache.get(2)     # returns -1 (not found)
cache.put(4, 4)  # evicts key 1, cache is {3=3, 4=4}
cache.get(1)     # return -1 (not found)
cache.get(3)     # return 3
cache.get(4)     # return 4
```

### Example 2:
```python
cache = LRUCache(1)  # capacity = 1

cache.put(2, 1)  # cache is {2=1}
cache.get(2)     # return 1
cache.put(3, 2)  # evicts key 2, cache is {3=2}
cache.get(2)     # return -1 (not found)
cache.get(3)     # return 2
```

## Constraints

- 1 ≤ capacity ≤ 3000
- 0 ≤ key ≤ 10^4
- 0 ≤ value ≤ 10^5
- At most 2 × 10^5 calls will be made to get and put

## Requirements

- Both `get` and `put` must run in O(1) time
- Space complexity: O(capacity)

## What is LRU?

**Least Recently Used (LRU)** is a cache eviction policy:
- When the cache is full and a new item needs to be added, remove the item that was least recently accessed
- Every access (get or put) makes that item the most recently used
- Items are ranked by recency of access

## Visual Example

```
Initial state (capacity = 3):
Empty

After put(1, "A"):
[1] → Least recent
Most recent

After put(2, "B"):
[1] → [2]
Least recent → Most recent

After put(3, "C"):
[1] → [2] → [3]

After get(1):  # 1 becomes most recent
[2] → [3] → [1]

After put(4, "D"):  # Cache full, evict 2 (least recent)
[3] → [1] → [4]
```

## Why is This Hard?

To achieve O(1) for both operations, you need:

1. **O(1) access** to any key → Hash Map
2. **O(1) updates** to order → Doubly Linked List
3. **O(1) removal** from middle → Doubly Linked List with hash map of pointers

The challenge is combining these data structures correctly.

## Related Real-World Uses

LRU caches are used in:
- CPU caches (L1, L2, L3)
- Database query caches
- Web browser caches
- Operating system page replacement
- CDN edge caching
- API rate limiting

## Difficulty

**Hard** - Requires combining multiple data structures

## Topics

- Hash Map
- Doubly Linked List
- Design
- Cache

## Hints Available

See `hints.md` for progressive hints if you get stuck.

## Next Steps

1. Try implementing on your own first
2. Use `hints.md` if stuck
3. Check `solution.py` for complete implementation
4. Run `test_lru_cache.py` to verify

## Similar Problems

- LFU Cache (Least Frequently Used)
- Design Browser History
- Time-based Key-Value Store
- Design HashSet
- Design HashMap
