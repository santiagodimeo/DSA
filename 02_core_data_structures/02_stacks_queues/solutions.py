"""
Stacks and Queues - Solutions

Complete solutions with explanations for all exercises.
Study the approach and complexity analysis for each problem.
"""

from collections import deque

# ============================================================================
# EXERCISE 1: Implement Stack using list
# ============================================================================


class Stack:
    """
    Implement a Stack (LIFO) using Python list.

    Example: push(1) → push(2) → push(3) → pop() = 3

    Approach:
    - Use Python list with append/pop for O(1) amortized operations
    - append() adds to end (top of stack)
    - pop() removes from end (top of stack)
    - Both are O(1) amortized

    Time: O(1) amortized for all operations
    Space: O(n) for n elements in stack
    """

    def __init__(self):
        """Initialize stack."""
        self.items = []

    def push(self, val):
        """
        Add element to top of stack.

        Time: O(1) amortized
        Space: O(1)
        """
        self.items.append(val)

    def pop(self):
        """
        Remove and return top element.

        Returns: Element or None if empty
        Time: O(1)
        Space: O(1)
        """
        return self.items.pop() if not self.is_empty() else None

    def peek(self):
        """
        View top element without removing.

        Returns: Element or None if empty
        Time: O(1)
        Space: O(1)
        """
        return self.items[-1] if not self.is_empty() else None

    def is_empty(self):
        """
        Check if stack is empty.

        Time: O(1)
        Space: O(1)
        """
        return len(self.items) == 0

    def size(self):
        """
        Return number of elements in stack.

        Time: O(1)
        Space: O(1)
        """
        return len(self.items)


# ============================================================================
# EXERCISE 2: Implement Queue using deque
# ============================================================================


