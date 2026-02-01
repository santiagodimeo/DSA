"""
Stacks and Queues - Code Demonstrations

This file demonstrates common stack and queue patterns and operations.
Study each function and its use case.
"""

from collections import deque

# ============================================================================
# BASIC STACK IMPLEMENTATION
# ============================================================================


class Stack:
    """
    Stack implementation using Python list (LIFO - Last In First Out).

    Example: [1, 2, 3] → push 4 → [1, 2, 3, 4] → pop → 4
    """

    def __init__(self):
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

        Time: O(1)
        Space: O(1)

        Returns: None if stack is empty
        """
        if self.is_empty():
            return None
        return self.items.pop()

    def peek(self):
        """
        View top element without removing.

        Time: O(1)
        Space: O(1)

        Returns: None if stack is empty
        """
        if self.is_empty():
            return None
        return self.items[-1]

    def is_empty(self):
        """
        Check if stack is empty.

        Time: O(1)
        Space: O(1)
        """
        return len(self.items) == 0

    def size(self):
        """
        Get number of elements in stack.

        Time: O(1)
        Space: O(1)
        """
        return len(self.items)

    def __repr__(self):
        return f"Stack({self.items})"


# ============================================================================
# BASIC QUEUE IMPLEMENTATION
# ============================================================================


class Queue:
    """
    Queue implementation using collections.deque (FIFO - First In First Out).

    Note: Using deque instead of list for efficient O(1) popleft operation.
    Example: [1, 2, 3] → enqueue 4 → [1, 2, 3, 4] → dequeue → 1
    """

    def __init__(self):
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

        Time: O(1)
        Space: O(1)

        Returns: None if queue is empty
        """
        if self.is_empty():
            return None
        return self.items.popleft()

    def front(self):
        """
        View front element without removing.

        Time: O(1)
        Space: O(1)

        Returns: None if queue is empty
        """
        if self.is_empty():
            return None
        return self.items[0]

    def is_empty(self):
        """
        Check if queue is empty.

        Time: O(1)
        Space: O(1)
        """
        return len(self.items) == 0

    def size(self):
        """
        Get number of elements in queue.

        Time: O(1)
        Space: O(1)
        """
        return len(self.items)

    def __repr__(self):
        return f"Queue({list(self.items)})"


# ============================================================================
# PATTERN 1: VALID PARENTHESES
# ============================================================================


def is_valid_parentheses(s):
    """
    Check if string has valid matching parentheses/brackets/braces.

    Time: O(n) - traverse string once
    Space: O(n) - stack can store up to n/2 opening brackets

    Approach: Use stack to match closing with opening brackets.
    - Push opening brackets: (, [, {
    - For closing brackets, pop and verify match
    - At end, stack must be empty

    Example: "()" → True
    Example: "([{}])" → True
    Example: "([)]" → False
    Example: "{[}" → False
    """
    matching = {"(": ")", "[": "]", "{": "}"}
    stack = Stack()

    for char in s:
        if char in matching:  # Opening bracket
            stack.push(char)
        else:  # Closing bracket
            if stack.is_empty():
                return False

            last_open = stack.pop()
            if matching[last_open] != char:
                return False

    return stack.is_empty()


def is_valid_parentheses_advanced(s):
    """
    Validate parentheses with special cases (empty spaces, etc).

    Time: O(n)
    Space: O(n)

    Example: "(a[b]{c})" → True
    Example: "[({})]" → True
    """
    matching = {"(": ")", "[": "]", "{": "}"}
    stack = []

    for char in s:
        if char in matching:
            stack.append(char)
        elif char in matching.values():  # Closing bracket
            if not stack or matching[stack.pop()] != char:
                return False

    return len(stack) == 0


# ============================================================================
# PATTERN 2: MONOTONIC STACK
# ============================================================================


