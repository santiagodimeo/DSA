"""
Stacks and Queues - Exercises

Implement the following stack and queue problems.
Focus on understanding when to use stacks vs queues and pattern recognition.

After attempting, check solutions.py for answers and explanations.
"""

from collections import deque

# ============================================================================
# EXERCISE 1: Implement Stack using list
# ============================================================================


class Stack:
    """
    Implement a Stack (LIFO) using Python list.

    Example: push(1) → push(2) → push(3) → pop() = 3

    Requirements:
    - All operations should be O(1) amortized
    - Track size

    TODO: Implement push, pop, peek, is_empty, size
    Hint: Use list append/pop methods (they're O(1) amortized)
    """

    def __init__(self):
        """Initialize stack."""
        pass

    def push(self, val):
        """
        Add element to top of stack.

        Time: O(1) amortized
        Space: O(1)

        TODO: Implement
        """
        pass

    def pop(self):
        """
        Remove and return top element.

        Returns: Element or None if empty
        Time: O(1)
        Space: O(1)

        TODO: Implement
        """
        pass

    def peek(self):
        """
        View top element without removing.

        Returns: Element or None if empty
        Time: O(1)
        Space: O(1)

        TODO: Implement
        """
        pass

    def is_empty(self):
        """
        Check if stack is empty.

        Time: O(1)
        Space: O(1)

        TODO: Implement
        """
        pass

    def size(self):
        """
        Return number of elements in stack.

        Time: O(1)
        Space: O(1)

        TODO: Implement
        """
        pass


# ============================================================================
# EXERCISE 2: Implement Queue using deque
# ============================================================================


class Queue:
    """
    Implement a Queue (FIFO) using collections.deque.

    Example: enqueue(1) → enqueue(2) → enqueue(3) → dequeue() = 1

    Requirements:
    - All operations should be O(1)
    - Use deque (not list) for efficient O(1) popleft
    - Track size

    TODO: Implement enqueue, dequeue, front, is_empty, size
    Hint: deque.append() is O(1), deque.popleft() is O(1)
    """

    def __init__(self):
        """Initialize queue."""
        pass

    def enqueue(self, val):
        """
        Add element to back of queue.

        Time: O(1)
        Space: O(1)

        TODO: Implement
        """
        pass

    def dequeue(self):
        """
        Remove and return front element.

        Returns: Element or None if empty
        Time: O(1)
        Space: O(1)

        TODO: Implement
        """
        pass

    def front(self):
        """
        View front element without removing.

        Returns: Element or None if empty
        Time: O(1)
        Space: O(1)

        TODO: Implement
        """
        pass

    def is_empty(self):
        """
        Check if queue is empty.

        Time: O(1)
        Space: O(1)

        TODO: Implement
        """
        pass

    def size(self):
        """
        Return number of elements in queue.

        Time: O(1)
        Space: O(1)

        TODO: Implement
        """
        pass


# ============================================================================
# EXERCISE 3: Valid Parentheses
# ============================================================================


def is_valid_parentheses(s):
    """
    Check if string has valid matching parentheses/brackets/braces.

    Example: "()" → True
    Example: "([{}])" → True
    Example: "([)]" → False
    Example: "{[}" → False
    Example: "" → True

    Requirements:
    - Time: O(n)
    - Space: O(n)

    TODO: Use stack to match closing with opening brackets
    Hint: Push opening brackets, pop and verify on closing bracket
    """
    pass


# ============================================================================
# EXERCISE 4: Min Stack
# ============================================================================


class MinStack:
    """
    Design a stack that supports push, pop, top, and retrieving minimum in O(1).

    Example: push(3) → push(1) → push(4) → push(1)
             push(5) → get_min() = 1, pop() → get_min() = 1, pop() → get_min() = 1

    Requirements:
    - Time: O(1) for all operations
    - Space: O(n)

    TODO: Use auxiliary stack to track minimums at each level
    Hint: Synchronize pop operations between main and min stacks
    """

    def __init__(self):
        """Initialize MinStack."""
        pass

    def push(self, val):
        """
        Add value to stack.

        Time: O(1)
        Space: O(1)

        TODO: Implement
        """
        pass

    def pop(self):
        """
        Remove and return top value.

        Time: O(1)
        Space: O(1)

        TODO: Implement
        """
        pass

    def top(self):
        """
        Return top value without removing.

        Time: O(1)
        Space: O(1)

        TODO: Implement
        """
        pass

    def get_min(self):
        """
        Return current minimum value.

        Time: O(1)
        Space: O(1)

        TODO: Implement
        """
        pass