class Queue:
    """
    Implement a Queue (FIFO) using collections.deque.

    Example: enqueue(1) → enqueue(2) → enqueue(3) → dequeue() = 1

    Approach:
    - Use deque for O(1) operations at both ends
    - append() adds to back (rear of queue)
    - popleft() removes from front of queue
    - deque is optimal for queue operations (unlike list)

    Time: O(1) for all operations
    Space: O(n) for n elements in queue
    """

    def __init__(self):
        """Initialize queue."""
        self.items = deque()

    def enqueue(self, val):
        """
        Add element to back of queue.

        Time: O(1)
        Space: O(1)
        """
        self.items.append(val)

    def dequeue(self):
        """
        Remove and return front element.

        Returns: Element or None if empty
        Time: O(1)
        Space: O(1)
        """
        return self.items.popleft() if not self.is_empty() else None

    def front(self):
        """
        View front element without removing.

        Returns: Element or None if empty
        Time: O(1)
        Space: O(1)
        """
        return self.items[0] if not self.is_empty() else None

    def is_empty(self):
        """
        Check if queue is empty.

        Time: O(1)
        Space: O(1)
        """
        return len(self.items) == 0

    def size(self):
        """
        Return number of elements in queue.

        Time: O(1)
        Space: O(1)
        """
        return len(self.items)


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

    Approach:
    - Use stack to match closing with opening brackets
    - Push opening brackets onto stack
    - For closing brackets, check top of stack matches
    - Stack must be empty at end

    Key Insight:
    - Each closing bracket must match most recent unmatched opening bracket
    - This is the definition of stack (LIFO) behavior

    Time: O(n) - visit each character once
    Space: O(n) - stack stores opening brackets
    """
    stack = []
    pairs = {"(": ")", "[": "]", "{": "}"}

    for char in s:
        if char in pairs:  # Opening bracket
            stack.append(char)
        else:  # Closing bracket
            if not stack or pairs[stack.pop()] != char:
                return False

    return len(stack) == 0


# ============================================================================
# EXERCISE 4: Min Stack
# ============================================================================


class MinStack:
    """
    Design a stack that supports push, pop, top, and retrieving minimum in O(1).

    Example: push(3) → push(1) → push(4) → push(1)
             push(5) → get_min() = 1, pop() → get_min() = 1

    Approach:
    - Use auxiliary stack to track minimum at each level
    - Main stack: stores all values
    - Min stack: stores minimum value at each level
    - When pushing: push value to main, push min(value, top of min stack)
    - When popping: pop from both stacks

    Key Insight:
    - Can't just store single min value - need to track history
    - After pop, need previous minimum for remaining elements

    Time: O(1) for all operations
    Space: O(n) - both stacks can have n elements
    """

    def __init__(self):
        """Initialize MinStack."""
        self.stack = []
        self.min_stack = []

    def push(self, val):
        """
        Add value to stack.

        Time: O(1)
        Space: O(1)
        """
        self.stack.append(val)
        if not self.min_stack:
            self.min_stack.append(val)
        else:
            self.min_stack.append(min(val, self.min_stack[-1]))

    def pop(self):
        """
        Remove and return top value.

        Time: O(1)
        Space: O(1)
        """
        if self.stack:
            self.min_stack.pop()
            return self.stack.pop()
        return None

    def top(self):
        """
        Return top value without removing.

        Time: O(1)
        Space: O(1)
        """
        return self.stack[-1] if self.stack else None

    def get_min(self):
        """
        Return current minimum value.

        Time: O(1)
        Space: O(1)
        """
        return self.min_stack[-1] if self.min_stack else None


# ============================================================================
# EXERCISE 5: Next Greater Element
# ============================================================================


def next_greater_element(nums):
    """
    Find next greater element for each element in array.

    Example: [1, 5, 0, 3, 4, 5] → [5, -1, 3, 4, 5, -1]
    Explanation: 1→5, 5→-1 (no greater), 0→3, 3→4, 4→5, 5→-1

    Approach:
    - Use monotonic decreasing stack (stores indices)
    - Process array right to left
    - For each element:
      - Pop all smaller elements from stack
      - Top of stack (if exists) is next greater element
      - Push current element

    Example trace for [1, 5, 0, 3, 4, 5]:
    - Start right: 5, stack=[5]
    - 4: 4<5, pop nothing, answer[4]=5, stack=[5,4]
    - 3: 3<4, pop 4, 3<5, pop nothing, answer[3]=4, stack=[5,3]
    - 0: 0<3, pop 3, 0<5, pop nothing, answer[0]=5, stack=[5,0]
    - 5: 5>0, pop 0, 5=5, pop 5, stack empty, answer[1]=-1, stack=[5]

    Key Insight:
    - Decreasing stack maintains candidates for "next greater"
    - Processing right to left ensures we see larger elements first

    Time: O(n) - each element pushed and popped once
    Space: O(n) - stack storage
    """
    result = [-1] * len(nums)
    stack = []

    # Process right to left
    for i in range(len(nums) - 1, -1, -1):
        # Pop smaller elements
        while stack and stack[-1] <= nums[i]:
            stack.pop()

        # Top of stack is next greater (if exists)
        if stack:
            result[i] = stack[-1]

        # Push current element
        stack.append(nums[i])

    return result


# ============================================================================
# EXERCISE 6: Daily Temperatures
# ============================================================================


def daily_temperatures(temperatures):
    """
    Find days until warmer temperature for each day.

    Example: [73,74,75,71,69,72,76,73] → [1,1,4,2,1,1,0,0]
    Explanation: 73→74 (1 day), 74→75 (1 day), 75→76 (4 days), etc.

    Approach:
    - Use monotonic decreasing stack of indices
    - Process array right to left
    - For each day:
      - Pop indices of days with lower/equal temperatures
      - Remaining top index is first warmer day
      - Calculate difference

    Example trace for [73,74,75,71,69,72,76,73]:
    - i=7 (73): stack empty, answer[7]=0, stack=[7]
    - i=6 (76): 76>73, pop 7, stack empty, answer[6]=0, stack=[6]
    - i=5 (72): 72<76, answer[5]=1, stack=[6,5]
    - i=4 (69): 69<72, answer[4]=1, stack=[6,5,4]
    - i=3 (71): 71>69, pop 4, 71<72, answer[3]=2, stack=[6,5,3]
    - i=2 (75): 75>71, pop 3, 75>72, pop 5, 75<76, answer[2]=4, stack=[6,2]
    - i=1 (74): 74<75, answer[1]=1, stack=[6,2,1]
    - i=0 (73): 73<74, answer[0]=1, stack=[6,2,1,0]

    Key Insight:
    - Stack maintains indices in decreasing temperature order
    - When we find warmer day, difference = current_index - stack_top

    Time: O(n) - each index pushed and popped once
    Space: O(n) - stack storage
    """
    result = [0] * len(temperatures)
    stack = []

    for i in range(len(temperatures) - 1, -1, -1):
        # Pop days with lower or equal temperature
        while stack and temperatures[stack[-1]] <= temperatures[i]:
            stack.pop()

        # Top is first warmer day
        if stack:
            result[i] = stack[-1] - i

        stack.append(i)

    return result


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

    Approach:
    - Use stack for operands
    - Scan tokens left to right:
      - If number: push to stack
      - If operator: pop two operands, apply, push result
    - Final result is only element in stack

    Example trace for ["2","1","+","3","*"]:
    - "2": push 2, stack=[2]
    - "1": push 1, stack=[2,1]
    - "+": pop 1,2; 2+1=3; push 3, stack=[3]
    - "3": push 3, stack=[3,3]
    - "*": pop 3,3; 3*3=9; push 9, stack=[9]
    - Result: 9

    Key Insight:
    - RPN order matches stack evaluation perfectly
    - Operators immediately follow their operands

    Note:
    - Python // for integer division truncates toward negative infinity
    - For negative division: -13 // 5 = -3, but we want -2
    - Use int(a/b) for truncation toward zero

    Time: O(n) - process each token once
    Space: O(n) - stack stores operands
    """
    stack = []

    for token in tokens:
        if token in "+-*/":
            # Pop two operands (note: order matters for - and /)
            b = stack.pop()
            a = stack.pop()

            if token == "+":
                stack.append(a + b)
            elif token == "-":
                stack.append(a - b)
            elif token == "*":
                stack.append(a * b)
            else:  # token == "/"
                # Truncate toward zero (not toward negative infinity)
                stack.append(int(a / b))
        else:
            stack.append(int(token))

    return stack[0]


