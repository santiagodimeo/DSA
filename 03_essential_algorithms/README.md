# Essential Algorithms

**Duration**: 4-5 weeks | **Difficulty**: Intermediate to Advanced

Master core algorithms that form the foundation of problem-solving.

## Learning Order

1. **Recursion & Backtracking** (5-7 days)
   - Base cases and recursive thinking
   - Subsets, permutations, combinations
   - N-Queens, Sudoku solver

2. **Binary Search** (3-4 days)
   - Search in sorted array
   - Search in rotated array
   - Search on answer space

3. **Sorting** (3-4 days)
   - Understanding key algorithms
   - When to use each
   - Custom comparators

4. **Graph Algorithms** (6-8 days)
   - Graph representations
   - BFS and DFS
   - Cycle detection
   - Topological sort

## Key Concepts

### Recursion
- Breaking problems into smaller subproblems
- Base case and recursive case
- Call stack understanding
- Tail recursion optimization

### Backtracking
- Exploring all possibilities
- Pruning invalid paths
- State management
- Choice → Explore → Unchoose pattern

### Graph Traversal
- BFS: Level by level (shortest path)
- DFS: Explore deep first (all paths)
- Connected components
- Cycle detection

## Topics Covered

### [01 - Recursion & Backtracking](./01_recursion_backtracking/)

**Key Problems**:
- Generate all subsets
- Permutations
- Combination sum
- N-Queens
- Word search

**Patterns**:
- Subsets pattern
- Permutations pattern
- Combinations pattern

### [02 - Binary Search](./02_binary_search/)

**Key Problems**:
- Search in rotated array
- Find first and last position
- Search insert position
- Find minimum in rotated array
- Koko eating bananas

**Templates**:
- Basic binary search
- Find boundary
- Search on answer space

### [03 - Sorting](./03_sorting/)

**Algorithms**:
- Quick Sort
- Merge Sort
- Heap Sort
- Counting Sort

**Key Problems**:
- Sort colors
- Merge intervals
- Largest number
- Custom comparators

### [04 - Graphs](./04_graphs/)

**Key Problems**:
- Number of islands
- Clone graph
- Course schedule (cycle detection)
- Word ladder (BFS)
- Pacific Atlantic water flow

**Patterns**:
- Graph representations
- BFS template
- DFS template
- Cycle detection
- Topological sort

## Practice Goals

By the end of this section:

- [ ] Write recursive solutions confidently
- [ ] Implement backtracking with proper state management
- [ ] Apply binary search to non-obvious problems
- [ ] Understand all major sorting algorithms
- [ ] Traverse graphs with BFS and DFS
- [ ] Detect cycles in graphs
- [ ] Implement topological sort

## Time Complexity Quick Reference

### Sorting
- Quick Sort: O(n log n) average, O(n²) worst
- Merge Sort: O(n log n) always
- Heap Sort: O(n log n) always
- Counting Sort: O(n + k) where k is range

### Binary Search
- O(log n) on sorted data
- O(log n) on answer space

### Graph Traversal
- BFS/DFS: O(V + E) where V=vertices, E=edges

## Prerequisites

Complete [Core Data Structures](../02_core_data_structures/) before starting.

## Next Steps

After completing Essential Algorithms, move to [Dynamic Programming](../04_dynamic_programming/).
