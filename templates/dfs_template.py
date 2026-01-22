"""
DFS (Depth-First Search) Templates

Templates for common DFS patterns on graphs and trees.
"""


# ============================================================================
# TEMPLATE 1: DFS on Graph (Adjacency List)
# ============================================================================

def dfs_graph_recursive(graph, start, visited=None):
    """
    Recursive DFS on graph represented as adjacency list.

    Args:
        graph: Dict mapping node -> list of neighbors
        start: Starting node
        visited: Set of visited nodes

    Time: O(V + E) where V = vertices, E = edges
    Space: O(V) for visited set and recursion stack
    """
    if visited is None:
        visited = set()

    visited.add(start)
    print(start)  # Process node

    for neighbor in graph.get(start, []):
        if neighbor not in visited:
            dfs_graph_recursive(graph, neighbor, visited)

    return visited


def dfs_graph_iterative(graph, start):
    """
    Iterative DFS using stack.

    Time: O(V + E)
    Space: O(V) for stack and visited set
    """
    visited = set()
    stack = [start]

    while stack:
        node = stack.pop()

        if node not in visited:
            visited.add(node)
            print(node)  # Process node

            # Add neighbors in reverse order to match recursive DFS
            for neighbor in reversed(graph.get(node, [])):
                if neighbor not in visited:
                    stack.append(neighbor)

    return visited


# ============================================================================
# TEMPLATE 2: DFS on Binary Tree
# ============================================================================

class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right


def dfs_tree_preorder(root):
    """
    Preorder: Root → Left → Right

    Use case: Create copy of tree, prefix expression
    """
    if not root:
        return []

    result = []
    result.append(root.val)  # Process root
    result.extend(dfs_tree_preorder(root.left))   # Left subtree
    result.extend(dfs_tree_preorder(root.right))  # Right subtree
    return result


def dfs_tree_inorder(root):
    """
    Inorder: Left → Root → Right

    Use case: Get sorted values from BST
    """
    if not root:
        return []

    result = []
    result.extend(dfs_tree_inorder(root.left))   # Left subtree
    result.append(root.val)  # Process root
    result.extend(dfs_tree_inorder(root.right))  # Right subtree
    return result


def dfs_tree_postorder(root):
    """
    Postorder: Left → Right → Root

    Use case: Delete tree, postfix expression
    """
    if not root:
        return []

    result = []
    result.extend(dfs_tree_postorder(root.left))   # Left subtree
    result.extend(dfs_tree_postorder(root.right))  # Right subtree
    result.append(root.val)  # Process root
    return result


# ============================================================================
# TEMPLATE 3: DFS for Path Finding
# ============================================================================

def find_path_dfs(graph, start, end, path=None):
    """
    Find a path from start to end using DFS.

    Returns: List representing path, or None if no path exists
    """
    if path is None:
        path = []

    path = path + [start]

    if start == end:
        return path

    for neighbor in graph.get(start, []):
        if neighbor not in path:  # Avoid cycles
            new_path = find_path_dfs(graph, neighbor, end, path)
            if new_path:
                return new_path

    return None


def find_all_paths_dfs(graph, start, end, path=None):
    """
    Find all paths from start to end using DFS.

    Returns: List of all possible paths
    """
    if path is None:
        path = []

    path = path + [start]

    if start == end:
        return [path]

    paths = []
    for neighbor in graph.get(start, []):
        if neighbor not in path:
            new_paths = find_all_paths_dfs(graph, neighbor, end, path)
            paths.extend(new_paths)

    return paths


# ============================================================================
# TEMPLATE 4: DFS with Backtracking
# ============================================================================

def dfs_backtracking_template(choices):
    """
    Generic backtracking template.

    Pattern: Choose → Explore → Unchoose
    """
    result = []

    def backtrack(current_state, remaining_choices):
        # Base case: Found valid solution
        if is_valid_solution(current_state):
            result.append(current_state[:])  # Copy current state
            return

        # Try each choice
        for choice in remaining_choices:
            # Make choice
            current_state.append(choice)

            # Explore with this choice
            backtrack(current_state, get_next_choices(choice, remaining_choices))

            # Unmake choice (backtrack)
            current_state.pop()

    def is_valid_solution(state):
        # Define what makes a valid solution
        return True  # Implement based on problem

    def get_next_choices(choice, remaining):
        # Get available choices for next step
        return []  # Implement based on problem

    backtrack([], choices)
    return result