# ============================================================================
# EXERCISE 8: Implement Queue using Stacks
# ============================================================================


class QueueUsingStacks:
    """
    Implement a Queue using two Stacks.

    Example: push(1) → push(2) → push(3) → pop() = 1

    Approach:
    - in_stack: stores newly added elements
    - out_stack: stores elements in queue order
    - push(x): always add to in_stack
    - pop(): if out_stack empty, transfer all from in_stack, then pop from out_stack

    Example trace for push(1,2,3) → pop():
    - push(1): in_stack=[1], out_stack=[]
    - push(2): in_stack=[1,2], out_stack=[]
    - push(3): in_stack=[1,2,3], out_stack=[]
    - pop(): transfer in_stack→out_stack, out_stack=[3,2,1], pop=1

    Key Insight:
    - Transfer from in_stack reverses order, giving us FIFO
    - Amortized O(1): each element transferred once per pop
    - pop() can be O(n) worst case, but amortized O(1)

    Time:
    - push: O(1)
    - pop/peek: O(1) amortized (transfer is O(n) but happens infrequently)
    Space: O(n)
    """

    def __init__(self):
        """Initialize queue with two stacks."""
        self.in_stack = []
        self.out_stack = []

    def push(self, x):
        """
        Add element to queue.

        Time: O(1)
        """
        self.in_stack.append(x)

    def _transfer(self):
        """Helper: transfer from in_stack to out_stack when out_stack empty."""
        if not self.out_stack:
            while self.in_stack:
                self.out_stack.append(self.in_stack.pop())

    def pop(self):
        """
        Remove and return front element.

        Returns: Element
        Time: O(1) amortized
        """
        self._transfer()
        return self.out_stack.pop()

    def peek(self):
        """
        View front element without removing.

        Returns: Element
        Time: O(1) amortized
        """
        self._transfer()
        return self.out_stack[-1]

    def empty(self):
        """
        Check if queue is empty.

        Returns: Boolean
        Time: O(1)
        """
        return not self.in_stack and not self.out_stack


# ============================================================================
# EXERCISE 9: Implement Stack using Queues
# ============================================================================


class StackUsingQueues:
    """
    Implement a Stack using one Queue.

    Example: push(1) → push(2) → push(3) → pop() = 3

    Approach (using one queue):
    - Store all elements in single queue
    - push(x): add element, then rotate (size-1) times to move it to front
    - pop(): simply dequeue (front element is most recent)

    Example trace for push(1,2,3) → pop():
    - push(1): enqueue 1, rotate 0 times, queue=[1]
    - push(2): enqueue 2, queue=[1,2], rotate 1 time, queue=[2,1]
    - push(3): enqueue 3, queue=[2,1,3], rotate 2 times, queue=[3,2,1]
    - pop(): dequeue 3, queue=[2,1]

    Rotation mechanism:
    - Rotate operation: dequeue then enqueue (n times)
    - After rotation, newest element is at front

    Key Insight:
    - push() is expensive: O(n) due to rotation
    - pop() is efficient: O(1)
    - Could do opposite (push O(1), pop O(n))

    Time:
    - push: O(n) due to rotation
    - pop: O(1)
    Space: O(n)
    """

    def __init__(self):
        """Initialize stack with queue."""
        self.queue = deque()

    def push(self, x):
        """
        Add element to stack.

        Time: O(n)
        """
        self.queue.append(x)
        # Rotate to move new element to front
        for _ in range(len(self.queue) - 1):
            self.queue.append(self.queue.popleft())

    def pop(self):
        """
        Remove and return top element.

        Returns: Element
        Time: O(1)
        """
        return self.queue.popleft()

    def top(self):
        """
        View top element without removing.

        Returns: Element
        Time: O(1)
        """
        return self.queue[0]

    def empty(self):
        """
        Check if stack is empty.

        Returns: Boolean
        Time: O(1)
        """
        return len(self.queue) == 0