# ============================================================================
# EXERCISE 5: Next Greater Element
# ============================================================================


def next_greater_element(nums):
    """
    Find next greater element for each element in array.

    Example: [1, 5, 0, 3, 4, 5] → [5, -1, 3, 4, 5, -1]
    Explanation: 1→5, 5→-1 (no greater), 0→3, 3→4, 4→5, 5→-1

    Requirements:
    - Time: O(n) - each element pushed/popped once
    - Space: O(n)

    TODO: Use monotonic decreasing stack
    Hint: Process array right to left, pop smaller elements
    """
    pass


# ============================================================================
# EXERCISE 6: Daily Temperatures
# ============================================================================


def daily_temperatures(temperatures):
    """
    Find days until warmer temperature for each day.

    Example: [73,74,75,71,69,72,76,73] → [1,1,4,2,1,1,0,0]
    Explanation: 73→74 (1 day), 74→75 (1 day), 75→76 (4 days), etc.

    Requirements:
    - Time: O(n)
    - Space: O(n)

    TODO: Use monotonic stack of indices
    Hint: For warmer day, calculate difference with indices in stack
    """
    pass


# ============================================================================
# EXERCISE 7: Evaluate Reverse Polish Notation
# ============================================================================


def eval_rpn(tokens):
    """
    Evaluate expression in Reverse Polish Notation.

    Reverse Polish Notation (RPN) is where operators come after operands.
    Example: "3 4 +" means 3 + 4 = 7

    Example: ["2","1","+","3","*"] → 9 (means (2+1)*3)
    Example: ["4","13","5","/","+"] → 6 (means 4 + 13/5)
    Example: ["10","6","9","3","+","-11","*","/","*","17","+","5","+"] → 22

    Requirements:
    - Time: O(n)
    - Space: O(n)

    TODO: Use stack for operands
    Hint: Push operands, pop two operands when seeing operator
    Note: Integer division in Python can behave differently for negative numbers
    """
    pass


# ============================================================================
# EXERCISE 8: Implement Queue using Stacks
# ============================================================================


class QueueUsingStacks:
    """
    Implement a Queue using two Stacks.

    Example: push(1) → push(2) → push(3) → pop() = 1

    Requirements:
    - Time: O(1) amortized for pop, O(1) for push
    - Space: O(n)

    TODO: Use two stacks (in_stack, out_stack)
    Hint: Use in_stack for push, transfer to out_stack for pop
    """

    def __init__(self):
        """Initialize queue with two stacks."""
        pass

    def push(self, x):
        """
        Add element to queue.

        Time: O(1)

        TODO: Implement
        """
        pass

    def pop(self):
        """
        Remove and return front element.

        Returns: Element
        Time: O(1) amortized

        TODO: Implement
        """
        pass

    def peek(self):
        """
        View front element without removing.

        Returns: Element
        Time: O(1) amortized

        TODO: Implement
        """
        pass

    def empty(self):
        """
        Check if queue is empty.

        Returns: Boolean
        Time: O(1)

        TODO: Implement
        """
        pass


# ============================================================================
# EXERCISE 9: Implement Stack using Queues
# ============================================================================


class StackUsingQueues:
    """
    Implement a Stack using one or two Queues.

    Example: push(1) → push(2) → push(3) → pop() = 3

    Requirements:
    - Time: O(1) for push, O(n) for pop (or vice versa)
    - Space: O(n)

    TODO: Use one or two queues (choose approach)
    Hint: Option 1: One queue - rotate on pop
          Option 2: Two queues - one for storage, one for temp
    """

    def __init__(self):
        """Initialize stack with queue(s)."""
        pass

    def push(self, x):
        """
        Add element to stack.

        Time: O(1) or O(n) depending on approach

        TODO: Implement
        """
        pass

    def pop(self):
        """
        Remove and return top element.

        Returns: Element
        Time: O(n) or O(1) depending on approach

        TODO: Implement
        """
        pass

    def top(self):
        """
        View top element without removing.

        Returns: Element
        Time: O(1)

        TODO: Implement
        """
        pass

    def empty(self):
        """
        Check if stack is empty.

        Returns: Boolean
        Time: O(1)

        TODO: Implement
        """
        pass