# ============================================================================
# TEMPLATE 5: DFS for Cycle Detection
# ============================================================================

def has_cycle_undirected(graph, n):
    """
    Detect cycle in undirected graph.

    Args:
        graph: Adjacency list
        n: Number of nodes (0 to n-1)

    Returns: True if cycle exists
    """
    visited = set()

    def dfs(node, parent):
        visited.add(node)

        for neighbor in graph.get(node, []):
            if neighbor not in visited:
                if dfs(neighbor, node):
                    return True
            elif neighbor != parent:
                # Visited neighbor that's not parent = cycle
                return True

        return False

    # Check all components
    for node in range(n):
        if node not in visited:
            if dfs(node, -1):
                return True

    return False


def has_cycle_directed(graph, n):
    """
    Detect cycle in directed graph using colors.

    White (0): Not visited
    Gray (1): In current DFS path
    Black (2): Completely processed

    Returns: True if cycle exists
    """
    color = [0] * n  # 0=white, 1=gray, 2=black

    def dfs(node):
        color[node] = 1  # Mark as being processed

        for neighbor in graph.get(node, []):
            if color[neighbor] == 1:
                # Back edge found = cycle
                return True
            if color[neighbor] == 0:
                if dfs(neighbor):
                    return True

        color[node] = 2  # Mark as completely processed
        return False

    for node in range(n):
        if color[node] == 0:
            if dfs(node):
                return True

    return False


# ============================================================================
# TEMPLATE 6: DFS on 2D Grid
# ============================================================================

def dfs_grid(grid, row, col, visited=None):
    """
    DFS on 2D grid (for problems like islands, flood fill).

    Args:
        grid: 2D list
        row, col: Starting position
        visited: Set of (row, col) tuples

    Time: O(rows × cols)
    Space: O(rows × cols) for recursion and visited
    """
    if visited is None:
        visited = set()

    rows, cols = len(grid), len(grid[0])

    # Base cases
    if (row < 0 or row >= rows or
        col < 0 or col >= cols or
        (row, col) in visited or
        grid[row][col] == 0):  # Adjust condition based on problem
        return

    visited.add((row, col))
    # Process cell
    print(f"Visiting ({row}, {col})")

    # Explore 4 directions: up, down, left, right
    directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
    for dr, dc in directions:
        dfs_grid(grid, row + dr, col + dc, visited)

    return visited


# ============================================================================
# TEMPLATE 7: DFS with Memoization
# ============================================================================

def dfs_with_memo(graph, start, target, memo=None):
    """
    DFS with memoization for optimization.

    Use when subproblems overlap.
    """
    if memo is None:
        memo = {}

    if start in memo:
        return memo[start]

    if start == target:
        return True

    for neighbor in graph.get(start, []):
        if dfs_with_memo(graph, neighbor, target, memo):
            memo[start] = True
            return True

    memo[start] = False
    return False


# ============================================================================
# TESTING
# ============================================================================

if __name__ == "__main__":
    # Test graph DFS
    graph = {
        0: [1, 2],
        1: [0, 3, 4],
        2: [0, 5],
        3: [1],
        4: [1],
        5: [2]
    }

    print("DFS Recursive:")
    dfs_graph_recursive(graph, 0)

    print("\nDFS Iterative:")
    dfs_graph_iterative(graph, 0)

    # Test tree DFS
    root = TreeNode(1)
    root.left = TreeNode(2)
    root.right = TreeNode(3)
    root.left.left = TreeNode(4)
    root.left.right = TreeNode(5)

    print("\nPreorder:", dfs_tree_preorder(root))
    print("Inorder:", dfs_tree_inorder(root))
    print("Postorder:", dfs_tree_postorder(root))

    # Test path finding
    print("\nFind path 0 to 5:", find_path_dfs(graph, 0, 5))
    print("All paths 0 to 5:", find_all_paths_dfs(graph, 0, 5))

    # Test cycle detection
    graph_with_cycle = {0: [1], 1: [2], 2: [0]}
    print("\nHas cycle (directed):", has_cycle_directed(graph_with_cycle, 3))

    # Test grid DFS
    grid = [
        [1, 1, 0],
        [1, 0, 0],
        [0, 1, 1]
    ]
    print("\nGrid DFS from (0,0):")
    dfs_grid(grid, 0, 0)
