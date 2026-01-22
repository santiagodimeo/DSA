"""
BFS (Breadth-First Search) Templates

Templates for common BFS patterns on graphs and trees.
BFS explores level by level, using a queue.
"""

from collections import deque


# ============================================================================
# TEMPLATE 1: BFS on Graph
# ============================================================================

def bfs_graph(graph, start):
    """
    Basic BFS on graph represented as adjacency list.

    Args:
        graph: Dict mapping node -> list of neighbors
        start: Starting node

    Time: O(V + E) where V = vertices, E = edges
    Space: O(V) for queue and visited set

    Use cases:
    - Shortest path in unweighted graph
    - Level-order traversal
    - Connected components
    """
    visited = set([start])
    queue = deque([start])

    while queue:
        node = queue.popleft()
        print(node)  # Process node

        for neighbor in graph.get(node, []):
            if neighbor not in visited:
                visited.add(neighbor)
                queue.append(neighbor)

    return visited


# ============================================================================
# TEMPLATE 2: BFS with Level Tracking
# ============================================================================

def bfs_with_levels(graph, start):
    """
    BFS that tracks distance/level from start.

    Returns: Dict mapping node -> level
    """
    visited = {start: 0}  # Maps node -> level
    queue = deque([start])

    while queue:
        node = queue.popleft()
        current_level = visited[node]

        for neighbor in graph.get(node, []):
            if neighbor not in visited:
                visited[neighbor] = current_level + 1
                queue.append(neighbor)

    return visited


# ============================================================================
# TEMPLATE 3: BFS on Binary Tree (Level Order)
# ============================================================================

class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right


def level_order_traversal(root):
    """
    Level-order traversal of binary tree.

    Returns: List of lists, each inner list is one level

    Time: O(n) where n = number of nodes
    Space: O(w) where w = max width of tree
    """
    if not root:
        return []

    result = []
    queue = deque([root])

    while queue:
        level_size = len(queue)
        current_level = []

        # Process all nodes in current level
        for _ in range(level_size):
            node = queue.popleft()
            current_level.append(node.val)

            # Add children for next level
            if node.left:
                queue.append(node.left)
            if node.right:
                queue.append(node.right)

        result.append(current_level)

    return result