# ============================================================================
# EXERCISE 10: Sliding Window Maximum
# ============================================================================


def sliding_window_maximum(nums, k):
    """
    Find maximum in every sliding window of size k.

    Example: nums=[1,3,1,2,0,5], k=3 → [3,3,2,5]
    Windows: [1,3,1]→3, [3,1,2]→3, [1,2,0]→2, [2,0,5]→5

    Requirements:
    - Time: O(n)
    - Space: O(k)

    TODO: Use deque to store indices in decreasing order
    Hint: Remove indices outside window, maintain monotonic decreasing
    """
    pass


# ============================================================================
# EXERCISE 11: BFS Level Order Traversal
# ============================================================================


class TreeNode:
    """Binary tree node for BFS."""

    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right


def level_order_traversal(root):
    """
    Traverse binary tree level by level (BFS).

    Example: Tree:    1
                     / \
                    2   3
             Output: [[1], [2, 3]]

    Example: Tree:    3
                     / \
                    9  20
                      /  \
                     15   7
             Output: [[3], [9, 20], [15, 7]]

    Requirements:
    - Time: O(n)
    - Space: O(w) where w is max width

    TODO: Use queue to process levels
    Hint: Track level_size, process level_size nodes, enqueue children
    """
    pass


# ============================================================================
# EXERCISE 12: Number of Recent Calls
# ============================================================================


class RecentCounter:
    """
    Design a system to count recent requests within time window.

    You have a function that accepts a request at time t.
    Return the number of requests in last 3000 ms.

    Example:
    ping(1) → 1 (request at t=1)
    ping(100) → 2 (requests at t=1,100)
    ping(3001) → 3 (requests at t=1,100,3001, but 1 is 3000ms ago, counts)
    ping(3002) → 2 (requests at t=100,3001,3002; t=1 is outside window)

    Requirements:
    - Time: O(n) where n is requests in window (usually small)
    - Space: O(n)

    TODO: Use deque to store recent request times
    Hint: Remove requests older than t - 3000
    """

    def __init__(self):
        """Initialize counter."""
        pass

    def ping(self, t):
        """
        Record request at time t.

        Returns: Number of requests in last 3000 ms
        Time: O(n) amortized
        Space: O(n)

        TODO: Implement
        """
        pass


# ============================================================================
# EXERCISE 13: Trapping Rain Water
# ============================================================================


def trap_rain_water(height):
    """
    Calculate water trapped after raining on elevation map.

    Example: [0,1,0,2,1,0,1,3,2,1,2,1] → 6
    Visualization:
       |
     | |
     | | |
     |_|_|_|_|_|_

    Requirements:
    - Time: O(n)
    - Space: O(n)

    TODO: Use monotonic decreasing stack of indices
    Hint: When height increases, calculate water trapped between bars
    """
    pass


# ============================================================================
# EXERCISE 14: Largest Rectangle in Histogram
# ============================================================================


def largest_rectangle_in_histogram(heights):
    """
    Find largest rectangle area in histogram.

    Example: [2,1,5,6,2,3] → 10
    Explanation: Rectangle with height 5 and width 2 (indices 2-3)

    Example: [2,4] → 4
    Example: [1] → 1

    Requirements:
    - Time: O(n)
    - Space: O(n)

    TODO: Use monotonic increasing stack of indices
    Hint: For decreasing height, pop and calculate area
    """
    pass


# ============================================================================
# EXERCISE 15: Asteroid Collision
# ============================================================================


