"""
Linked Lists - Exercises

Implement the following linked list problems.
Focus on pointer manipulation and edge cases.

After attempting, check solutions.py for answers and explanations.
"""


# ============================================================================
# NODE DEFINITION
# ============================================================================


class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next


# ============================================================================
# HELPER FUNCTIONS (provided for testing)
# ============================================================================


def create_linked_list(arr):
    """Create linked list from array."""
    if not arr:
        return None
    head = ListNode(arr[0])
    current = head
    for i in range(1, len(arr)):
        current.next = ListNode(arr[i])
        current = current.next
    return head


def print_list(head):
    """Print linked list."""
    values = []
    current = head
    while current:
        values.append(str(current.val))
        current = current.next
    print(" → ".join(values) + " → None")


def list_to_array(head):
    """Convert linked list to array for testing."""
    result = []
    current = head
    while current:
        result.append(current.val)
        current = current.next
    return result


# ============================================================================
# EXERCISE 1: Basic Operations
# ============================================================================


def reverse_list(head):
    """
    Reverse a singly linked list.

    Example: [1→2→3→4→5] → [5→4→3→2→1]

    Requirements:
    - Time: O(n)
    - Space: O(1)

    TODO: Implement using three pointers (prev, current, next)
    Hint: Reverse each pointer one by one
    """
    pass


def find_middle(head):
    """
    Find the middle node of linked list.
    If two middle nodes, return the second one.

    Example: [1→2→3→4→5] → 3
    Example: [1→2→3→4] → 3

    Requirements:
    - Time: O(n)
    - Space: O(1)

    TODO: Use fast/slow pointer technique
    Hint: Slow moves 1 step, fast moves 2 steps
    """
    pass


def get_length(head):
    """
    Get the length of the linked list.

    Example: [1→2→3→4] → 4
    Example: [] → 0

    Requirements:
    - Time: O(n)
    - Space: O(1)

    TODO: Count nodes while traversing
    """
    pass


# ============================================================================
# EXERCISE 2: Two Pointers
# ============================================================================


def has_cycle(head):
    """
    Detect if linked list has a cycle.

    Example: [1→2→3→4→2] (4 points back to 2) → True
    Example: [1→2→3→4] → False

    Requirements:
    - Time: O(n)
    - Space: O(1)

    TODO: Use Floyd's cycle detection (fast/slow pointers)
    Hint: If fast catches slow, there's a cycle
    """
    pass


def remove_nth_from_end(head, n):
    """
    Remove nth node from end of list.

    Example: [1→2→3→4→5], n=2 → [1→2→3→5]

    Requirements:
    - Time: O(n)
    - Space: O(1)

    TODO: Use two pointers n steps apart
    Hint: Use dummy node to handle edge case of removing head
    """
    pass


def find_intersection(headA, headB):
    """
    Find node where two linked lists intersect.
    Return None if they don't intersect.

    Example:
    A: [1→2→3]
                ↘
                 [6→7→8]
                ↗
    B: [4→5]
    Intersection at node with value 6

    Requirements:
    - Time: O(n + m)
    - Space: O(1)

    TODO: Calculate lengths, align lists, then traverse together
    """
    pass


# ============================================================================
# EXERCISE 3: Merge and Sort
# ============================================================================


def merge_two_sorted_lists(l1, l2):
    """
    Merge two sorted linked lists.

    Example: [1→3→5] + [2→4→6] → [1→2→3→4→5→6]

    Requirements:
    - Time: O(n + m)
    - Space: O(1)

    TODO: Use dummy node and compare values
    Hint: Similar to merge step in merge sort
    """
    pass


def sort_list(head):
    """
    Sort linked list in ascending order.

    Example: [4→2→1→3] → [1→2→3→4]

    Requirements:
    - Time: O(n log n)
    - Space: O(log n) - recursion stack

    TODO: Use merge sort (find middle, split, sort, merge)
    This is a challenging problem!
    """
    pass


# ============================================================================
# EXERCISE 4: Manipulation
# ============================================================================


def remove_duplicates_sorted(head):
    """
    Remove duplicates from sorted linked list.

    Example: [1→1→2→3→3] → [1→2→3]

    Requirements:
    - Time: O(n)
    - Space: O(1)

    TODO: Compare adjacent nodes
    """
    pass


def remove_elements(head, val):
    """
    Remove all nodes with value equal to val.

    Example: [1→2→6→3→6], val=6 → [1→2→3]

    Requirements:
    - Time: O(n)
    - Space: O(1)

    TODO: Use dummy node to simplify edge cases
    """
    pass


def delete_node(node):
    """
    Delete a node (not given head, just the node to delete).
    Assume it's not the tail.

    Example: [1→2→3→4], node=3 → [1→2→4]

    Requirements:
    - Time: O(1)
    - Space: O(1)

    TODO: Copy next node's value and skip next node
    Trick question - you can't actually delete it, but can make it "disappear"
    """
    pass


# ============================================================================
# EXERCISE 5: Palindrome and Reversal
# ============================================================================