def next_greater_element(nums):
    """
    Find next greater element for each element in array.

    Time: O(n) - each element pushed/popped once
    Space: O(n) - stack and result

    Approach: Use monotonic decreasing stack.
    - Maintain elements in decreasing order from bottom to top
    - For each element, pop all smaller elements (they found their answer)
    - Current element is the next greater for popped elements

    Example: [1, 5, 0, 3, 4, 5]
    Output: [5, -1, 3, 4, 5, -1]
    Explanation: 1→5, 5→-1 (no greater), 0→3, 3→4, 4→5, 5→-1
    """
    result = [-1] * len(nums)
    stack = []  # Monotonic decreasing stack

    for i in range(len(nums) - 1, -1, -1):
        # Pop elements smaller than current
        while stack and stack[-1] <= nums[i]:
            stack.pop()

        # Top of stack is next greater (if exists)
        if stack:
            result[i] = stack[-1]

        # Push current element
        stack.append(nums[i])

    return result


def next_greater_element_circular(nums):
    """
    Find next greater element with circular array.

    Time: O(n)
    Space: O(n)

    Approach: Process array twice to handle circular nature.

    Example: [1, 2, 1]
    Output: [2, -1, 2]
    Explanation: Last 1's next greater is first 2 (circular)
    """
    result = [-1] * len(nums)
    stack = []
    n = len(nums)

    # Process array twice for circular behavior
    for i in range(2 * n):
        idx = i % n

        while stack and nums[stack[-1]] < nums[idx]:
            result[stack.pop()] = nums[idx]

        if i < n:
            stack.append(idx)

    return result


def daily_temperatures(temps):
    """
    Find days until warmer temperature for each day.

    Time: O(n)
    Space: O(n)

    Approach: Monotonic stack of indices.
    - For warmer day, calculate difference and pop
    - Stack maintains indices of days waiting for warmer day

    Example: [73, 74, 75, 71, 69, 72, 76, 73]
    Output:  [1,  1,  4,  2,  1,  1,  0,  0]
    Explanation: 73→74 (1 day), 74→75 (1 day), 75→76 (4 days), etc.
    """
    result = [0] * len(temps)
    stack = []  # Indices of increasing temperature

    for i in range(len(temps)):
        # Pop indices with lower temperature
        while stack and temps[stack[-1]] < temps[i]:
            prev_idx = stack.pop()
            result[prev_idx] = i - prev_idx

        stack.append(i)

    return result


def trapping_rain_water(height):
    """
    Calculate water trapped after raining on elevation map.

    Time: O(n)
    Space: O(n) - monotonic stack

    Approach: Use monotonic decreasing stack of indices.
    - For each bar, calculate trapped water between it and bars in stack
    - Water depends on minimum of surrounding heights and current height

    Example: [0,1,0,2,1,0,1,3,2,1,2,1]
    Output: 6
    Visualization: Water trapped in valleys between peaks
    """
    stack = []  # Monotonic decreasing stack of indices
    water = 0

    for i in range(len(height)):
        while stack and height[stack[-1]] < height[i]:
            bottom_idx = stack.pop()
            bottom_height = height[bottom_idx]

            if not stack:
                break

            # Distance between left and right bars
            width = i - stack[-1] - 1

            # Height of water: min of left/right minus bottom
            h = min(height[stack[-1]], height[i]) - bottom_height

            water += width * h

        stack.append(i)

    return water


def largest_rectangle_in_histogram(heights):
    """
    Find largest rectangle area in histogram.

    Time: O(n)
    Space: O(n)

    Approach: Use monotonic increasing stack of indices.
    - For decreasing height, pop and calculate area
    - Area = height * width (current position - position before popped)

    Example: [2,1,5,6,2,3]
    Output: 10
    Explanation: Rectangle with height 5 and width 2 (indices 2-3)
    """
    stack = []
    max_area = 0

    for i in range(len(heights)):
        while stack and heights[stack[-1]] > heights[i]:
            h_idx = stack.pop()
            h = heights[h_idx]

            # Width is distance to current position
            width = i if not stack else i - stack[-1] - 1

            area = h * width
            max_area = max(max_area, area)

        stack.append(i)

    # Process remaining bars
    while stack:
        h_idx = stack.pop()
        h = heights[h_idx]
        width = len(heights) if not stack else len(heights) - stack[-1] - 1
        area = h * width
        max_area = max(max_area, area)

    return max_area


