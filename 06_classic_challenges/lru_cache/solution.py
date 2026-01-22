"""
LRU Cache - Complete Solution

This implementation uses:
1. Hash Map for O(1) key lookup
2. Doubly Linked List for O(1) ordering operations

Time Complexity: O(1) for both get and put
Space Complexity: O(capacity)
"""


class Node:
    """
    Doubly linked list node.

    Stores key-value pair and pointers to previous/next nodes.
    We store the key in the node so we can delete from hash map when evicting.
    """
    def __init__(self, key=0, value=0):
        self.key = key
        self.value = value
        self.prev = None
        self.next = None


class LRUCache:
    """
    LRU Cache using Hash Map + Doubly Linked List.

    Structure:
        Dummy Head ↔ [Most Recent] ↔ ... ↔ [Least Recent] ↔ Dummy Tail

    Hash Map:
        {key → Node}

    Operations:
    - get(key): Move accessed node to front (most recent)
    - put(key, value): Add/update and move to front, evict tail if over capacity
    """

    def __init__(self, capacity: int):
        """
        Initialize cache with given capacity.

        Args:
            capacity: Maximum number of items cache can hold
        """
        self.capacity = capacity
        self.cache = {}  # Maps key → node

        # Dummy head and tail eliminate edge cases
        self.head = Node()
        self.tail = Node()
        self.head.next = self.tail
        self.tail.prev = self.head

    def get(self, key: int) -> int:
        """
        Get value by key. Returns -1 if key doesn't exist.

        On access, move item to front (most recently used).

        Time: O(1)
        """
        if key not in self.cache:
            return -1

        # Get node and move to front (most recent)
        node = self.cache[key]
        self._remove_node(node)
        self._add_to_front(node)

        return node.value

    def put(self, key: int, value: int) -> None:
        """
        Insert or update key-value pair.

        If key exists: update value and move to front
        If key doesn't exist: add new node to front
        If over capacity: evict least recently used (tail)

        Time: O(1)
        """
        if key in self.cache:
            # Key exists - update value and move to front
            node = self.cache[key]
            node.value = value
            self._remove_node(node)
            self._add_to_front(node)
        else:
            # Key doesn't exist - create new node
            node = Node(key, value)
            self.cache[key] = node
            self._add_to_front(node)

            # Check capacity and evict if necessary
            if len(self.cache) > self.capacity:
                # Remove least recently used (node before tail)
                lru = self.tail.prev
                self._remove_node(lru)
                del self.cache[lru.key]

    def _remove_node(self, node: Node) -> None:
        """
        Remove node from its current position in linked list.

        Updates previous and next node pointers.

        Time: O(1)
        """
        prev_node = node.prev
        next_node = node.next
        prev_node.next = next_node
        next_node.prev = prev_node

    def _add_to_front(self, node: Node) -> None:
        """
        Add node right after head (most recently used position).

        Time: O(1)
        """
        # Node goes between head and head.next
        next_node = self.head.next

        self.head.next = node
        node.prev = self.head

        node.next = next_node
        next_node.prev = node

    def __repr__(self) -> str:
        """String representation for debugging."""
        items = []
        current = self.head.next
        while current != self.tail:
            items.append(f"{current.key}:{current.value}")
            current = current.next
        return f"LRUCache({self.capacity}): [{' → '.join(items)}]"


# ============================================================================
# ALTERNATIVE IMPLEMENTATION: Using OrderedDict
# ============================================================================

from collections import OrderedDict


class LRUCacheOrderedDict:
    """
    Simpler implementation using Python's OrderedDict.

    OrderedDict maintains insertion order and has move_to_end() method.

    Pros: Cleaner code, less error-prone
    Cons: Less educational, hides the complexity

    Time: O(1) for both operations
    Space: O(capacity)
    """

    def __init__(self, capacity: int):
        self.capacity = capacity
        self.cache = OrderedDict()

    def get(self, key: int) -> int:
        if key not in self.cache:
            return -1

        # Move to end (most recent)
        self.cache.move_to_end(key)
        return self.cache[key]

    def put(self, key: int, value: int) -> None:
        if key in self.cache:
            # Update and move to end
            self.cache.move_to_end(key)

        self.cache[key] = value

        # Evict least recent if over capacity
        if len(self.cache) > self.capacity:
            self.cache.popitem(last=False)  # Remove first item


