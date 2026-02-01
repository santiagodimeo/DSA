"""
Linked Lists - Code Demonstrations

This file demonstrates common linked list patterns and operations.
Study each function and its use case.
"""


# ============================================================================
# NODE DEFINITION
# ============================================================================


class ListNode:
    """
    Basic building block of a linked list.
    """

    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

    def __repr__(self):
        return f"ListNode({self.val})"


# ============================================================================
# HELPER FUNCTIONS
# ============================================================================


def create_linked_list(arr):
    """
    Create linked list from array.

    Time: O(n)
    Space: O(n) - creates n nodes
    """
    if not arr:
        return None

    head = ListNode(arr[0])
    current = head

    for i in range(1, len(arr)):
        current.next = ListNode(arr[i])
        current = current.next

    return head


def print_list(head):
    """
    Print linked list in readable format.

    Time: O(n)
    Space: O(1)
    """
    values = []
    current = head
    while current:
        values.append(str(current.val))
        current = current.next
    print(" → ".join(values) + " → None")


def list_to_array(head):
    """
    Convert linked list to array for testing.

    Time: O(n)
    Space: O(n)
    """
    result = []
    current = head
    while current:
        result.append(current.val)
        current = current.next
    return result


# ============================================================================
# BASIC OPERATIONS
# ============================================================================


def get_length(head):
    """
    Get length of linked list.

    Time: O(n)
    Space: O(1)
    """
    count = 0
    current = head
    while current:
        count += 1
        current = current.next
    return count


def get_value_at_index(head, index):
    """
    Get value at specific index (0-based).

    Time: O(n) - worst case traverse entire list
    Space: O(1)

    Example: [1→2→3], index=1 → 2
    """
    current = head
    pos = 0

    while current:
        if pos == index:
            return current.val
        current = current.next
        pos += 1

    return None  # Index out of bounds


def insert_at_beginning(head, val):
    """
    Insert node at beginning.

    Time: O(1) - constant time
    Space: O(1)

    Example: [2→3], insert 1 → [1→2→3]
    """
    new_node = ListNode(val)
    new_node.next = head
    return new_node


def insert_at_end(head, val):
    """
    Insert node at end.

    Time: O(n) - must traverse to end
    Space: O(1)

    Example: [1→2], insert 3 → [1→2→3]
    """
    new_node = ListNode(val)

    if not head:
        return new_node

    current = head
    while current.next:
        current = current.next

    current.next = new_node
    return head


def insert_at_position(head, val, pos):
    """
    Insert node at specific position (0-based).

    Time: O(n)
    Space: O(1)

    Example: [1→3], insert 2 at pos 1 → [1→2→3]
    """
    if pos == 0:
        return insert_at_beginning(head, val)

    new_node = ListNode(val)
    current = head

    for i in range(pos - 1):
        if not current:
            return head  # Position out of bounds
        current = current.next

    if current:
        new_node.next = current.next
        current.next = new_node

    return head


def delete_at_beginning(head):
    """
    Delete first node.

    Time: O(1)
    Space: O(1)

    Example: [1→2→3] → [2→3]
    """
    if not head:
        return None
    return head.next


def delete_at_end(head):
    """
    Delete last node.

    Time: O(n) - must traverse to second-last
    Space: O(1)

    Example: [1→2→3] → [1→2]
    """
    if not head or not head.next:
        return None

    current = head
    while current.next.next:
        current = current.next

    current.next = None
    return head


def delete_value(head, val):
    """
    Delete first occurrence of value.

    Time: O(n)
    Space: O(1)

    Example: [1→2→3→2], delete 2 → [1→3→2]
    """
    dummy = ListNode(0)
    dummy.next = head

    current = dummy
    while current.next:
        if current.next.val == val:
            current.next = current.next.next
            break
        current = current.next

    return dummy.next


# ============================================================================
# PATTERN 1: TWO POINTERS (FAST & SLOW)
# ============================================================================


def find_middle(head):
    """
    Find middle node of linked list.

    Time: O(n)
    Space: O(1)

    Approach: Slow moves 1 step, fast moves 2 steps.
    When fast reaches end, slow is at middle.

    Example: [1→2→3→4→5] → 3
    Example: [1→2→3→4] → 3 (second middle for even length)
    """
    if not head:
        return None

    slow = fast = head

    while fast and fast.next:
        slow = slow.next
        fast = fast.next.next

    return slow


