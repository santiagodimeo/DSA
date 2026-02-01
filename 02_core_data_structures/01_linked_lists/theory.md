# Linked Lists

## What is a Linked List?

A linked list is a linear data structure where elements are stored in **nodes**. Each node contains:
1. **Data** - the value
2. **Next pointer** - reference to the next node

Unlike arrays, linked list elements are **not stored contiguously** in memory.

```
Array:     [1][2][3][4][5]  ← Continuous memory
           
Linked List:  [1]→[2]→[3]→[4]→[5]→None  ← Scattered in memory
              ↑                    ↑
            head                  tail
```

## Why Linked Lists Matter

**Advantages over arrays:**
- ✅ Dynamic size (no fixed capacity)
- ✅ Efficient insertion/deletion at beginning: O(1)
- ✅ No memory waste from pre-allocation

**Disadvantages:**
- ❌ No random access (must traverse from head)
- ❌ Extra memory for pointers
- ❌ Not cache-friendly (scattered in memory)

**Interview frequency**: Very high - fundamental data structure

## Types of Linked Lists

### 1. Singly Linked List
Each node points to the next node only.

```
[data|next] → [data|next] → [data|next] → None
```

### 2. Doubly Linked List
Each node points to both next and previous nodes.

```
None ← [prev|data|next] ⇄ [prev|data|next] ⇄ [prev|data|next] → None
```

### 3. Circular Linked List
Last node points back to the first node.

```
[data|next] → [data|next] → [data|next] ⤴
  ↑                                     |
  └─────────────────────────────────────┘
```

## Node Structure

```python
class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val      # Data
        self.next = next    # Pointer to next node
```

## Basic Operations

### Time Complexity

| Operation | Array | Linked List |
|-----------|-------|-------------|
| Access by index | O(1) | O(n) |
| Search | O(n) | O(n) |
| Insert at beginning | O(n) | O(1) |
| Insert at end | O(1) | O(n) without tail, O(1) with tail |
| Insert at position | O(n) | O(n) |
| Delete at beginning | O(n) | O(1) |
| Delete at end | O(1) | O(n) |
| Delete at position | O(n) | O(n) |

## Creating a Linked List

### Method 1: Manual Creation
```python
# Create nodes
node1 = ListNode(1)
node2 = ListNode(2)
node3 = ListNode(3)

# Link them
node1.next = node2
node2.next = node3

head = node1  # [1] → [2] → [3] → None
```

### Method 2: From Array
```python
def create_linked_list(arr):
    if not arr:
        return None
    
    head = ListNode(arr[0])
    current = head
    
    for i in range(1, len(arr)):
        current.next = ListNode(arr[i])
        current = current.next
    
    return head
```

## Traversal

```python
def print_list(head):
    """
    Time: O(n) - visit each node once
    Space: O(1) - only pointer variable
    """
    current = head
    while current:
        print(current.val, end=" → ")
        current = current.next
    print("None")
```

## Common Patterns

### Pattern 1: Two Pointers (Fast & Slow)

**Used for:**
- Finding middle of list
- Detecting cycles
- Finding nth node from end

```python
def find_middle(head):
    """
    Slow moves 1 step, fast moves 2 steps.
    When fast reaches end, slow is at middle.
    """
    slow = fast = head
    
    while fast and fast.next:
        slow = slow.next
        fast = fast.next.next
    
    return slow
```

### Pattern 2: Dummy Node

**Used for:**
- Simplifying edge cases (empty list, single node)
- Operations at the head

```python
def remove_elements(head, val):
    """
    Dummy node eliminates special case for head removal.
    """
    dummy = ListNode(0)
    dummy.next = head
    
    current = dummy
    while current.next:
        if current.next.val == val:
            current.next = current.next.next
        else:
            current = current.next
    
    return dummy.next
```

### Pattern 3: Reversal

**Used for:**
- Reverse entire list
- Reverse in groups
- Palindrome checking

```python
def reverse_list(head):
    """
    Time: O(n)
    Space: O(1)
    """
    prev = None
    current = head
    
    while current:
        next_temp = current.next  # Save next
        current.next = prev       # Reverse pointer
        prev = current            # Move prev forward
        current = next_temp       # Move current forward
    
    return prev
```

### Pattern 4: Runner Technique

**Used for:**
- Reordering lists
- Splitting lists
- Weaving lists