def is_palindrome(head):
    """
    Check if linked list is a palindrome.

    Example: [1→2→2→1] → True
    Example: [1→2→3] → False

    Requirements:
    - Time: O(n)
    - Space: O(1)

    TODO: Find middle, reverse second half, compare
    """
    pass


def reverse_between(head, left, right):
    """
    Reverse nodes from position left to right (1-indexed).

    Example: [1→2→3→4→5], left=2, right=4 → [1→4→3→2→5]

    Requirements:
    - Time: O(n)
    - Space: O(1)

    TODO: Find left position, reverse until right position
    This is tricky - draw it out!
    """
    pass


def reverse_k_group(head, k):
    """
    Reverse nodes in groups of k.

    Example: [1→2→3→4→5], k=2 → [2→1→4→3→5]
    Example: [1→2→3→4→5], k=3 → [3→2→1→4→5]

    Requirements:
    - Time: O(n)
    - Space: O(1)

    TODO: Reverse k nodes at a time, connect groups
    Hard problem!
    """
    pass


# ============================================================================
# EXERCISE 6: Advanced
# ============================================================================


def add_two_numbers(l1, l2):
    """
    Add two numbers represented by linked lists (digits in reverse).

    Example: [2→4→3] + [5→6→4] → [7→0→8]
    Represents: 342 + 465 = 807

    Requirements:
    - Time: O(max(n, m))
    - Space: O(max(n, m))

    TODO: Traverse both lists, handle carry
    """
    pass


def reorder_list(head):
    """
    Reorder list: L0→L1→…→Ln-1→Ln to L0→Ln→L1→Ln-1→L2→Ln-2→…

    Example: [1→2→3→4] → [1→4→2→3]
    Example: [1→2→3→4→5] → [1→5→2→4→3]

    Requirements:
    - Time: O(n)
    - Space: O(1)

    TODO: Find middle, reverse second half, merge alternately
    """
    pass


def partition(head, x):
    """
    Partition list so all nodes < x come before nodes >= x.
    Preserve original relative order.

    Example: [1→4→3→2→5→2], x=3 → [1→2→2→4→3→5]

    Requirements:
    - Time: O(n)
    - Space: O(1)

    TODO: Use two dummy nodes for two partitions
    """
    pass


def copy_random_list(head):
    """
    Deep copy a linked list with random pointers.

    Node structure:
    class Node:
        def __init__(self, val, next=None, random=None):
            self.val = val
            self.next = next
            self.random = random  # Points to any node or None

    Requirements:
    - Time: O(n)
    - Space: O(n)

    TODO: Use hash map to map old nodes to new nodes
    This is a medium-hard problem
    """
    pass


def rotate_right(head, k):
    """
    Rotate list to the right by k places.

    Example: [1→2→3→4→5], k=2 → [4→5→1→2→3]

    Requirements:
    - Time: O(n)
    - Space: O(1)

    TODO: Find length, make circular, break at right position
    Hint: k = k % length (handle k > length)
    """
    pass


# ============================================================================
# EXERCISE 7: Design Problems
# ============================================================================


class MyLinkedList:
    """
    Design your own linked list.

    Implement:
    - get(index): Get value at index
    - addAtHead(val): Add node at head
    - addAtTail(val): Add node at tail
    - addAtIndex(index, val): Add node at index
    - deleteAtIndex(index): Delete node at index

    Requirements:
    - All operations should be efficient

    TODO: Implement using ListNode
    """

    def __init__(self):
        """Initialize your data structure here."""
        pass

    def get(self, index):
        """Get the value of the index-th node. Return -1 if invalid."""
        pass

    def addAtHead(self, val):
        """Add a node of value val before the first element."""
        pass

    def addAtTail(self, val):
        """Append a node of value val to the last element."""
        pass

    def addAtIndex(self, index, val):
        """Add a node before the index-th node."""
        pass

    def deleteAtIndex(self, index):
        """Delete the index-th node."""
        pass


# ============================================================================
# TESTING YOUR SOLUTIONS
# ============================================================================

if __name__ == "__main__":
    print("Test your solutions!")
    print("Run: python3 exercises.py")
    print("Compare with solutions.py when done.\n")

    # Example test - Reverse List
    print("=== Test Reverse List ===")
    head = create_linked_list([1, 2, 3, 4, 5])
    print("Original:", end=" ")
    print_list(head)
    # reversed_head = reverse_list(head)
    # print("Reversed:", end=" ")
    # print_list(reversed_head)

    # Example test - Find Middle
    print("\n=== Test Find Middle ===")
    head = create_linked_list([1, 2, 3, 4, 5])
    # middle = find_middle(head)
    # print(f"Middle value: {middle.val if middle else None}")

    # Example test - Has Cycle
    print("\n=== Test Has Cycle ===")
    head = create_linked_list([1, 2, 3, 4])
    # Create cycle: 4 → 2
    # if head:
    #     tail = head
    #     while tail.next:
    #         tail = tail.next
    #     tail.next = head.next  # Create cycle
    # print(f"Has cycle: {has_cycle(head)}")