def has_cycle(head):
    """
    Detect if linked list has a cycle (Floyd's algorithm).

    Time: O(n)
    Space: O(1)

    Approach: If fast and slow meet, there's a cycle.

    Example: [1→2→3→4→2] (4 points back to 2) → True
    """
    if not head or not head.next:
        return False

    slow = fast = head

    while fast and fast.next:
        slow = slow.next
        fast = fast.next.next

        if slow == fast:
            return True

    return False


def find_cycle_start(head):
    """
    Find where cycle begins (if exists).

    Time: O(n)
    Space: O(1)

    Approach:
    1. Find meeting point with fast/slow
    2. Move slow to head, keep fast at meeting point
    3. Move both 1 step at a time - they meet at cycle start
    """
    if not head or not head.next:
        return None

    # Find meeting point
    slow = fast = head
    while fast and fast.next:
        slow = slow.next
        fast = fast.next.next
        if slow == fast:
            break

    # No cycle
    if not fast or not fast.next:
        return None

    # Find cycle start
    slow = head
    while slow != fast:
        slow = slow.next
        fast = fast.next

    return slow


def get_nth_from_end(head, n):
    """
    Get nth node from end.

    Time: O(n)
    Space: O(1)

    Approach: Use two pointers n steps apart.
    When first reaches end, second is at nth from end.

    Example: [1→2→3→4→5], n=2 → 4
    """
    first = second = head

    # Move first n steps ahead
    for i in range(n):
        if not first:
            return None
        first = first.next

    # Move both until first reaches end
    while first:
        first = first.next
        second = second.next

    return second


# ============================================================================
# PATTERN 2: REVERSAL
# ============================================================================


def reverse_list(head):
    """
    Reverse entire linked list.

    Time: O(n)
    Space: O(1)

    Approach: Reverse pointers one by one.

    Example: [1→2→3→4] → [4→3→2→1]
    """
    prev = None
    current = head

    while current:
        next_temp = current.next  # Save next
        current.next = prev  # Reverse pointer
        prev = current  # Move prev forward
        current = next_temp  # Move current forward

    return prev


def reverse_between(head, left, right):
    """
    Reverse nodes from position left to right.

    Time: O(n)
    Space: O(1)

    Example: [1→2→3→4→5], left=2, right=4 → [1→4→3→2→5]
    """
    if not head or left == right:
        return head

    dummy = ListNode(0)
    dummy.next = head

    # Move to node before left
    prev = dummy
    for i in range(left - 1):
        prev = prev.next

    # Reverse from left to right
    current = prev.next
    for i in range(right - left):
        next_temp = current.next
        current.next = next_temp.next
        next_temp.next = prev.next
        prev.next = next_temp

    return dummy.next


def is_palindrome(head):
    """
    Check if linked list is a palindrome.

    Time: O(n)
    Space: O(1)

    Approach:
    1. Find middle with fast/slow
    2. Reverse second half
    3. Compare first and second halves

    Example: [1→2→2→1] → True
    Example: [1→2→3] → False
    """
    if not head or not head.next:
        return True

    # Find middle
    slow = fast = head
    while fast.next and fast.next.next:
        slow = slow.next
        fast = fast.next.next

    # Reverse second half
    second_half = reverse_list(slow.next)

    # Compare
    first_half = head
    while second_half:
        if first_half.val != second_half.val:
            return False
        first_half = first_half.next
        second_half = second_half.next

    return True


# ============================================================================
# PATTERN 3: DUMMY NODE
# ============================================================================


