# Classic Challenges

**Difficulty**: Medium to Hard | **Purpose**: Interview Preparation

Real interview problems that combine multiple concepts. These challenges frequently appear in FAANG interviews.

## How to Use This Section

1. **Read `problem.md`** - Understand requirements fully
2. **Attempt on your own** - Spend 30-45 minutes trying
3. **Use `hints.md`** - Progressive hints if stuck
4. **Study `solution.py`** - Complete implementation with explanations
5. **Run `test_*.py`** - Verify your understanding
6. **Re-implement** - Code it again without looking

## Challenges

### [LRU Cache](./lru_cache/)
**Difficulty**: Hard
**Topics**: Hash Map, Doubly Linked List, Design
**Companies**: Amazon, Google, Microsoft, Meta

Design a cache with O(1) get and put operations.

**Key Concepts**:
- Combining data structures
- Order maintenance
- Eviction policies

---

### [Connect 4](./connect_4/)
**Difficulty**: Medium
**Topics**: Game Logic, 2D Arrays, Win Detection
**Companies**: Meta, Amazon

Implement the classic Connect 4 game.

**Key Concepts**:
- Game state management
- Win condition checking
- Board representation

---

### [Design Twitter](./design_twitter/)
**Difficulty**: Medium-Hard
**Topics**: Hash Map, Heap, Design
**Companies**: Twitter (X), Meta, Amazon

Design a simplified version of Twitter.

**Features**:
- Post tweet
- Get news feed (merge k sorted lists)
- Follow/unfollow

**Key Concepts**:
- Multi-user system design
- Timeline generation
- K-way merge

---

### [Design File System](./design_file_system/)
**Difficulty**: Medium
**Topics**: Trie, Hash Map, Design
**Companies**: Amazon, Google, Dropbox

Design a file system with paths.

**Operations**:
- Create path
- Get value
- List children

**Key Concepts**:
- Hierarchical data
- Trie/prefix tree
- Path parsing

---

### [Rate Limiter](./rate_limiter/)
**Difficulty**: Medium
**Topics**: Queue, Design, Sliding Window
**Companies**: Amazon, Meta, Stripe

Design a rate limiter.

**Algorithms**:
- Fixed window
- Sliding window
- Token bucket
- Leaky bucket

**Key Concepts**:
- Time-based constraints
- Scalability
- Trade-offs

---

### [Trie Autocomplete](./trie_autocomplete/)
**Difficulty**: Medium
**Topics**: Trie, DFS, Design
**Companies**: Google, Amazon, Meta

Build an autocomplete system.

**Features**:
- Insert words
- Search prefix
- Auto-suggestions

**Key Concepts**:
- Trie structure
- Prefix matching
- DFS for word collection

---

### [Calculator](./calculator/)
**Difficulty**: Medium-Hard
**Topics**: Stack, String Parsing
**Companies**: Meta, Google, Amazon

Implement a basic/scientific calculator.

**Versions**:
1. Basic: `+`, `-`, `*`, `/`
2. With parentheses
3. With functions (sin, cos, sqrt)

**Key Concepts**:
- Operator precedence
- Stack-based evaluation
- Expression parsing

---

### [Game of Life](./game_of_life/)
**Difficulty**: Medium
**Topics**: 2D Array, Simulation, In-place
**Companies**: Google, Dropbox, Amazon

Simulate Conway's Game of Life.

**Rules**:
1. Live cell with 2-3 neighbors survives
2. Dead cell with 3 neighbors becomes alive
3. All other cells die or stay dead

**Key Concepts**:
- In-place modification
- State encoding
- Neighbor counting

---

## Additional Challenges (To Be Added)

Future additions will include:

- **Min Stack**: Stack with O(1) minimum retrieval
- **Serialize/Deserialize Binary Tree**: Tree to string and back
- **Word Search II**: Trie + backtracking on grid
- **Design HashMap**: Implement from scratch
- **Moving Average**: Sliding window on stream
- **Insert Delete GetRandom O(1)**: Array + hash map combo
- **Design Tic-Tac-Toe**: Optimized win detection
- **Implement strStr()**: String matching (KMP)

---

## Difficulty Breakdown

### Medium Challenges
- Connect 4
- Trie Autocomplete
- Design File System
- Rate Limiter
- Game of Life

### Hard Challenges
- LRU Cache
- Design Twitter
- Calculator (with parentheses)

---

## Learning Objectives

These challenges teach you to:

1. **Combine Data Structures**: Use multiple DS together effectively
2. **Design APIs**: Think about interface design
3. **Optimize**: Balance time vs space complexity
4. **Handle Edge Cases**: Comprehensive testing
5. **Write Clean Code**: Production-quality implementations
6. **Explain Trade-offs**: Justify design decisions

---

## Interview Tips

When solving design problems:

1. **Clarify Requirements**:
   - What operations are needed?
   - What are the constraints?
   - What are the performance requirements?

2. **Start with Interface**:
   - Define the API first
   - What methods are needed?
   - What are inputs and outputs?

3. **Choose Data Structures**:
   - What operations are most frequent?
   - What complexity is required?
   - Can you combine structures?

4. **Implement Core Functionality**:
   - Start with basic version
   - Test with examples
   - Handle edge cases

5. **Optimize**:
   - Identify bottlenecks
   - Trade-offs between time and space
   - Can you do better?

6. **Discuss Extensions**:
   - How would you scale?
   - What about concurrency?
   - Additional features?

---

## Testing Your Solutions

Each challenge includes comprehensive tests:

```bash
# Run tests for a specific challenge
pytest 06_classic_challenges/lru_cache/test_lru_cache.py -v

# Run all challenge tests
pytest 06_classic_challenges/ -v
```

---

## Time Allocation

Spend quality time on each:
- LRU Cache: 2-3 hours
- Design problems: 1-2 hours each
- Game implementations: 1-2 hours each

Don't rush. Understanding one problem deeply is better than superficially solving many.

---

## Real Interview Context

These problems appear in:
- **Phone Screens**: LRU Cache, Basic Calculator
- **Onsite Rounds**: Design Twitter, Rate Limiter
- **System Design**: File System, Rate Limiter (scaled)

Master these, and you'll be well-prepared for top tech company interviews.

---

## Prerequisites

You should be comfortable with all previous sections before attempting these challenges.

## Next Steps

After mastering these classics:
1. Practice on LeetCode/HackerRank
2. Join mock interviews
3. Participate in coding contests
4. Build real projects using these patterns
