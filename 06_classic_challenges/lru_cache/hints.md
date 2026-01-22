# LRU Cache - Progressive Hints

Try to solve the problem before reading each hint. Only reveal the next hint when stuck.

---

## Hint 1: Data Structure Requirements

Think about what operations you need:
- Fast lookup by key (get)
- Fast insertion (put)
- Fast removal of least recently used item
- Fast updates to "recency" order

What data structure gives O(1) lookup?
What data structure gives O(1) insertion/deletion at both ends?

---

## Hint 2: Combining Data Structures

You need TWO data structures working together:

1. **Hash Map**: For O(1) key lookups
   - Maps: key → node

2. **Doubly Linked List**: For O(1) ordering operations
   - Head = Most recently used
   - Tail = Least recently used

The hash map stores pointers to nodes in the linked list.

---

## Hint 3: Doubly Linked List Structure

Why doubly linked (not singly)?
- Need to remove from middle in O(1)
- To remove a node, need to update previous node's next pointer
- To update previous node, need prev pointer

```
       prev ← Node → next
```

---

## Hint 4: Operations Flow

### Get(key):
1. If key not in map → return -1
2. If key in map:
   - Get node from map
   - Move node to front (most recent)
   - Return node's value

### Put(key, value):
1. If key exists:
   - Update value
   - Move to front
2. If key doesn't exist:
   - Create new node
   - Add to front
   - Add to map
   - If over capacity: remove from tail

---

## Hint 5: Moving to Front

Every access should move the item to the front (most recent):

```python
def move_to_front(node):
    # Remove node from current position
    remove_node(node)
    # Add to front
    add_to_front(node)
```

Separate these into helper methods for cleaner code.

---

## Hint 6: Helper Methods

You'll want these private methods:

```python
def _remove_node(node):
    """Remove node from its current position"""
    # Update prev and next pointers
    pass

def _add_to_front(node):
    """Add node right after head (most recent)"""
    # Update head and node pointers
    pass

def _evict_lru(self):
    """Remove least recently used (node before tail)"""
    # Remove from tail
    # Remove from map
    pass
```

---

## Hint 7: Dummy Head and Tail

Use dummy head and tail nodes to avoid edge case checks:

```
Dummy Head ↔ [actual nodes] ↔ Dummy Tail
```

Benefits:
- No special case for empty list
- No special case for single element
- Always have head.next and tail.prev

---

## Hint 8: Complete Structure

```python
class Node:
    def __init__(self, key, value):
        self.key = key
        self.value = value
        self.prev = None
        self.next = None

class LRUCache:
    def __init__(self, capacity):
        self.capacity = capacity
        self.cache = {}  # key -> node
        self.head = Node(0, 0)  # dummy
        self.tail = Node(0, 0)  # dummy
        self.head.next = self.tail
        self.tail.prev = self.head
```

---

## Hint 9: Get Implementation Outline

```python
def get(self, key):
    if key not in self.cache:
        return -1

    node = self.cache[key]
    # Move to front (most recent)
    self._remove_node(node)
    self._add_to_front(node)
    return node.value
```

---

## Hint 10: Put Implementation Outline

```python
def put(self, key, value):
    if key in self.cache:
        # Update existing
        node = self.cache[key]
        node.value = value
        self._remove_node(node)
        self._add_to_front(node)
    else:
        # Add new
        node = Node(key, value)
        self.cache[key] = node
        self._add_to_front(node)

        if len(self.cache) > self.capacity:
            # Evict LRU
            lru = self.tail.prev
            self._remove_node(lru)
            del self.cache[lru.key]
```

---

## Still Stuck?

If you've read all hints and still can't implement it, check `solution.py` for the complete, working implementation with detailed comments.

Remember: This is a hard problem. It's okay to look at the solution and then re-implement from scratch to truly understand it.
