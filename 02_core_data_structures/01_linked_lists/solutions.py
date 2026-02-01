"""
Linked Lists - Solutions

Complete solutions with explanations for all exercises.
Study the approach and complexity analysis for each problem.
"""

# See demonstrations.py for full implementations with detailed comments.
# This file contains the same solutions with concise explanations.


class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next


# Helper functions
def create_linked_list(arr):
    if not arr:
        return None
    head = ListNode(arr[0])
    current = head
    for i in range(1, len(arr)):
        current.next = ListNode(arr[i])
        current = current.next
    return head


def print_list(head):
    values = []
    current = head
    while current:
        values.append(str(current.val))
        current = current.next
    print(" → ".join(values) + " → None")


def list_to_array(head):
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
    Time: O(n), Space: O(1)
    Approach: Use three pointers to reverse links one by one
    """
    prev = None
    current = head

    while current:
        next_temp = current.next  # Save next
        current.next = prev  # Reverse link
        prev = current  # Move prev forward
        current = next_temp  # Move current forward

    return prev


def find_middle(head):
    """
    Time: O(n), Space: O(1)
    Approach: Fast/slow pointers - when fast reaches end, slow is at middle
    """
    slow = fast = head
    while fast and fast.next:
        slow = slow.next
        fast = fast.next.next
    return slow


def get_length(head):
    """Time: O(n), Space: O(1)"""
    count = 0
    current = head
    while current:
        count += 1
        current = current.next
    return count


# ============================================================================
# EXERCISE 2: Two Pointers
# ============================================================================


def has_cycle(head):
    """
    Time: O(n), Space: O(1)
    Approach: Floyd's algorithm - if fast meets slow, there's a cycle
    """
    slow = fast = head
    while fast and fast.next:
        slow = slow.next
        fast = fast.next.next
        if slow == fast:
            return True
    return False


def remove_nth_from_end(head, n):
    """
    Time: O(n), Space: O(1)
    Approach: Two pointers n steps apart
    """
    dummy = ListNode(0)
    dummy.next = head
    first = second = dummy

    for i in range(n + 1):
        first = first.next

    while first:
        first = first.next
        second = second.next

    second.next = second.next.next
    return dummy.next


def find_intersection(headA, headB):
    """
    Time: O(n + m), Space: O(1)
    Approach: Calculate lengths, align, traverse together
    """
    if not headA or not headB:
        return None

    # Calculate lengths
    lenA = lenB = 0
    a, b = headA, headB
    while a:
        lenA += 1
        a = a.next
    while b:
        lenB += 1
        b = b.next

    # Align starts
    a, b = headA, headB
    while lenA > lenB:
        a = a.next
        lenA -= 1
    while lenB > lenA:
        b = b.next
        lenB -= 1

    # Find intersection
    while a != b:
        a = a.next
        b = b.next

    return a


# ============================================================================
# EXERCISE 3: Merge and Sort
# ============================================================================


def merge_two_sorted_lists(l1, l2):
    """
    Time: O(n + m), Space: O(1)
    Approach: Use dummy node, compare and link smaller values
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

    current.next = l1 if l1 else l2
    return dummy.next


def sort_list(head):
    """
    Time: O(n log n), Space: O(log n)
    Approach: Merge sort - find middle, split, sort recursively, merge
    """
    if not head or not head.next:
        return head

    # Find middle
    slow = fast = head
    prev = None
    while fast and fast.next:
        prev = slow
        slow = slow.next
        fast = fast.next.next

    # Split
    prev.next = None

    # Sort and merge
    left = sort_list(head)
    right = sort_list(slow)
    return merge_two_sorted_lists(left, right)


# ============================================================================
# EXERCISE 4: Manipulation
# ============================================================================


def remove_duplicates_sorted(head):
    """Time: O(n), Space: O(1)"""
    current = head
    while current and current.next:
        if current.val == current.next.val:
            current.next = current.next.next
        else:
            current = current.next
    return head


def remove_elements(head, val):
    """Time: O(n), Space: O(1)"""
    dummy = ListNode(0)
    dummy.next = head
    current = dummy

    while current.next:
        if current.next.val == val:
            current.next = current.next.next
        else:
            current = current.next

    return dummy.next