# ============================================================================
# PATTERN 3: MIN/MAX STACK
# ============================================================================


class MinStack:
    """
    Stack that supports push, pop, top, and retrieving minimum in O(1).

    Approach: Use auxiliary stack to track minimums.
    Each level of min_stack corresponds to min up to that point.
    """

    def __init__(self):
        self.stack = []
        self.min_stack = []

    def push(self, val):
        """
        Add value to stack and update minimum.

        Time: O(1)
        Space: O(1)
        """
        self.stack.append(val)

        # Update minimum stack
        if not self.min_stack or val <= self.min_stack[-1]:
            self.min_stack.append(val)

    def pop(self):
        """
        Remove top value. Update minimum if it's the min.

        Time: O(1)
        Space: O(1)
        """
        if not self.stack:
            return None

        val = self.stack.pop()

        # Pop from min stack if top value is the minimum
        if self.min_stack and val == self.min_stack[-1]:
            self.min_stack.pop()

        return val

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

    def __repr__(self):
        return f"MinStack(items={self.stack}, min={self.get_min()})"


class MaxStack:
    """
    Stack that supports push, pop, top, and retrieving maximum in O(1).

    Approach: Use auxiliary stack to track maximums (similar to MinStack).
    """

    def __init__(self):
        self.stack = []
        self.max_stack = []

    def push(self, val):
        """
        Add value to stack and update maximum.

        Time: O(1)
        Space: O(1)
        """
        self.stack.append(val)

        if not self.max_stack or val >= self.max_stack[-1]:
            self.max_stack.append(val)

    def pop(self):
        """
        Remove top value. Update maximum if it's the max.

        Time: O(1)
        Space: O(1)
        """
        if not self.stack:
            return None

        val = self.stack.pop()

        if self.max_stack and val == self.max_stack[-1]:
            self.max_stack.pop()

        return val

    def top(self):
        """
        Return top value without removing.

        Time: O(1)
        Space: O(1)
        """
        return self.stack[-1] if self.stack else None

    def get_max(self):
        """
        Return current maximum value.

        Time: O(1)
        Space: O(1)
        """
        return self.max_stack[-1] if self.max_stack else None

    def __repr__(self):
        return f"MaxStack(items={self.stack}, max={self.get_max()})"


# ============================================================================
# PATTERN 4: DEQUE EXAMPLES
# ============================================================================


def sliding_window_maximum(nums, k):
    """
    Find maximum in every sliding window of size k.

    Time: O(n) - each element processed once
    Space: O(k) - deque stores at most k elements

    Approach: Use deque to store indices of useful elements.
    - Deque is monotonic decreasing (max at front)
    - Remove indices outside window
    - Remove elements smaller than current (they can't be max while current exists)

    Example: nums=[1,3,1,2,0,5], k=3
    Output: [3,3,2,5]
    Windows: [1,3,1] → 3, [3,1,2] → 3, [1,2,0] → 2, [2,0,5] → 5
    """
    if not nums or k == 0:
        return []

    dq = deque()  # Stores indices
    result = []

    for i in range(len(nums)):
        # Remove elements outside current window
        while dq and dq[0] < i - k + 1:
            dq.popleft()

        # Remove elements smaller than current (monotonic decreasing)
        while dq and nums[dq[-1]] < nums[i]:
            dq.pop()

        dq.append(i)

        # First window completes at index k-1
        if i >= k - 1:
            result.append(nums[dq[0]])

    return result