# ============================================================================
# EXERCISE 10: Sliding Window Maximum
# ============================================================================


def sliding_window_maximum(nums, k):
    """
    Find maximum in every sliding window of size k.

    Example: nums=[1,3,1,2,0,5], k=3 → [3,3,2,5]
    Windows: [1,3,1]→3, [3,1,2]→3, [1,2,0]→2, [2,0,5]→5

    Approach:
    - Use deque to store indices in decreasing value order
    - Maintain monotonic decreasing deque
    - For each element:
      - Remove indices outside current window
      - Remove indices of smaller elements (they can't be max)
      - Current max is front of deque
      - Add current index

    Example trace for [1,3,1,2,0,5], k=3:
    - i=0 (1): deque=[0]
    - i=1 (3): 3>1, remove 0, deque=[1]
    - i=2 (1): 1<3, deque=[1,2], max=3
    - i=3 (2): 2>1, remove 2, 2<3, deque=[1,3], max=3
    - i=4 (0): 0<2, deque=[1,3,4], max=2
    - i=5 (5): 5>0, remove 4, 5>2, remove 3, 5>3, remove 1, deque=[5], max=5

    Key Insight:
    - Deque stores indices, not values (need to check values)
    - Front always has max in current window
    - Only add necessary indices (ignore smaller ones)

    Time: O(n) - each index added and removed once
    Space: O(k) - deque stores at most k indices
    """
    if not nums or k == 0:
        return []

    deq = deque()
    result = []

    for i in range(len(nums)):
        # Remove indices outside current window
        while deq and deq[0] < i - k + 1:
            deq.popleft()

        # Remove indices of smaller elements
        while deq and nums[deq[-1]] <= nums[i]:
            deq.pop()

        # Add current index
        deq.append(i)

        # Record max (front of deque)
        if i >= k - 1:
            result.append(nums[deq[0]])

    return result


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

    Approach:
    - Use queue for BFS
    - Track level size (number of nodes at current level)
    - Process all nodes in level, enqueue their children
    - Each iteration of outer loop processes one level

    Key Insight:
    - level_size tells us how many nodes to dequeue before moving to next level
    - Without tracking level_size, hard to separate levels
    - Alternativce: use None markers between levels

    Time: O(n) - visit each node once
    Space: O(w) where w is maximum width (number of nodes at widest level)
    """
    if not root:
        return []

    result = []
    queue = deque([root])

    while queue:
        level_size = len(queue)
        current_level = []

        for _ in range(level_size):
            node = queue.popleft()
            current_level.append(node.val)

            if node.left:
                queue.append(node.left)
            if node.right:
                queue.append(node.right)

        result.append(current_level)

    return result


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

    Approach:
    - Use deque to store recent request times
    - For each ping:
      - Add new request time
      - Remove requests older than t - 3000
      - Return length of deque

    Key Insight:
    - Requests are in chronological order (timestamps increasing)
    - Only remove from front (oldest requests)
    - No need to remove from middle or end

    Time: O(n) amortized where n is requests in window (typically small)
    Space: O(n) where n is requests in window
    """

    def __init__(self):
        """Initialize counter."""
        self.requests = deque()

    def ping(self, t):
        """
        Record request at time t.

        Returns: Number of requests in last 3000 ms
        Time: O(n) amortized
        Space: O(n)
        """
        self.requests.append(t)

        # Remove requests older than t - 3000
        while self.requests and self.requests[0] < t - 3000:
            self.requests.popleft()

        return len(self.requests)


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

    Approach:
    - Use monotonic decreasing stack of indices
    - For each bar:
      - If taller than stack top, water is trapped
      - Pop smaller bar, calculate water above it
      - Water height = min(current bar, left bar) - popped bar
      - Water width = distance between current and left
    - Continue while stack has elements

    Example trace for [0,1,0,2,1,0,1,3,2,1,2,1]:
    - i=0: h[0]=0, stack=[0]
    - i=1: h[1]=1>0, pop 0, stack empty, stack=[1]
    - i=2: h[2]=0<1, stack=[1,2]
    - i=3: h[3]=2>0, pop 2, h[2]=0, left=h[1]=1
              water = min(2,1)-0 = 1, width = 3-1-1 = 1, trapped=1
              h[3]=2>1, pop 1, h[1]=1, left empty, stack=[3]
    - ... continue

    Key Insight:
    - Monotonic decreasing: maintains increasing distances
    - When we see taller bar, we know water level
    - Water height = min(left, right) - current height
    - Stack stores indices, not values (need to check values)

    Time: O(n) - each bar pushed and popped once
    Space: O(n) - stack storage
    """
    if not height:
        return 0

    stack = []
    water = 0

    for i in range(len(height)):
        while stack and height[i] > height[stack[-1]]:
            top = stack.pop()

            if not stack:
                break

            left = stack[-1]
            # Water height = min(left bar, right bar) - middle bar
            h = min(height[left], height[i]) - height[top]
            # Width = distance between left and right bars
            w = i - left - 1
            water += h * w

        stack.append(i)

    return water


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

    Approach:
    - Use monotonic increasing stack of indices
    - For each bar:
      - While stack has taller bars, pop and calculate area
      - Area = height * width
      - Width = distance to current bar (how far this height extends)
    - Process remaining stack at end

    Example trace for [2,1,5,6,2,3]:
    - i=0: h[0]=2, stack=[0]
    - i=1: h[1]=1<2, pop 0, area=2*1=2, max_area=2, stack=[1]
    - i=2: h[2]=5>1, stack=[1,2]
    - i=3: h[3]=6>5, stack=[1,2,3]
    - i=4: h[4]=2<6, pop 3, area=6*1=6
             pop 2, area=5*2=10, max_area=10
             h[4]=2>1, stack=[1,4]
    - i=5: h[5]=3>2, stack=[1,4,5]
    - End: pop 5, area=3*1=3; pop 4, area=2*3=6; pop 1, area=1*5=5

    Key Insight:
    - Monotonic increasing: ensures heights are processed properly
    - When height decreases, taller bars can't extend further
    - Width calculation: from previous element to current position

    Time: O(n) - each bar pushed and popped once
    Space: O(n) - stack storage
    """
    if not heights:
        return 0

    stack = []
    max_area = 0

    for i in range(len(heights)):
        while stack and heights[i] < heights[stack[-1]]:
            h = heights[stack.pop()]
            w = i if not stack else i - stack[-1] - 1
            max_area = max(max_area, h * w)

        stack.append(i)

    # Process remaining bars in stack
    while stack:
        h = heights[stack.pop()]
        w = len(heights) if not stack else len(heights) - stack[-1] - 1
        max_area = max(max_area, h * w)

    return max_area


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

    Approach:
    - Use stack to track asteroids (moving right)
    - For each asteroid:
      - If moving right: push to stack
      - If moving left: check collisions with stack
        - While collision possible (stack not empty, top positive):
          - If top destroys current: break (current destroyed)
          - If current destroys top: pop and continue
          - If equal: pop and break (both destroyed)
        - If no collision, push current

    Example trace for [5,10,-5]:
    - 5: positive, stack=[5]
    - 10: positive, stack=[5,10]
    - -5: negative, collision!
        10 vs 5: 10 > 5, -5 survives
        stack=[5], no more collisions, push -5, stack=[5,-5]
    Result: [5,-5]

    Wait, example says [5,10]? Let me reconsider...
    Actually: 10 vs -5: 10 > 5, -5 destroyed, 10 survives
    Then 10 vs 5: 10 moving right, 5 moving right, no collision
    But 5 is already in stack... Actually we should get [5,10]

    Let me retrace: [5, 10, -5]
    - 5: positive, stack=[5]
    - 10: positive, stack=[5, 10]
    - -5: negative, collision with 10
        10 > 5: -5 destroyed, pop 10? No, 10 wins.
        But we need to pop from stack? 10 is top.
        10 vs -5: |10| > |−5|, 10 wins
        But where does 10 go? It's moving right still.
        So it stays. -5 is destroyed.
        Result: [5, 10]

    I think the logic should be:
    - If negative, collide with rightward asteroids in stack
    - Keep colliding until this asteroid destroyed or no more right asteroids

    Key Insight:
    - Only positive (right-moving) stay in stack
    - Negatives immediately collide with them
    - No negative-to-negative or no collision between same direction

    Time: O(n) - each asteroid pushed and popped once
    Space: O(n) - stack storage
    """
    stack = []

    for asteroid in asteroids:
        alive = True

        while alive and asteroid < 0 and stack and stack[-1] > 0:
            # Collision occurs
            top = stack.pop()

            if abs(top) > abs(asteroid):
                # Right-moving wins, current destroyed
                stack.append(top)
                alive = False
            elif abs(top) == abs(asteroid):
                # Both destroyed
                alive = False

            # If left-moving wins, continue colliding with next

        if alive:
            stack.append(asteroid)

    return stack


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

    Approach:
    1. Build graph: word → neighbors (one letter difference)
    2. BFS from beginWord: find shortest path distance to each word
    3. DFS from beginWord: backtrack using distances to build valid paths

    Key Insight:
    - BFS finds shortest distance to all words
    - DFS only explores paths that decrease distance (greedy)
    - Avoids cycles and guarantees shortest paths

    Time: O(n * l^2) where n is word count, l is word length
         Building graph: O(n * l) comparisons
         Each comparison: O(l) for building neighbors
         BFS: O(n + edges)
         DFS: explores valid paths
    Space: O(n * l) for graph
    """

    def get_neighbors(word, word_set):
        """Get all words one letter different."""
        neighbors = []
        for i in range(len(word)):
            for c in "abcdefghijklmnopqrstuvwxyz":
                if c != word[i]:
                    new_word = word[:i] + c + word[i + 1 :]
                    if new_word in word_set:
                        neighbors.append(new_word)
        return neighbors

    # Build graph
    word_set = set(wordList)
    if endWord not in word_set:
        return []

    # BFS to find shortest distance
    distances = {word: -1 for word in word_set}
    distances[beginWord] = 0

    queue = deque([beginWord])
    while queue:
        word = queue.popleft()
        for neighbor in get_neighbors(word, word_set):
            if distances[neighbor] == -1:
                distances[neighbor] = distances[word] + 1
                queue.append(neighbor)

    # DFS to build paths
    paths = []

    def dfs(word, path):
        if word == endWord:
            paths.append(path[:])
            return

        for neighbor in get_neighbors(word, word_set):
            if distances[neighbor] == distances[word] + 1:
                path.append(neighbor)
                dfs(neighbor, path)
                path.pop()

    if distances[endWord] != -1:
        dfs(beginWord, [beginWord])

    return paths


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
    put(3, 3)  # evicts 2 (least recently used)
    get(2)  → -1 (not found)
    put(4, 4)  # evicts 1
    get(1)  → -1 (not found)
    get(3)  → 3
    get(4)  → 4

    Approach:
    - Hash map: key → node (for O(1) access)
    - Doubly linked list: maintains LRU order
      - Head (sentinel): most recently used (newest)
      - Tail (sentinel): least recently used (oldest)
    - On get/put: move node to head (mark as recently used)
    - On capacity exceeded: remove tail

    Why doubly linked list:
    - Need O(1) removal from middle (when moving to head)
    - Singly linked would be O(n) to find previous node
    - Maintains order without searching

    Key Insight:
    - Hash map gives O(1) access to node
    - Linked list gives O(1) update of order
    - Together: O(1) for get and put

    Time: O(1) for get and put
    Space: O(capacity)
    """

    class Node:
        def __init__(self, key=0, val=0):
            self.key = key
            self.val = val
            self.prev = None
            self.next = None

    def __init__(self, capacity):
        """
        Initialize cache with given capacity.

        Time: O(1)
        Space: O(capacity)
        """
        self.capacity = capacity
        self.cache = {}

        # Sentinels for doubly linked list
        self.head = self.Node()  # Most recently used
        self.tail = self.Node()  # Least recently used
        self.head.next = self.tail
        self.tail.prev = self.head

    def _add_to_head(self, node):
        """Add node right after head (most recently used)."""
        node.prev = self.head
        node.next = self.head.next
        self.head.next.prev = node
        self.head.next = node

    def _remove_node(self, node):
        """Remove node from linked list."""
        node.prev.next = node.next
        node.next.prev = node.prev

    def _move_to_head(self, node):
        """Move node to head (mark as recently used)."""
        self._remove_node(node)
        self._add_to_head(node)

    def get(self, key):
        """
        Get value and mark as recently used.

        Returns: Value or -1
        Time: O(1)
        Space: O(1)
        """
        if key not in self.cache:
            return -1

        node = self.cache[key]
        self._move_to_head(node)
        return node.val

    def put(self, key, value):
        """
        Update value or add new key-value pair.

        Time: O(1)
        Space: O(1)
        """
        if key in self.cache:
            # Update existing
            node = self.cache[key]
            node.val = value
            self._move_to_head(node)
        else:
            # Add new
            node = self.Node(key, value)
            self.cache[key] = node
            self._add_to_head(node)

            # Evict if over capacity
            if len(self.cache) > self.capacity:
                lru_node = self.tail.prev
                self._remove_node(lru_node)
                del self.cache[lru_node.key]


# ============================================================================
# HELPER FUNCTIONS
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


# ============================================================================
# TESTING
# ============================================================================

if __name__ == "__main__":
    print("=" * 70)
    print("STACKS AND QUEUES - SOLUTIONS TEST")
    print("=" * 70)

    # Exercise 1: Stack
    print("\n=== EXERCISE 1: Stack ===")
    stack = Stack()
    stack.push(1)
    stack.push(2)
    stack.push(3)
    print(f"Stack size: {stack.size()}")  # Should be 3
    print(f"Peek: {stack.peek()}")  # Should be 3
    print(f"Pop: {stack.pop()}")  # Should be 3
    print(f"Pop: {stack.pop()}")  # Should be 2
    print(f"Is empty: {stack.is_empty()}")  # Should be False

    # Exercise 2: Queue
    print("\n=== EXERCISE 2: Queue ===")
    queue = Queue()
    queue.enqueue(1)
    queue.enqueue(2)
    queue.enqueue(3)
    print(f"Queue size: {queue.size()}")  # Should be 3
    print(f"Front: {queue.front()}")  # Should be 1
    print(f"Dequeue: {queue.dequeue()}")  # Should be 1
    print(f"Dequeue: {queue.dequeue()}")  # Should be 2

    # Exercise 3: Valid Parentheses
    print("\n=== EXERCISE 3: Valid Parentheses ===")
    test_cases = [
        ("()", True),
        ("([{}])", True),
        ("([)]", False),
        ("{[}", False),
        ("", True),
    ]
    for s, expected in test_cases:
        result = is_valid_parentheses(s)
        status = "✓" if result == expected else "✗"
        print(f"{status} '{s}' → {result} (expected {expected})")

    # Exercise 4: Min Stack
    print("\n=== EXERCISE 4: Min Stack ===")
    min_stack = MinStack()
    min_stack.push(3)
    min_stack.push(1)
    min_stack.push(4)
    min_stack.push(1)
    print(f"Get min: {min_stack.get_min()}")  # Should be 1
    min_stack.pop()
    print(f"After pop, min: {min_stack.get_min()}")  # Should be 1
    min_stack.pop()
    print(f"After pop, min: {min_stack.get_min()}")  # Should be 1
    min_stack.pop()
    print(f"After pop, min: {min_stack.get_min()}")  # Should be 3

    # Exercise 5: Next Greater Element
    print("\n=== EXERCISE 5: Next Greater Element ===")
    nums = [1, 5, 0, 3, 4, 5]
    result = next_greater_element(nums)
    expected = [5, -1, 3, 4, 5, -1]
    status = "✓" if result == expected else "✗"
    print(f"{status} Input: {nums}")
    print(f"   Output: {result}")
    print(f"   Expected: {expected}")

    # Exercise 6: Daily Temperatures
    print("\n=== EXERCISE 6: Daily Temperatures ===")
    temps = [73, 74, 75, 71, 69, 72, 76, 73]
    result = daily_temperatures(temps)
    expected = [1, 1, 4, 2, 1, 1, 0, 0]
    status = "✓" if result == expected else "✗"
    print(f"{status} Input: {temps}")
    print(f"   Output: {result}")
    print(f"   Expected: {expected}")

    # Exercise 7: Evaluate RPN
    print("\n=== EXERCISE 7: Evaluate RPN ===")
    test_cases = [(["2", "1", "+", "3", "*"], 9), (["4", "13", "5", "/", "+"], 6)]
    for tokens, expected in test_cases:
        result = eval_rpn(tokens)
        status = "✓" if result == expected else "✗"
        print(f"{status} {tokens} → {result} (expected {expected})")

    # Exercise 8: Queue Using Stacks
    print("\n=== EXERCISE 8: Queue Using Stacks ===")
    queue_stack = QueueUsingStacks()
    queue_stack.push(1)
    queue_stack.push(2)
    queue_stack.push(3)
    print(f"Peek: {queue_stack.peek()}")  # Should be 1
    print(f"Pop: {queue_stack.pop()}")  # Should be 1
    print(f"Pop: {queue_stack.pop()}")  # Should be 2
    print(f"Empty: {queue_stack.empty()}")  # Should be False

    # Exercise 9: Stack Using Queues
    print("\n=== EXERCISE 9: Stack Using Queues ===")
    stack_queue = StackUsingQueues()
    stack_queue.push(1)
    stack_queue.push(2)
    stack_queue.push(3)
    print(f"Top: {stack_queue.top()}")  # Should be 3
    print(f"Pop: {stack_queue.pop()}")  # Should be 3
    print(f"Pop: {stack_queue.pop()}")  # Should be 2
    print(f"Empty: {stack_queue.empty()}")  # Should be False

    # Exercise 10: Sliding Window Maximum
    print("\n=== EXERCISE 10: Sliding Window Maximum ===")
    nums = [1, 3, 1, 2, 0, 5]
    k = 3
    result = sliding_window_maximum(nums, k)
    expected = [3, 3, 2, 5]
    status = "✓" if result == expected else "✗"
    print(f"{status} Input: {nums}, k={k}")
    print(f"   Output: {result}")
    print(f"   Expected: {expected}")

    # Exercise 11: Level Order Traversal
    print("\n=== EXERCISE 11: Level Order Traversal ===")
    root = create_binary_tree([3, 9, 20, None, None, 15, 7])
    result = level_order_traversal(root)
    expected = [[3], [9, 20], [15, 7]]
    status = "✓" if result == expected else "✗"
    print(f"{status} Output: {result}")
    print(f"   Expected: {expected}")

    # Exercise 12: Recent Counter
    print("\n=== EXERCISE 12: Recent Counter ===")
    counter = RecentCounter()
    pings = [(1, 1), (100, 2), (3001, 3), (3002, 3)]
    for ping, expected in pings:
        result = counter.ping(ping)
        status = "✓" if result == expected else "✗"
        print(f"{status} ping({ping}) → {result} (expected {expected})")

    # Exercise 13: Trapping Rain Water
    print("\n=== EXERCISE 13: Trapping Rain Water ===")
    height = [0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1]
    result = trap_rain_water(height)
    expected = 6
    status = "✓" if result == expected else "✗"
    print(f"{status} Input: {height}")
    print(f"   Output: {result} (expected {expected})")

    # Exercise 14: Largest Rectangle in Histogram
    print("\n=== EXERCISE 14: Largest Rectangle in Histogram ===")
    test_cases = [([2, 1, 5, 6, 2, 3], 10), ([2, 4], 4), ([1], 1)]
    for heights, expected in test_cases:
        result = largest_rectangle_in_histogram(heights)
        status = "✓" if result == expected else "✗"
        print(f"{status} {heights} → {result} (expected {expected})")

    # Exercise 15: Asteroid Collision
    print("\n=== EXERCISE 15: Asteroid Collision ===")
    test_cases = [([5, 10, -5], [5, 10]), ([8, -8], []), ([10, 2, -5], [10])]
    for asteroids, expected in test_cases:
        result = asteroid_collision(asteroids)
        status = "✓" if result == expected else "✗"
        print(f"{status} {asteroids} → {result}")
        print(f"   (expected {expected})")

    # Exercise 16: Word Ladder II
    print("\n=== EXERCISE 16: Word Ladder II ===")
    beginWord = "hit"
    endWord = "cog"
    wordList = ["hot", "dot", "dog", "lot", "log", "cog"]
    result = find_ladders(beginWord, endWord, wordList)
    print(f"Begin: {beginWord}, End: {endWord}")
    print(f"Paths found: {len(result)}")
    for path in result:
        print(f"  {' → '.join(path)}")

    # Exercise 17: LRU Cache
    print("\n=== EXERCISE 17: LRU Cache ===")
    lru = LRUCache(2)
    lru.put(1, 1)
    lru.put(2, 2)
    print(f"get(1) → {lru.get(1)}")  # Should be 1
    lru.put(3, 3)  # Evicts 2
    print(f"get(2) → {lru.get(2)}")  # Should be -1
    lru.put(4, 4)  # Evicts 1
    print(f"get(1) → {lru.get(1)}")  # Should be -1
    print(f"get(3) → {lru.get(3)}")  # Should be 3
    print(f"get(4) → {lru.get(4)}")  # Should be 4

    print("\n" + "=" * 70)
    print("ALL TESTS COMPLETED")
    print("=" * 70)