def delete_node(node):
    """
    Time: O(1), Space: O(1)
    Trick: Copy next node's value, then skip next node
    """
    node.val = node.next.val
    node.next = node.next.next


# ============================================================================
# EXERCISE 5: Palindrome and Reversal
# ============================================================================


def is_palindrome(head):
    """
    Time: O(n), Space: O(1)
    Approach: Find middle, reverse second half, compare
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


def reverse_between(head, left, right):
    """
    Time: O(n), Space: O(1)
    Approach: Find left position, reverse nodes until right
    """
    if not head or left == right:
        return head

    dummy = ListNode(0)
    dummy.next = head
    prev = dummy

    for i in range(left - 1):
        prev = prev.next

    current = prev.next
    for i in range(right - left):
        next_temp = current.next
        current.next = next_temp.next
        next_temp.next = prev.next
        prev.next = next_temp

    return dummy.next


def reverse_k_group(head, k):
    """
    Time: O(n), Space: O(1)
    Approach: Reverse k nodes at a time, connect groups
    """
    # Check if there are k nodes remaining
    count = 0
    node = head
    while node and count < k:
        node = node.next
        count += 1

    if count < k:
        return head

    # Reverse k nodes
    prev = None
    current = head
    for i in range(k):
        next_temp = current.next
        current.next = prev
        prev = current
        current = next_temp

    # Recursively reverse rest and connect
    head.next = reverse_k_group(current, k)
    return prev


# ============================================================================
# EXERCISE 6: Advanced
# ============================================================================


def add_two_numbers(l1, l2):
    """
    Time: O(max(n,m)), Space: O(max(n,m))
    Approach: Traverse both, handle carry
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


def reorder_list(head):
    """
    Time: O(n), Space: O(1)
    Approach: Find middle, reverse second half, merge alternately
    """
    if not head or not head.next:
        return

    # Find middle
    slow = fast = head
    while fast.next and fast.next.next:
        slow = slow.next
        fast = fast.next.next

    # Reverse second half
    second = reverse_list(slow.next)
    slow.next = None

    # Merge alternately
    first = head
    while second:
        temp1 = first.next
        temp2 = second.next

        first.next = second
        second.next = temp1

        first = temp1
        second = temp2


def partition(head, x):
    """
    Time: O(n), Space: O(1)
    Approach: Two dummy nodes for two partitions
    """
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

    after.next = None
    before.next = after_dummy.next
    return before_dummy.next


def rotate_right(head, k):
    """
    Time: O(n), Space: O(1)
    Approach: Make circular, find new tail, break
    """
    if not head or not head.next or k == 0:
        return head

    # Find length and tail
    length = 1
    tail = head
    while tail.next:
        tail = tail.next
        length += 1

    # Make circular
    tail.next = head

    # Find new tail
    k = k % length
    steps = length - k
    new_tail = head
    for i in range(steps - 1):
        new_tail = new_tail.next

    new_head = new_tail.next
    new_tail.next = None

    return new_head


# ============================================================================
# TESTING
# ============================================================================

if __name__ == "__main__":
    print("=== Reverse List ===")
    head = create_linked_list([1, 2, 3, 4, 5])
    print("Original:", end=" ")
    print_list(head)
    head = reverse_list(head)
    print("Reversed:", end=" ")
    print_list(head)

    print("\n=== Find Middle ===")
    head = create_linked_list([1, 2, 3, 4, 5])
    middle = find_middle(head)
    print(f"Middle: {middle.val}")

    print("\n=== Has Cycle ===")
    head = create_linked_list([1, 2, 3, 4])
    print(f"Has cycle: {has_cycle(head)}")

    print("\n=== Merge Sorted Lists ===")
    l1 = create_linked_list([1, 3, 5])
    l2 = create_linked_list([2, 4, 6])
    merged = merge_two_sorted_lists(l1, l2)
    print("Merged:", end=" ")
    print_list(merged)

    print("\n=== Palindrome ===")
    head = create_linked_list([1, 2, 2, 1])
    print(f"Is palindrome: {is_palindrome(head)}")

    print("\n=== Add Two Numbers ===")
    l1 = create_linked_list([2, 4, 3])
    l2 = create_linked_list([5, 6, 4])
    result = add_two_numbers(l1, l2)
    print("342 + 465 =", end=" ")
    print_list(result)