def asteroid_collision(asteroids):
    """
    Simulate asteroids colliding in a line.

    Each asteroid size represented by integer.
    Positive → moving right, Negative → moving left.
    Collision occurs when right-moving hits left-moving.
    Larger destroys smaller. Equal size both destroyed.

    Example: [5,10,-5] → [5,10]
    Explanation: -5 hits 10, 10 wins and continues right

    Example: [8,-8] → []
    Explanation: They collide and destroy each other

    Example: [10,2,-5] → [10]
    Explanation: 2→right, -5→left, they collide, 2 destroys
                 10→right, 2→left (was moving right), no collision

    Requirements:
    - Time: O(n)
    - Space: O(n)

    TODO: Use stack to handle collisions
    Hint: Push positive, process negative to handle collisions
    """
    pass


# ============================================================================
# EXERCISE 16: Word Ladder II
# ============================================================================


def find_ladders(beginWord, endWord, wordList):
    """
    Find all shortest transformation sequences from beginWord to endWord.

    A transformation is changing one letter at a time.
    All intermediate words must exist in wordList.

    Example:
    beginWord = "hit"
    endWord = "cog"
    wordList = ["hot","dot","dog","lot","log","cog"]

    Output: [["hit","hot","dot","dog","cog"],
             ["hit","hot","lot","log","cog"]]

    Requirements:
    - Time: O(n * l^2) where n is word count, l is word length
    - Space: O(n * l)

    TODO: Use BFS to find shortest paths, then backtrack
    Hint: First find shortest distances using BFS, then DFS to build paths
    This is an advanced problem!
    """
    pass


# ============================================================================
# EXERCISE 17: LRU Cache Design
# ============================================================================


class LRUCache:
    """
    Design and implement an LRU (Least Recently Used) Cache.

    - Capacity is fixed
    - get(key): Return value if key exists, else return -1, mark as recently used
    - put(key, value): Update value if key exists, add if not
    - When capacity exceeded, evict least recently used item

    Example:
    LRUCache(2)  # capacity 2
    put(1, 1)
    put(2, 2)
    get(1)  → 1
    put(3, 3)  # evicts 2
    get(2)  → -1 (not found)
    put(4, 4)  # evicts 1
    get(1)  → -1 (not found)
    get(3)  → 3
    get(4)  → 4

    Requirements:
    - Time: O(1) for get and put
    - Space: O(capacity)

    TODO: Use hash map + doubly linked list
    Hint: Hash map for O(1) access, doubly linked list for O(1) removal/reordering
    This is a challenging design problem!
    """

    def __init__(self, capacity):
        """
        Initialize cache with given capacity.

        Time: O(1)
        Space: O(capacity)

        TODO: Implement
        """
        pass

    def get(self, key):
        """
        Get value and mark as recently used.

        Returns: Value or -1
        Time: O(1)
        Space: O(1)

        TODO: Implement
        """
        pass

    def put(self, key, value):
        """
        Update value or add new key-value pair.

        Time: O(1)
        Space: O(1)

        TODO: Implement
        """
        pass


# ============================================================================
# HELPER FUNCTIONS (provided for testing)
# ============================================================================


def create_binary_tree(values):
    """
    Create binary tree from level-order array.
    None represents null nodes.

    Example: [1, 2, 3] creates tree:
        1
       / \
      2   3
    """
    if not values or values[0] is None:
        return None

    root = TreeNode(values[0])
    queue = deque([root])
    i = 1

    while queue and i < len(values):
        node = queue.popleft()

        if i < len(values) and values[i] is not None:
            node.left = TreeNode(values[i])
            queue.append(node.left)

        i += 1

        if i < len(values) and values[i] is not None:
            node.right = TreeNode(values[i])
            queue.append(node.right)

        i += 1

    return root


def print_tree_levels(root):
    """Print tree as levels."""
    if not root:
        return []
    return level_order_traversal(root)


def print_stack(stack):
    """Print stack from bottom to top."""
    print(
        "Stack:",
        stack.items if hasattr(stack, "items") else "[implementation specific]",
    )


def print_queue(queue):
    """Print queue from front to back."""
    print(
        "Queue:",
        list(queue.items) if hasattr(queue, "items") else "[implementation specific]",
    )