def level_order_bottom_up(root):
    """
    Level-order traversal from bottom to top.

    Returns: List of lists, bottom level first
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

    return result[::-1]  # Reverse to get bottom-up


# ============================================================================
# TEMPLATE 4: BFS for Shortest Path
# ============================================================================

def shortest_path_bfs(graph, start, end):
    """
    Find shortest path between start and end in unweighted graph.

    Returns: Length of shortest path, or -1 if no path exists
    """
    if start == end:
        return 0

    visited = set([start])
    queue = deque([(start, 0)])  # (node, distance)

    while queue:
        node, dist = queue.popleft()

        for neighbor in graph.get(node, []):
            if neighbor == end:
                return dist + 1

            if neighbor not in visited:
                visited.add(neighbor)
                queue.append((neighbor, dist + 1))

    return -1  # No path found


def shortest_path_with_route(graph, start, end):
    """
    Find shortest path and return the actual route.

    Returns: List representing path, or None if no path
    """
    if start == end:
        return [start]

    visited = set([start])
    queue = deque([(start, [start])])  # (node, path)

    while queue:
        node, path = queue.popleft()

        for neighbor in graph.get(node, []):
            if neighbor == end:
                return path + [end]

            if neighbor not in visited:
                visited.add(neighbor)
                queue.append((neighbor, path + [neighbor]))

    return None


# ============================================================================
# TEMPLATE 5: Multi-Source BFS
# ============================================================================

def multi_source_bfs(graph, sources):
    """
    BFS from multiple starting points simultaneously.

    Use cases:
    - Rotten oranges problem
    - Walls and gates
    - 01 Matrix

    Returns: Dict mapping node -> distance from nearest source
    """
    visited = {}
    queue = deque()

    # Initialize queue with all sources
    for source in sources:
        visited[source] = 0
        queue.append(source)

    while queue:
        node = queue.popleft()
        current_dist = visited[node]

        for neighbor in graph.get(node, []):
            if neighbor not in visited:
                visited[neighbor] = current_dist + 1
                queue.append(neighbor)

    return visited


# ============================================================================
# TEMPLATE 6: BFS on 2D Grid
# ============================================================================

def bfs_grid(grid, start_row, start_col):
    """
    BFS on 2D grid.

    Use cases:
    - Shortest path in maze
    - Flood fill
    - Island perimeter

    Time: O(rows × cols)
    Space: O(rows × cols)
    """
    rows, cols = len(grid), len(grid[0])
    visited = set([(start_row, start_col)])
    queue = deque([(start_row, start_col, 0)])  # (row, col, distance)

    # 4 directions: up, down, left, right
    directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]

    while queue:
        row, col, dist = queue.popleft()
        print(f"Visiting ({row}, {col}) at distance {dist}")

        for dr, dc in directions:
            new_row, new_col = row + dr, col + dc

            # Check bounds and visited
            if (0 <= new_row < rows and
                0 <= new_col < cols and
                (new_row, new_col) not in visited and
                grid[new_row][new_col] == 1):  # Adjust condition

                visited.add((new_row, new_col))
                queue.append((new_row, new_col, dist + 1))

    return visited


def bfs_grid_shortest_path(grid, start, end):
    """
    Find shortest path in grid from start to end.

    Args:
        grid: 2D list (1 = walkable, 0 = wall)
        start: (row, col) tuple
        end: (row, col) tuple

    Returns: Shortest path length, or -1 if no path
    """
    if start == end:
        return 0

    rows, cols = len(grid), len(grid[0])
    start_row, start_col = start
    end_row, end_col = end

    visited = set([start])
    queue = deque([(start_row, start_col, 0)])

    directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]

    while queue:
        row, col, dist = queue.popleft()

        for dr, dc in directions:
            new_row, new_col = row + dr, col + dc

            if new_row == end_row and new_col == end_col:
                return dist + 1

            if (0 <= new_row < rows and
                0 <= new_col < cols and
                (new_row, new_col) not in visited and
                grid[new_row][new_col] == 1):

                visited.add((new_row, new_col))
                queue.append((new_row, new_col, dist + 1))

    return -1


# ============================================================================
# TEMPLATE 7: BFS for Bipartite Graph
# ============================================================================

def is_bipartite(graph, n):
    """
    Check if graph can be colored with 2 colors (bipartite).

    Uses BFS to try to color graph with alternating colors.

    Returns: True if bipartite, False otherwise
    """
    color = [-1] * n  # -1 = uncolored, 0/1 = colors

    for start in range(n):
        if color[start] == -1:
            queue = deque([start])
            color[start] = 0

            while queue:
                node = queue.popleft()
                current_color = color[node]

                for neighbor in graph.get(node, []):
                    if color[neighbor] == -1:
                        # Color with opposite color
                        color[neighbor] = 1 - current_color
                        queue.append(neighbor)
                    elif color[neighbor] == current_color:
                        # Same color as current = not bipartite
                        return False

    return True


# ============================================================================
# TEMPLATE 8: 0-1 BFS (Weighted BFS)
# ============================================================================

def bfs_01_weighted(graph, start, end):
    """
    BFS for graphs with edge weights of 0 or 1.

    Use deque as double-ended queue:
    - Edges with weight 0: add to front (higher priority)
    - Edges with weight 1: add to back (lower priority)

    Time: O(V + E)
    Space: O(V)

    Returns: Shortest distance
    """
    dist = {start: 0}
    queue = deque([start])

    while queue:
        node = queue.popleft()

        for neighbor, weight in graph.get(node, []):
            new_dist = dist[node] + weight

            if neighbor not in dist or new_dist < dist[neighbor]:
                dist[neighbor] = new_dist

                if weight == 0:
                    queue.appendleft(neighbor)  # Priority: front
                else:
                    queue.append(neighbor)       # Normal: back

    return dist.get(end, -1)


# ============================================================================
# TESTING
# ============================================================================

if __name__ == "__main__":
    # Test graph BFS
    graph = {
        0: [1, 2],
        1: [0, 3, 4],
        2: [0, 5],
        3: [1],
        4: [1],
        5: [2]
    }

    print("BFS from node 0:")
    bfs_graph(graph, 0)

    print("\nBFS with levels:")
    levels = bfs_with_levels(graph, 0)
    print(levels)

    # Test tree BFS
    root = TreeNode(1)
    root.left = TreeNode(2)
    root.right = TreeNode(3)
    root.left.left = TreeNode(4)
    root.left.right = TreeNode(5)
    root.right.right = TreeNode(6)

    print("\nLevel Order Traversal:")
    print(level_order_traversal(root))

    print("\nLevel Order (Bottom-Up):")
    print(level_order_bottom_up(root))

    # Test shortest path
    print("\nShortest path 0 to 5:")
    print(shortest_path_bfs(graph, 0, 5))

    print("\nShortest path with route:")
    print(shortest_path_with_route(graph, 0, 5))

    # Test grid BFS
    grid = [
        [1, 1, 0, 1],
        [1, 0, 0, 1],
        [1, 1, 1, 1]
    ]

    print("\nGrid BFS from (0, 0):")
    bfs_grid(grid, 0, 0)

    print("\nShortest path in grid from (0,0) to (2,3):")
    print(bfs_grid_shortest_path(grid, (0, 0), (2, 3)))

    # Test bipartite
    bipartite_graph = {
        0: [1, 3],
        1: [0, 2],
        2: [1, 3],
        3: [0, 2]
    }
    print("\nIs bipartite:", is_bipartite(bipartite_graph, 4))