def first_negative_in_window(nums, k):
    """
    Find first negative number in each window of size k.

    Time: O(n)
    Space: O(k)

    Approach: Use deque to store indices of negative numbers.
    - Only store negatives (positives can't be answer)
    - Remove indices outside window

    Example: nums=[12,-1,-7,8], k=2
    Output: [-1,-7,-7]
    """
    dq = deque()
    result = []

    for i in range(len(nums)):
        # Remove negatives outside current window
        while dq and dq[0] < i - k + 1:
            dq.popleft()

        # Add current if it's negative
        if nums[i] < 0:
            dq.append(i)

        # First window completes at index k-1
        if i >= k - 1:
            result.append(nums[dq[0]] if dq else 0)

    return result


class RecentCounter:
    """
    Count requests within recent time window using deque.

    Useful for rate limiting and monitoring.
    """

    def __init__(self):
        """
        Initialize counter.

        Time: O(1)
        Space: O(1)
        """
        self.requests = deque()

    def ping(self, t):
        """
        Record request at time t and return count in last 3000 ms.

        Time: O(n) where n is number of requests in window
        Space: O(n)

        Approach: Remove outdated requests, then count.

        Example: ping(1) → 1 (t=1)
                ping(100) → 2 (t=1,100)
                ping(3001) → 3 (t=1,100,3001, but 1 is 3000ms ago, so all count)
                ping(3002) → 2 (t=100,3001,3002, t=1 is outside)
        """
        # Remove requests older than t - 3000
        while self.requests and self.requests[0] < t - 3000:
            self.requests.popleft()

        self.requests.append(t)
        return len(self.requests)


def max_consecutive_ones_iii(nums, k):
    """
    Maximum consecutive 1's after flipping at most k 0's.

    Time: O(n) - sliding window
    Space: O(1)

    Approach: Use deque-based sliding window to track 0's.
    - Expand window by adding elements
    - When 0's exceed k, shrink from left
    - Track maximum window size

    Example: nums=[1,1,1,0,0,0,1,1,1,1,0], k=2
    Output: 6
    Explanation: Flip the two 0's in middle, get [1,1,1,1,1,1,1,1,1,1,0]
    """
    zeros_pos = deque()
    left = 0
    max_length = 0

    for right in range(len(nums)):
        if nums[right] == 0:
            zeros_pos.append(right)

        # If more than k zeros, move left pointer
        if len(zeros_pos) > k:
            left = zeros_pos.popleft() + 1

        max_length = max(max_length, right - left + 1)

    return max_length


# ============================================================================
# PATTERN 5: BFS WITH QUEUE
# ============================================================================


class TreeNode:
    """Simple tree node for BFS examples."""

    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right


def level_order_traversal(root):
    """
    Traverse binary tree level by level (BFS).

    Time: O(n) - visit each node once
    Space: O(w) - queue stores at most width of tree (usually O(n/2) at max)

    Approach: Use queue to process nodes level by level.
    - Enqueue root
    - For each level, dequeue node, process, enqueue children
    - Continue until queue empty

    Example: Tree:    1
                     / \
                    2   3
             Output: [[1], [2, 3]]
    """
    if not root:
        return []

    result = []
    queue = Queue()
    queue.enqueue(root)

    while not queue.is_empty():
        level_size = queue.size()
        current_level = []

        # Process all nodes at current level
        for _ in range(level_size):
            node = queue.dequeue()
            current_level.append(node.val)

            if node.left:
                queue.enqueue(node.left)
            if node.right:
                queue.enqueue(node.right)

        result.append(current_level)

    return result


