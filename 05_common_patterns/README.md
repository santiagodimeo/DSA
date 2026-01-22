# Common Patterns

**Duration**: 2-3 weeks | **Difficulty**: Intermediate to Advanced

Learn powerful patterns that appear across many problems.

## Overview

These patterns combine multiple data structures and algorithms to solve specific types of problems efficiently.

## Topics Covered

### [Prefix Sums](./prefix_sums/)

**Concept**: Pre-compute cumulative sums for fast range queries

**Use Cases**:
- Subarray sum queries
- Range sum queries
- 2D matrix sums

**Key Problems**:
- Range Sum Query
- Subarray Sum Equals K
- Contiguous Array

**Time Complexity**:
- Preprocessing: O(n)
- Query: O(1)

**Template**:
```python
# Build prefix sum
prefix = [0]
for num in arr:
    prefix.append(prefix[-1] + num)

# Query sum from i to j
range_sum = prefix[j+1] - prefix[i]
```

---

### [Greedy Algorithms](./greedy/)

**Concept**: Make locally optimal choice at each step

**When to Use**:
- Problem has optimal substructure
- Local optimal leads to global optimal
- Making choices that can't be undone

**Key Problems**:
- Activity Selection / Meeting Rooms
- Jump Game
- Gas Station
- Merge Intervals
- Task Scheduler

**Pattern Recognition**:
- "Minimum/Maximum with constraints"
- Interval scheduling
- Resource allocation

**Strategy**:
1. Sort by appropriate key
2. Make greedy choice
3. Prove it leads to optimal solution

---

### [Union-Find (Disjoint Set)](./union_find/)

**Concept**: Track connected components with near-constant time operations

**Use Cases**:
- Detect cycles in undirected graph
- Find connected components
- Network connectivity
- Kruskal's MST algorithm

**Key Problems**:
- Number of Connected Components
- Graph Valid Tree
- Redundant Connection
- Accounts Merge

**Operations**:
- `find(x)`: O(α(n)) ≈ O(1) - Find root of x
- `union(x, y)`: O(α(n)) ≈ O(1) - Connect x and y

**Template**:
```python
class UnionFind:
    def __init__(self, n):
        self.parent = list(range(n))
        self.rank = [0] * n

    def find(self, x):
        if self.parent[x] != x:
            self.parent[x] = self.find(self.parent[x])  # Path compression
        return self.parent[x]

    def union(self, x, y):
        root_x, root_y = self.find(x), self.find(y)
        if root_x == root_y:
            return False

        # Union by rank
        if self.rank[root_x] < self.rank[root_y]:
            self.parent[root_x] = root_y
        elif self.rank[root_x] > self.rank[root_y]:
            self.parent[root_y] = root_x
        else:
            self.parent[root_y] = root_x
            self.rank[root_x] += 1
        return True
```

---

### [Topological Sort](./topological_sort/)

**Concept**: Linear ordering of vertices in directed acyclic graph (DAG)

**Use Cases**:
- Task scheduling with dependencies
- Course prerequisites
- Build systems
- Compilation order

**Key Problems**:
- Course Schedule I & II
- Alien Dictionary
- Sequence Reconstruction

**Two Approaches**:

1. **Kahn's Algorithm (BFS)**:
   - Track in-degrees
   - Process nodes with 0 in-degree
   - O(V + E)

2. **DFS-based**:
   - Post-order DFS
   - Reverse the result
   - O(V + E)

**Template (Kahn's)**:
```python
def topological_sort(graph, n):
    in_degree = [0] * n
    for node in graph:
        for neighbor in graph[node]:
            in_degree[neighbor] += 1

    queue = [i for i in range(n) if in_degree[i] == 0]
    result = []

    while queue:
        node = queue.pop(0)
        result.append(node)

        for neighbor in graph[node]:
            in_degree[neighbor] -= 1
            if in_degree[neighbor] == 0:
                queue.append(neighbor)

    return result if len(result) == n else []
```

---

## Additional Patterns

### Monotonic Stack/Queue

**Concept**: Maintain elements in sorted order

**Use Cases**:
- Next greater/smaller element
- Largest rectangle in histogram
- Trapping rain water

### Trie (Prefix Tree)

**Concept**: Tree for storing strings with common prefixes

**Use Cases**:
- Autocomplete
- Word search
- Prefix matching

### Segment Tree / Fenwick Tree

**Concept**: Efficient range query and updates

**Use Cases**:
- Range sum with updates
- Range minimum query
- Interval queries

---

## Pattern Selection Guide

| Problem Type | Pattern | Time |
|--------------|---------|------|
| Range sum queries | Prefix Sum | O(1) query |
| Interval scheduling | Greedy | O(n log n) |
| Connected components | Union-Find | O(α(n)) |
| Task dependencies | Topological Sort | O(V + E) |
| Next greater element | Monotonic Stack | O(n) |
| String prefix matching | Trie | O(m) per query |
| Range queries with updates | Segment Tree | O(log n) |

---

## Practice Goals

By the end of this section:

- [ ] Implement prefix sum for range queries
- [ ] Recognize greedy problems and prove correctness
- [ ] Implement Union-Find with optimizations
- [ ] Apply topological sort to dependency problems
- [ ] Use monotonic stack for next greater/smaller
- [ ] Build and query Trie

---

## Prerequisites

Complete [Dynamic Programming](../04_dynamic_programming/) before starting.

## Next Steps

After mastering these patterns, tackle [Classic Challenges](../06_classic_challenges/) to apply everything you've learned.
