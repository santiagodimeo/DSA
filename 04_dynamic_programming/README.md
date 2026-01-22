# Dynamic Programming

**Duration**: 3-4 weeks | **Difficulty**: Advanced

Master the art of breaking down complex problems using memoization and tabulation.

## What is Dynamic Programming?

Dynamic Programming (DP) is an optimization technique that:
- Breaks problems into overlapping subproblems
- Stores solutions to avoid recomputation
- Builds solutions bottom-up or top-down

## When to Use DP?

Use DP when a problem has:

1. **Optimal Substructure**: Solution can be built from optimal solutions to subproblems
2. **Overlapping Subproblems**: Same subproblems solved multiple times

## Two Approaches

### Top-Down (Memoization)
- Start with original problem
- Recursively break down
- Cache results in memo
- Natural to write

### Bottom-Up (Tabulation)
- Start with base cases
- Build up to final solution
- Use DP table/array
- Often more space efficient

## Learning Order

1. **1D Dynamic Programming** (5-7 days)
   - Single array/variable
   - Sequential decisions
   - Classic problems

2. **2D Dynamic Programming** (7-10 days)
   - Grid-based problems
   - String matching
   - Path counting

3. **Common Patterns** (5-7 days)
   - Knapsack variants
   - Subsequence problems
   - Grid paths

## Topics Covered

### [01 - 1D Dynamic Programming](./01_1d_dp/)

**Key Problems**:
- Climbing Stairs
- House Robber
- Coin Change
- Longest Increasing Subsequence
- Word Break

**Pattern Recognition**:
- `dp[i]` depends on `dp[i-1]`, `dp[i-2]`, etc.
- Current decision affects future options

### [02 - 2D Dynamic Programming](./02_2d_dp/)

**Key Problems**:
- Longest Common Subsequence
- Edit Distance
- Unique Paths
- Minimum Path Sum
- Regular Expression Matching

**Pattern Recognition**:
- `dp[i][j]` depends on `dp[i-1][j]`, `dp[i][j-1]`, etc.
- Two sequences or grid-based

### [Patterns](./patterns/)

#### Knapsack Pattern
- 0/1 Knapsack
- Unbounded Knapsack
- Partition Equal Subset Sum

#### Subsequence Pattern
- Longest Common Subsequence
- Longest Increasing Subsequence
- Longest Palindromic Subsequence

#### Grid Paths
- Unique Paths
- Minimum Path Sum
- Dungeon Game

## DP Problem-Solving Framework

### Step 1: Identify DP Problem
Look for:
- "Maximum/Minimum"
- "Count number of ways"
- "Longest/Shortest"
- Optimization problems

### Step 2: Define State
What information do you need to track?
- `dp[i]` = optimal solution for first i elements
- `dp[i][j]` = optimal solution for subproblem (i, j)

### Step 3: Find Recurrence Relation
How does `dp[i]` relate to previous states?
- `dp[i] = min(dp[i-1], dp[i-2]) + cost[i]`

### Step 4: Define Base Cases
What are the smallest subproblems?
- `dp[0] = 0` or `dp[0] = 1`

### Step 5: Determine Iteration Order
Build from base cases up.

### Step 6: Optimize Space
Can you use O(1) or O(n) instead of O(n²)?

## Example: Fibonacci

### Recursive (Exponential - O(2ⁿ))
```python
def fib(n):
    if n <= 1:
        return n
    return fib(n-1) + fib(n-2)
```

### Memoization (Linear - O(n))
```python
def fib(n, memo={}):
    if n <= 1:
        return n
    if n in memo:
        return memo[n]
    memo[n] = fib(n-1, memo) + fib(n-2, memo)
    return memo[n]
```

### Tabulation (Linear - O(n))
```python
def fib(n):
    if n <= 1:
        return n
    dp = [0] * (n + 1)
    dp[1] = 1
    for i in range(2, n + 1):
        dp[i] = dp[i-1] + dp[i-2]
    return dp[n]
```

### Space Optimized (Linear time, Constant space - O(1))
```python
def fib(n):
    if n <= 1:
        return n
    prev, curr = 0, 1
    for _ in range(2, n + 1):
        prev, curr = curr, prev + curr
    return curr
```

## Common DP Patterns

### Pattern 1: Linear DP
```python
dp[i] = f(dp[i-1], dp[i-2], ...)
```
Examples: Climbing Stairs, House Robber

### Pattern 2: Grid DP
```python
dp[i][j] = f(dp[i-1][j], dp[i][j-1], dp[i-1][j-1])
```
Examples: Unique Paths, Edit Distance

### Pattern 3: Subsequence DP
```python
if s1[i] == s2[j]:
    dp[i][j] = dp[i-1][j-1] + 1
else:
    dp[i][j] = max(dp[i-1][j], dp[i][j-1])
```
Examples: LCS, LIS

### Pattern 4: Knapsack
```python
for item in items:
    for capacity in range(max_cap, weight-1, -1):
        dp[capacity] = max(dp[capacity], dp[capacity-weight] + value)
```

## Practice Goals

By the end of this section:

- [ ] Recognize DP problems
- [ ] Define state and recurrence relation
- [ ] Implement both memoization and tabulation
- [ ] Optimize space complexity
- [ ] Solve classic DP problems
- [ ] Apply DP patterns to new problems

## Tips for Success

1. **Start Simple**: Master 1D before 2D
2. **Draw Tables**: Visualize the DP table
3. **Trace Examples**: Work through by hand first
4. **Patterns Matter**: Learn patterns, not just problems
5. **Space Optimization**: Consider after getting working solution
6. **Practice**: DP requires lots of practice to internalize

## Common Mistakes

- Forgetting base cases
- Wrong iteration order
- Not handling edge cases
- Index out of bounds errors
- Incorrect state definition

## Prerequisites

Complete [Essential Algorithms](../03_essential_algorithms/), especially recursion.

## Next Steps

After completing Dynamic Programming, move to [Common Patterns](../05_common_patterns/).