# ============================================================================
# TESTING
# ============================================================================

def test_lru_cache():
    """Test basic LRU cache operations."""
    print("Testing LRU Cache Implementation\n")

    # Test Case 1: Basic operations
    print("Test 1: Basic operations")
    cache = LRUCache(2)

    cache.put(1, 1)
    print(f"After put(1,1): {cache}")

    cache.put(2, 2)
    print(f"After put(2,2): {cache}")

    result = cache.get(1)
    print(f"get(1) = {result} (expected 1)")
    print(f"After get(1): {cache}")

    cache.put(3, 3)  # Evicts key 2
    print(f"After put(3,3): {cache}")

    result = cache.get(2)
    print(f"get(2) = {result} (expected -1)")

    cache.put(4, 4)  # Evicts key 1
    print(f"After put(4,4): {cache}")

    result = cache.get(1)
    print(f"get(1) = {result} (expected -1)")

    result = cache.get(3)
    print(f"get(3) = {result} (expected 3)")

    result = cache.get(4)
    print(f"get(4) = {result} (expected 4)")

    print("\n" + "="*50 + "\n")

    # Test Case 2: Update existing key
    print("Test 2: Update existing key")
    cache = LRUCache(2)

    cache.put(1, 1)
    cache.put(2, 2)
    print(f"Initial: {cache}")

    cache.put(1, 10)  # Update value, move to front
    print(f"After put(1,10): {cache}")

    cache.put(3, 3)  # Should evict 2, not 1
    print(f"After put(3,3): {cache}")

    result = cache.get(2)
    print(f"get(2) = {result} (expected -1)")

    result = cache.get(1)
    print(f"get(1) = {result} (expected 10)")

    print("\n" + "="*50 + "\n")

    # Test Case 3: Capacity = 1
    print("Test 3: Capacity = 1")
    cache = LRUCache(1)

    cache.put(2, 1)
    print(f"After put(2,1): {cache}")

    result = cache.get(2)
    print(f"get(2) = {result} (expected 1)")

    cache.put(3, 2)
    print(f"After put(3,2): {cache}")

    result = cache.get(2)
    print(f"get(2) = {result} (expected -1)")

    result = cache.get(3)
    print(f"get(3) = {result} (expected 2)")

    print("\n" + "="*50 + "\n")

    # Test OrderedDict version
    print("Test 4: OrderedDict version")
    cache = LRUCacheOrderedDict(2)

    cache.put(1, 1)
    cache.put(2, 2)
    result = cache.get(1)
    print(f"get(1) = {result} (expected 1)")

    cache.put(3, 3)
    result = cache.get(2)
    print(f"get(2) = {result} (expected -1)")

    print("\nAll tests completed!")


if __name__ == "__main__":
    test_lru_cache()


# ============================================================================
# KEY INSIGHTS
# ============================================================================

"""
1. Combining Data Structures:
   - Hash Map alone: Can't maintain order
   - Linked List alone: Can't do O(1) lookup
   - Together: Get benefits of both

2. Why Doubly Linked?
   - Need to remove from middle in O(1)
   - Requires updating previous node's pointer
   - Need prev pointer for this

3. Dummy Nodes:
   - Eliminate special cases (empty list, single element)
   - Make code cleaner and less error-prone

4. Why Store Key in Node?
   - When evicting, need to remove from hash map
   - Node only knows its value, not its key
   - Store key in node to delete from map

5. Common Mistakes:
   - Forgetting to move to front on get()
   - Not updating value on duplicate put()
   - Off-by-one errors with capacity
   - Circular reference bugs in linked list

6. Interview Tips:
   - Start by explaining the approach
   - Draw the data structures
   - Code helper methods first
   - Test with capacity=1 edge case
"""