# ============================================================================
# TESTING YOUR SOLUTIONS
# ============================================================================

if __name__ == "__main__":
    print("Test your solutions!")
    print("Run: python3 exercises.py")
    print("Compare with solutions.py when done.\n")

    # Example test - Stack
    print("=== Test Stack ===")
    # stack = Stack()
    # stack.push(1)
    # stack.push(2)
    # stack.push(3)
    # print(f"Stack size: {stack.size()}")  # Should be 3
    # print(f"Peek: {stack.peek()}")  # Should be 3
    # print(f"Pop: {stack.pop()}")  # Should be 3
    # print(f"Pop: {stack.pop()}")  # Should be 2

    # Example test - Queue
    print("\n=== Test Queue ===")
    # queue = Queue()
    # queue.enqueue(1)
    # queue.enqueue(2)
    # queue.enqueue(3)
    # print(f"Queue size: {queue.size()}")  # Should be 3
    # print(f"Front: {queue.front()}")  # Should be 1
    # print(f"Dequeue: {queue.dequeue()}")  # Should be 1
    # print(f"Dequeue: {queue.dequeue()}")  # Should be 2

    # Example test - Valid Parentheses
    print("\n=== Test Valid Parentheses ===")
    test_cases = [
        ("()", True),
        ("([{}])", True),
        ("([)]", False),
        ("{[}", False),
        ("", True),
    ]
    # for s, expected in test_cases:
    #     result = is_valid_parentheses(s)
    #     status = "✓" if result == expected else "✗"
    #     print(f"{status} '{s}' → {result}")

    # Example test - Min Stack
    print("\n=== Test Min Stack ===")
    # min_stack = MinStack()
    # min_stack.push(3)
    # min_stack.push(1)
    # min_stack.push(4)
    # min_stack.push(1)
    # print(f"Min: {min_stack.get_min()}")  # Should be 1
    # min_stack.pop()
    # print(f"Min: {min_stack.get_min()}")  # Should be 1
    # min_stack.pop()
    # print(f"Min: {min_stack.get_min()}")  # Should be 1
    # min_stack.pop()
    # print(f"Min: {min_stack.get_min()}")  # Should be 3

    # Example test - Next Greater Element
    print("\n=== Test Next Greater Element ===")
    # nums = [1, 5, 0, 3, 4, 5]
    # result = next_greater_element(nums)
    # print(f"Input: {nums}")
    # print(f"Output: {result}")  # Should be [5, -1, 3, 4, 5, -1]

    # Example test - Daily Temperatures
    print("\n=== Test Daily Temperatures ===")
    # temps = [73, 74, 75, 71, 69, 72, 76, 73]
    # result = daily_temperatures(temps)
    # print(f"Input: {temps}")
    # print(f"Output: {result}")  # Should be [1, 1, 4, 2, 1, 1, 0, 0]

    # Example test - Evaluate RPN
    print("\n=== Test Evaluate RPN ===")
    # tokens = ["2", "1", "+", "3", "*"]
    # result = eval_rpn(tokens)
    # print(f"Input: {tokens}")
    # print(f"Output: {result}")  # Should be 9

    # Example test - Sliding Window Maximum
    print("\n=== Test Sliding Window Maximum ===")
    # nums = [1, 3, 1, 2, 0, 5]
    # k = 3
    # result = sliding_window_maximum(nums, k)
    # print(f"Input: {nums}, k={k}")
    # print(f"Output: {result}")  # Should be [3, 3, 2, 5]

    # Example test - Level Order Traversal
    print("\n=== Test Level Order Traversal ===")
    # root = create_binary_tree([3, 9, 20, None, None, 15, 7])
    # result = level_order_traversal(root)
    # print(f"Output: {result}")  # Should be [[3], [9, 20], [15, 7]]

    # Example test - Recent Counter
    print("\n=== Test Recent Counter ===")
    # counter = RecentCounter()
    # pings = [1, 100, 3001, 3002]
    # for ping in pings:
    #     result = counter.ping(ping)
    #     print(f"ping({ping}) → {result}")

    print("\n" + "=" * 70)
    print("TESTING COMPLETED")
    print("=" * 70)