def level_order_traversal_deque(root):
    """
    Level order traversal using collections.deque directly.

    Time: O(n)
    Space: O(w)

    More efficient than custom Queue class for real applications.
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


def right_side_view(root):
    """
    Get view of tree from right side (rightmost node at each level).

    Time: O(n)
    Space: O(h) where h is height

    Approach: BFS and take last node from each level.

    Example: Tree:    1
                     / \\
                    2   3
                     \\   \\
                      5   4
             Output: [1, 3, 4]
    """
    if not root:
        return []

    result = []
    queue = deque([root])

    while queue:
        level_size = len(queue)

        for i in range(level_size):
            node = queue.popleft()

            # Take rightmost node from level
            if i == level_size - 1:
                result.append(node.val)

            if node.left:
                queue.append(node.left)
            if node.right:
                queue.append(node.right)

    return result


def shortest_path_grid(grid):
    """
    Find shortest path in grid from top-left to bottom-right (BFS).

    Time: O(m*n) - visit each cell once
    Space: O(m*n) - queue and visited set

    Approach:
    1. Start BFS from top-left
    2. Explore neighbors in queue order
    3. First time reaching bottom-right is shortest path

    Example: grid = [[0,1],
                    [0,0]]
             Output: 2 (only one path)

    Note: 0 = walkable, 1 = obstacle
    """
    if not grid or grid[0][0] == 1:
        return -1

    m, n = len(grid), len(grid[0])
    queue = deque([(0, 0, 1)])  # (row, col, distance)
    visited = {(0, 0)}
    directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]

    while queue:
        row, col, dist = queue.popleft()

        if row == m - 1 and col == n - 1:
            return dist

        for dr, dc in directions:
            new_row, new_col = row + dr, col + dc

            if (
                0 <= new_row < m
                and 0 <= new_col < n
                and grid[new_row][new_col] == 0
                and (new_row, new_col) not in visited
            ):
                visited.add((new_row, new_col))
                queue.append((new_row, new_col, dist + 1))

    return -1  # No path found


# ============================================================================
# HELPER FUNCTIONS
# ============================================================================


def print_stack(stack):
    """
    Print stack contents from bottom to top.

    Time: O(n)
    Space: O(1)
    """
    print("Stack (bottom → top):", " → ".join(map(str, stack.items)))


def print_queue(queue):
    """
    Print queue contents from front to back.

    Time: O(n)
    Space: O(1)
    """
    print("Queue (front → back):", " → ".join(map(str, queue.items)))


# ============================================================================
# TESTING
# ============================================================================

if __name__ == "__main__":
    print("=" * 70)
    print("STACK OPERATIONS")
    print("=" * 70)

    # Basic Stack
    print("\n--- Basic Stack ---")
    stack = Stack()
    stack.push(1)
    stack.push(2)
    stack.push(3)
    print_stack(stack)
    print(f"Peek: {stack.peek()}")
    print(f"Pop: {stack.pop()}")
    print_stack(stack)

    # Valid Parentheses
    print("\n--- Valid Parentheses ---")
    test_cases = [
        "()",
        "([{}])",
        "([)]",
        "{[}",
        "",
    ]
    for test in test_cases:
        result = is_valid_parentheses(test)
        print(f"'{test}' → {result}")

    # Monotonic Stack - Next Greater Element
    print("\n--- Next Greater Element ---")
    nums = [1, 5, 0, 3, 4, 5]
    result = next_greater_element(nums)
    print(f"Input: {nums}")
    print(f"Output: {result}")

    # Monotonic Stack - Daily Temperatures
    print("\n--- Daily Temperatures ---")
    temps = [73, 74, 75, 71, 69, 72, 76, 73]
    result = daily_temperatures(temps)
    print(f"Input: {temps}")
    print(f"Output: {result}")

    # Min Stack
    print("\n--- Min Stack ---")
    min_stack = MinStack()
    min_stack.push(3)
    print(f"Push 3: {min_stack}")
    min_stack.push(1)
    print(f"Push 1: {min_stack}")
    min_stack.push(4)
    print(f"Push 4: {min_stack}")
    min_stack.push(1)
    print(f"Push 1: {min_stack}")
    min_stack.pop()
    print(f"Pop: {min_stack}")

    # Max Stack
    print("\n--- Max Stack ---")
    max_stack = MaxStack()
    max_stack.push(1)
    max_stack.push(5)
    max_stack.push(3)
    print(f"MaxStack after pushes: {max_stack}")
    print(f"Get max: {max_stack.get_max()}")

    # Trapping Rain Water
    print("\n--- Trapping Rain Water ---")
    heights = [0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1]
    water = trapping_rain_water(heights)
    print(f"Heights: {heights}")
    print(f"Water trapped: {water}")

    # Largest Rectangle in Histogram
    print("\n--- Largest Rectangle in Histogram ---")
    heights = [2, 1, 5, 6, 2, 3]
    area = largest_rectangle_in_histogram(heights)
    print(f"Heights: {heights}")
    print(f"Largest rectangle area: {area}")

    print("\n" + "=" * 70)
    print("QUEUE OPERATIONS")
    print("=" * 70)

    # Basic Queue
    print("\n--- Basic Queue ---")
    queue = Queue()
    queue.enqueue(1)
    queue.enqueue(2)
    queue.enqueue(3)
    print_queue(queue)
    print(f"Front: {queue.front()}")
    print(f"Dequeue: {queue.dequeue()}")
    print_queue(queue)

    # Sliding Window Maximum
    print("\n--- Sliding Window Maximum ---")
    nums = [1, 3, 1, 2, 0, 5]
    k = 3
    result = sliding_window_maximum(nums, k)
    print(f"Input: {nums}, k={k}")
    print(f"Output: {result}")

    # First Negative in Window
    print("\n--- First Negative in Window ---")
    nums = [12, -1, -7, 8]
    k = 2
    result = first_negative_in_window(nums, k)
    print(f"Input: {nums}, k={k}")
    print(f"Output: {result}")

    # Recent Counter
    print("\n--- Recent Counter ---")
    counter = RecentCounter()
    test_pings = [1, 100, 3001, 3002]
    for ping in test_pings:
        count = counter.ping(ping)
        print(f"ping({ping}) → {count}")

    # Max Consecutive Ones III
    print("\n--- Max Consecutive Ones III ---")
    nums = [1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0]
    k = 2
    result = max_consecutive_ones_iii(nums, k)
    print(f"Input: {nums}, k={k}")
    print(f"Output: {result}")

    print("\n" + "=" * 70)
    print("BFS WITH QUEUE")
    print("=" * 70)

    # Level Order Traversal
    print("\n--- Level Order Traversal (BFS) ---")
    # Build tree:     1
    #                / \
    #               2   3
    tree_root = TreeNode(1)
    tree_root.left = TreeNode(2)
    tree_root.right = TreeNode(3)
    tree_root.left.left = TreeNode(4)
    tree_root.left.right = TreeNode(5)

    result = level_order_traversal(tree_root)
    print(f"Level order: {result}")

    # Right Side View
    print("\n--- Right Side View ---")
    result = right_side_view(tree_root)
    print(f"Right side view: {result}")

    # Shortest Path in Grid
    print("\n--- Shortest Path in Grid ---")
    grid = [
        [0, 0, 0],
        [1, 1, 0],
        [1, 0, 0],
    ]
    result = shortest_path_grid(grid)
    print(f"Grid: {grid}")
    print(f"Shortest path distance: {result}")

    print("\n" + "=" * 70)
    print("DEQUE EXAMPLES")
    print("=" * 70)

    # Using deque directly
    print("\n--- Direct Deque Usage ---")
    dq = deque([1, 2, 3])
    print(f"Initial deque: {list(dq)}")
    dq.append(4)
    print(f"After append(4): {list(dq)}")
    dq.appendleft(0)
    print(f"After appendleft(0): {list(dq)}")
    print(f"popleft(): {dq.popleft()}")
    print(f"pop(): {dq.pop()}")
    print(f"Final deque: {list(dq)}")

    print("\n" + "=" * 70)
    print("ALL TESTS COMPLETED")
    print("=" * 70)
