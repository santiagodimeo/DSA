# Stacks and Queues

## What Are Stacks and Queues?

**Stacks** and **Queues** are abstract data types that define how elements are added and removed.

### Stack: LIFO (Last In, First Out)
Like a stack of plates - you add and remove from the top.

```
Push 1, 2, 3:        Pop:
                     
    3  ←top           2  ←top
    2                 1
    1                
```

### Queue: FIFO (First In, First Out)
Like a line at a store - first person in is first served.

```
Enqueue 1, 2, 3:     Dequeue:
                     
[1  2  3]            [2  3]
 ↑     ↑              ↑   ↑
front rear          front rear
```

## Why They Matter

**Common uses:**
- **Stacks**: Function calls, undo/redo, browser history, expression evaluation
- **Queues**: Task scheduling, BFS, printer queues, message queues

**Interview frequency**: Very high - appear in 30%+ of problems

## Stack Operations

| Operation | Description | Time |
|-----------|-------------|------|
| push(x) | Add element to top | O(1) |
| pop() | Remove top element | O(1) |
| peek()/top() | View top element | O(1) |
| isEmpty() | Check if empty | O(1) |
| size() | Get number of elements | O(1) |

## Queue Operations

| Operation | Description | Time |
|-----------|-------------|------|
| enqueue(x) | Add element to rear | O(1) |
| dequeue() | Remove front element | O(1) |
| front()/peek() | View front element | O(1) |
| isEmpty() | Check if empty | O(1) |
| size() | Get number of elements | O(1) |

## Python Implementation

### Stack Using List

```python
# Python list as stack
stack = []

# Push
stack.append(1)      # [1]
stack.append(2)      # [1, 2]
stack.append(3)      # [1, 2, 3]

# Pop
top = stack.pop()    # 3, stack = [1, 2]

# Peek
top = stack[-1]      # 2

# Check empty
is_empty = len(stack) == 0

# Size
size = len(stack)
```

### Queue Using deque

```python
from collections import deque

# Create queue
queue = deque()

# Enqueue (add to rear)
queue.append(1)      # [1]
queue.append(2)      # [1, 2]
queue.append(3)      # [1, 2, 3]

# Dequeue (remove from front)
front = queue.popleft()  # 1, queue = [2, 3]

# Peek
front = queue[0]     # 2

# Check empty
is_empty = len(queue) == 0

# Size
size = len(queue)
```

## Implementation Options

### Stack

1. **List (array)** - Most common
   - Push/Pop: O(1)
   - Space: O(n)

2. **Linked List**
   - Push/Pop at head: O(1)
   - More memory per element

### Queue

1. **deque (double-ended queue)** - Best choice
   - Enqueue/Dequeue: O(1)
   - Implemented as doubly-linked list

2. **List** - Avoid!
   - Dequeue: O(n) - must shift all elements
   - Only use if queue is small

3. **Circular Array**
   - Fixed size, wrap around
   - All operations: O(1)

## Common Patterns

### Pattern 1: Matching Pairs (Stack)

**Used for:**
- Balanced parentheses
- Valid HTML/XML tags
- Bracket matching

```python
def is_valid_parentheses(s):
    """
    Check if parentheses are balanced.
    Example: "({[]})" → True
    Example: "([)]" → False
    """
    stack = []
    pairs = {'(': ')', '{': '}', '[': ']'}
    
    for char in s:
        if char in pairs:  # Opening bracket
            stack.append(char)
        else:  # Closing bracket
            if not stack or pairs[stack.pop()] != char:
                return False
    
    return len(stack) == 0
```

### Pattern 2: Monotonic Stack

**Used for:**
- Next greater element
- Stock span problem
- Largest rectangle in histogram

```python
def next_greater_element(arr):
    """
    For each element, find next greater element to the right.
    Example: [4, 5, 2, 10] → [5, 10, 10, -1]
    """
    result = [-1] * len(arr)
    stack = []  # Stores indices
    
    for i in range(len(arr)):
        while stack and arr[stack[-1]] < arr[i]:
            idx = stack.pop()
            result[idx] = arr[i]
        stack.append(i)
    
    return result
```

### Pattern 3: Level-Order Traversal (Queue)

**Used for:**
- BFS (Breadth-First Search)
- Tree level-order traversal
- Shortest path in unweighted graph

```python
def level_order_traversal(root):
    """
    Print tree nodes level by level.
    """
    if not root:
        return []
    
    queue = deque([root])
    result = []
    
    while queue:
        level_size = len(queue)
        level = []
        
        for i in range(level_size):
            node = queue.popleft()
            level.append(node.val)
            
            if node.left:
                queue.append(node.left)
            if node.right:
                queue.append(node.right)
        
        result.append(level)
    
    return result
```

### Pattern 4: Sliding Window Maximum (Deque)

**Used for:**
- Sliding window problems
- Maintaining max/min in window

```python
def max_sliding_window(nums, k):
    """
    Find maximum in each window of size k.
    Example: [1,3,-1,-3,5,3,6,7], k=3 → [3,3,5,5,6,7]
    """
    from collections import deque
    
    result = []
    dq = deque()  # Stores indices
    
    for i in range(len(nums)):
        # Remove elements outside window
        if dq and dq[0] < i - k + 1:
            dq.popleft()
        
        # Remove smaller elements (not useful)
        while dq and nums[dq[-1]] < nums[i]:
            dq.pop()
        
        dq.append(i)
        
        if i >= k - 1:
            result.append(nums[dq[0]])
    
    return result
```

## Stack Applications

### 1. Function Call Stack
```python
def factorial(n):
    if n == 0:
        return 1
    return n * factorial(n - 1)

# Call stack:
# factorial(3)
#   factorial(2)
#     factorial(1)
#       factorial(0) → return 1
#     return 1 * 1
#   return 2 * 1
# return 3 * 2
```