def remove_elements(head, val):
    """
    Remove all nodes with specific value.

    Time: O(n)
    Space: O(1)

    Approach: Use dummy node to handle edge case of removing head.

    Example: [1→2→6→3→6], val=6 → [1→2→3]
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


def merge_two_sorted_lists(l1, l2):
    """
    Merge two sorted linked lists.

    Time: O(n + m)
    Space: O(1)

    Example: [1→3→5] + [2→4→6] → [1→2→3→4→5→6]
    """
    dummy = ListNode(0)
    current = dummy

    while l1 and l2:
        if l1.val <= l2.val:
            current.next = l1
            l1 = l1.next
        else:
            current.next = l2
            l2 = l2.next
        current = current.next

    # Attach remaining nodes
    current.next = l1 if l1 else l2

    return dummy.next


def partition(head, x):
    """
    Partition list so all nodes < x come before nodes >= x.

    Time: O(n)
    Space: O(1)

    Example: [1→4→3→2→5→2], x=3 → [1→2→2→4→3→5]
    """
    # Two dummy nodes for two partitions
    before_dummy = ListNode(0)
    after_dummy = ListNode(0)

    before = before_dummy
    after = after_dummy

    current = head
    while current:
        if current.val < x:
            before.next = current
            before = before.next
        else:
            after.next = current
            after = after.next
        current = current.next

    after.next = None  # Important: terminate second list
    before.next = after_dummy.next  # Connect two lists

    return before_dummy.next


# ============================================================================
# ADVANCED OPERATIONS
# ============================================================================


def remove_duplicates_sorted(head):
    """
    Remove duplicates from sorted list.

    Time: O(n)
    Space: O(1)

    Example: [1→1→2→3→3] → [1→2→3]
    """
    current = head

    while current and current.next:
        if current.val == current.next.val:
            current.next = current.next.next
        else:
            current = current.next

    return head


def remove_duplicates_unsorted(head):
    """
    Remove duplicates from unsorted list.

    Time: O(n)
    Space: O(n) - hash set

    Example: [1→3→2→1→4] → [1→3→2→4]
    """
    if not head:
        return None

    seen = {head.val}
    current = head

    while current.next:
        if current.next.val in seen:
            current.next = current.next.next
        else:
            seen.add(current.next.val)
            current = current.next

    return head


def add_two_numbers(l1, l2):
    """
    Add two numbers represented by linked lists (digits in reverse order).

    Time: O(max(n, m))
    Space: O(max(n, m))

    Example: [2→4→3] + [5→6→4] → [7→0→8]
    Represents: 342 + 465 = 807
    """
    dummy = ListNode(0)
    current = dummy
    carry = 0

    while l1 or l2 or carry:
        val1 = l1.val if l1 else 0
        val2 = l2.val if l2 else 0

        total = val1 + val2 + carry
        carry = total // 10

        current.next = ListNode(total % 10)
        current = current.next

        if l1:
            l1 = l1.next
        if l2:
            l2 = l2.next

    return dummy.next


# ============================================================================
# TESTING
# ============================================================================

if __name__ == "__main__":
    print("=== Basic Operations ===")
    head = create_linked_list([1, 2, 3, 4, 5])
    print("Original:", end=" ")
    print_list(head)
    print("Length:", get_length(head))
    print("Value at index 2:", get_value_at_index(head, 2))

    print("\n=== Insertion ===")
    head = insert_at_beginning(head, 0)
    print("After insert at beginning:", end=" ")
    print_list(head)

    head = insert_at_end(head, 6)
    print("After insert at end:", end=" ")
    print_list(head)

    print("\n=== Two Pointers ===")
    head = create_linked_list([1, 2, 3, 4, 5])
    middle = find_middle(head)
    print("Middle node:", middle.val if middle else None)

    head = create_linked_list([1, 2, 3, 4, 5])
    nth = get_nth_from_end(head, 2)
    print("2nd from end:", nth.val if nth else None)

    print("\n=== Reversal ===")
    head = create_linked_list([1, 2, 3, 4, 5])
    head = reverse_list(head)
    print("Reversed:", end=" ")
    print_list(head)

    print("\n=== Palindrome ===")
    head = create_linked_list([1, 2, 2, 1])
    print("Is [1,2,2,1] palindrome?", is_palindrome(head))

    print("\n=== Merge Sorted Lists ===")
    l1 = create_linked_list([1, 3, 5])
    l2 = create_linked_list([2, 4, 6])
    merged = merge_two_sorted_lists(l1, l2)
    print("Merged:", end=" ")
    print_list(merged)

    print("\n=== Remove Duplicates ===")
    head = create_linked_list([1, 1, 2, 3, 3])
    head = remove_duplicates_sorted(head)
    print("After removing duplicates:", end=" ")
    print_list(head)