```python
def has_cycle(head):
    """
    Floyd's cycle detection (tortoise and hare).
    If there's a cycle, fast will eventually meet slow.
    """
    slow = fast = head
    
    while fast and fast.next:
        slow = slow.next
        fast = fast.next.next
        
        if slow == fast:
            return True
    
    return False
```

## Common Operations

### 1. Insert at Beginning
```python
def insert_at_beginning(head, val):
    """Time: O(1)"""
    new_node = ListNode(val)
    new_node.next = head
    return new_node
```

### 2. Insert at End
```python
def insert_at_end(head, val):
    """Time: O(n) - must traverse to end"""
    new_node = ListNode(val)
    
    if not head:
        return new_node
    
    current = head
    while current.next:
        current = current.next
    
    current.next = new_node
    return head
```

### 3. Delete Node
```python
def delete_node(head, val):
    """Time: O(n)"""
    dummy = ListNode(0)
    dummy.next = head
    
    current = dummy
    while current.next:
        if current.next.val == val:
            current.next = current.next.next
            break
        current = current.next
    
    return dummy.next
```

### 4. Find Length
```python
def get_length(head):
    """Time: O(n)"""
    count = 0
    current = head
    while current:
        count += 1
        current = current.next
    return count
```

## Edge Cases to Consider

1. **Empty list**: `head = None`
2. **Single node**: `head.next = None`
3. **Two nodes**: Minimum for some operations
4. **Operations at head**: Requires special handling or dummy node
5. **Cycles**: May cause infinite loops

## Common Mistakes

### 1. Losing Head Reference
```python
# ❌ Wrong - loses head!
current = head
while current.next:
    current = current.next
return current  # Returns last node, not head

# ✅ Correct - keep head
current = head
while current.next:
    current = current.next
return head
```

### 2. Not Saving Next Pointer
```python
# ❌ Wrong - loses rest of list!
current.next = new_node

# ✅ Correct - save reference
temp = current.next
current.next = new_node
new_node.next = temp
```

### 3. Null Pointer Errors
```python
# ❌ Wrong - may crash if current is None
while current.next:
    current = current.next.next  # If current.next is None, crashes!

# ✅ Correct - check both
while current and current.next:
    current = current.next.next
```

## Interview Tips

### Visualization
Always draw the list on paper/whiteboard:
```
Before: [1] → [2] → [3] → None
              ↑
           delete

After:  [1] → [3] → None
```

### Common Questions to Ask
1. Can the list be empty?
2. Can there be duplicate values?
3. Is it singly or doubly linked?
4. Should I modify in-place or create new list?
5. Can there be cycles?

### Step-by-Step Approach
1. **Handle edge cases** (empty, single node)
2. **Use dummy node** for operations involving head
3. **Draw diagrams** for pointer manipulation
4. **Test with examples** (empty, single, multiple nodes)
5. **Check for null pointers** before dereferencing

## Linked List vs Array

**Use Linked List when:**
- Frequent insertions/deletions at beginning
- Don't need random access
- Size is unknown or changes frequently
- Memory is fragmented

**Use Array when:**
- Need random access by index
- Mostly reading data
- Size is known or stable
- Want cache-friendly performance

## Common Interview Problems

**Easy:**
- Reverse Linked List
- Merge Two Sorted Lists
- Remove Duplicates from Sorted List
- Linked List Cycle
- Middle of the Linked List

**Medium:**
- Add Two Numbers
- Remove Nth Node From End
- Reorder List
- Sort List
- Copy List with Random Pointer

**Hard:**
- Merge k Sorted Lists
- Reverse Nodes in k-Group
- LRU Cache (uses doubly linked list)

## Advanced Concepts

### Sentinel Nodes (Dummy Nodes)
Simplify logic by eliminating edge cases.

### Floyd's Cycle Detection
Fast/slow pointers to detect and find cycle start.

### Skip List
Probabilistic data structure for fast search (O(log n) average).

## Quick Reference

```python
# Node definition
class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

# Common patterns
dummy = ListNode(0)       # Dummy node
slow = fast = head        # Two pointers
prev = None               # For reversal
current = head            # Traversal

# Common checks
if not head:              # Empty list
if not head.next:         # Single node
while current:            # Traverse all
while current.next:       # Traverse to second-last
```

## Next Steps

- Review `demonstrations.py` for working examples
- Practice with `exercises.py`
- Master the two-pointer technique
- Learn to visualize pointer manipulation
- Move to Stacks & Queues next