### 2. Expression Evaluation
```python
# Infix: 2 + 3 * 4
# Postfix: 2 3 4 * +
# Use stack to evaluate postfix

def eval_postfix(expr):
    """Evaluate postfix expression."""
    stack = []
    for token in expr.split():
        if token.isdigit():
            stack.append(int(token))
        else:
            b = stack.pop()
            a = stack.pop()
            if token == '+':
                stack.append(a + b)
            elif token == '*':
                stack.append(a * b)
    return stack.pop()
```

### 3. Undo/Redo
```python
undo_stack = []  # Store previous states
redo_stack = []  # Store undone actions

def do_action(state):
    undo_stack.append(current_state)
    current_state = state

def undo():
    if undo_stack:
        redo_stack.append(current_state)
        current_state = undo_stack.pop()

def redo():
    if redo_stack:
        undo_stack.append(current_state)
        current_state = redo_stack.pop()
```

## Queue Applications

### 1. BFS (Shortest Path)
```python
def shortest_path_bfs(graph, start, end):
    """Find shortest path in unweighted graph."""
    queue = deque([(start, 0)])  # (node, distance)
    visited = {start}
    
    while queue:
        node, dist = queue.popleft()
        
        if node == end:
            return dist
        
        for neighbor in graph[node]:
            if neighbor not in visited:
                visited.add(neighbor)
                queue.append((neighbor, dist + 1))
    
    return -1  # No path found
```

### 2. Task Scheduling
```python
task_queue = deque()

# Producer adds tasks
task_queue.append(task1)
task_queue.append(task2)

# Consumer processes tasks
while task_queue:
    task = task_queue.popleft()
    process(task)
```

### 3. Circular Queue (Buffer)
```python
class CircularQueue:
    """Fixed-size queue with wrap-around."""
    def __init__(self, size):
        self.queue = [None] * size
        self.size = size
        self.front = self.rear = -1
    
    def enqueue(self, item):
        if (self.rear + 1) % self.size == self.front:
            return False  # Full
        if self.front == -1:
            self.front = 0
        self.rear = (self.rear + 1) % self.size
        self.queue[self.rear] = item
        return True
    
    def dequeue(self):
        if self.front == -1:
            return None  # Empty
        item = self.queue[self.front]
        if self.front == self.rear:
            self.front = self.rear = -1
        else:
            self.front = (self.front + 1) % self.size
        return item
```

## Special Variants

### 1. Min Stack
Stack that supports getMin() in O(1).

```python
class MinStack:
    def __init__(self):
        self.stack = []
        self.min_stack = []  # Track minimums
    
    def push(self, val):
        self.stack.append(val)
        if not self.min_stack or val <= self.min_stack[-1]:
            self.min_stack.append(val)
    
    def pop(self):
        val = self.stack.pop()
        if val == self.min_stack[-1]:
            self.min_stack.pop()
        return val
    
    def getMin(self):
        return self.min_stack[-1]
```

### 2. Deque (Double-Ended Queue)
Can add/remove from both ends.

```python
from collections import deque

dq = deque()
dq.append(1)      # Add to right
dq.appendleft(0)  # Add to left
dq.pop()          # Remove from right
dq.popleft()      # Remove from left
```

### 3. Priority Queue
Elements have priority (use heap).

```python
import heapq

pq = []
heapq.heappush(pq, (priority, item))
priority, item = heapq.heappop(pq)
```

## Common Mistakes

### 1. Using List for Queue
```python
# ❌ Slow - O(n) dequeue
queue = []
queue.append(1)
queue.pop(0)  # Shifts all elements!

# ✅ Fast - O(1) dequeue
from collections import deque
queue = deque()
queue.append(1)
queue.popleft()
```

### 2. Not Checking Empty
```python
# ❌ May crash
top = stack.pop()

# ✅ Check first
if stack:
    top = stack.pop()
```

### 3. Forgetting to Return Value
```python
# ❌ Pop removes but doesn't return in some languages
stack.pop()

# ✅ In Python, pop returns the value
val = stack.pop()
```

## Interview Tips

### When to Use Stack:
- Last-in-first-out order needed
- Matching/balancing problems
- Reversing something
- DFS (Depth-First Search)
- Expression evaluation
- Undo operations

### When to Use Queue:
- First-in-first-out order needed
- BFS (Breadth-First Search)
- Level-order processing
- Task scheduling
- Buffering

### Problem-Solving Approach:
1. **Identify the pattern**: LIFO → Stack, FIFO → Queue
2. **Consider edge cases**: Empty, single element
3. **Track state**: What do you push/enqueue?
4. **Process order**: When do you pop/dequeue?

## Common Interview Problems

**Stack:**
- Valid Parentheses
- Min Stack
- Daily Temperatures
- Largest Rectangle in Histogram
- Evaluate Reverse Polish Notation

**Queue:**
- Implement Queue using Stacks
- Moving Average from Data Stream
- Number of Recent Calls
- Design Circular Queue

**Both:**
- Sliding Window Maximum (Deque)
- LRU Cache (Queue + Hash Map)

## Quick Reference

```python
# Stack (using list)
stack = []
stack.append(x)    # Push
val = stack.pop()  # Pop
top = stack[-1]    # Peek
if not stack:      # Check empty

# Queue (using deque)
from collections import deque
queue = deque()
queue.append(x)        # Enqueue
val = queue.popleft()  # Dequeue
front = queue[0]       # Peek
if not queue:          # Check empty
```

## Next Steps

- Review `demonstrations.py` for working examples
- Practice with `exercises.py`
- Master the monotonic stack pattern
- Learn BFS with queues
- Move to Trees next
