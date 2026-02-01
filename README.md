# Data Structures & Algorithms - Complete Learning Path

A comprehensive, structured repository for mastering DSA with **Python** and **Ruby**. This guide focuses on practical knowledge needed for software engineering interviews and real-world problem-solving.

## Language Support

All topics are implemented in both **Python** and **Ruby**, allowing you to:
- Learn DSA concepts in your preferred language
- Compare implementations across languages
- Practice with the language used in your interviews
- Understand how the same algorithm works in different paradigms

### File Organization

Files are organized side-by-side in the same directories:
```
01_foundations/01_big_o_notation/
├── theory.md              # Language-agnostic concepts
├── demonstrations.py      # Python examples
├── demonstrations.rb      # Ruby examples
├── exercises.py           # Python practice problems
├── exercises.rb           # Ruby practice problems
├── solutions.py           # Python solutions
└── solutions.rb           # Ruby solutions
```

### Choosing a Language

**Choose Python if:**
- You're interviewing at companies that prefer Python
- You want maximum library support for algorithms
- You prefer explicit, readable syntax
- You're already familiar with Python

**Choose Ruby if:**
- You're interviewing at companies that use Ruby (Rails shops, etc.)
- You appreciate expressive, elegant syntax
- You want to leverage powerful enumerable methods
- You're already familiar with Ruby

**Use Both if:**
- You want to deepen your understanding by comparing approaches
- You're learning DSA for the first time (comparing helps solidify concepts)
- You want to be language-agnostic in your problem-solving skills

### Ruby-Specific Features Used

The Ruby implementations leverage idiomatic Ruby:
- **Blocks and Enumerables**: `.each`, `.map`, `.select`, `.reduce`
- **Hash and Set**: `Hash.new(0)`, `Set.new`, set operations
- **Array Methods**: `.push`, `.pop`, `.shift`, `.unshift`, `.first`, `.last`
- **Predicate Methods**: Methods ending in `?` for boolean returns
- **Safe Navigation**: `&.` operator for nil-safe method chaining
- **Range Syntax**: `(0...n)` and `(0..n)`
- **Symbols**: Used for hash keys where appropriate
- **Duck Typing**: Ruby's dynamic nature for flexible implementations

## Learning Path Overview

**Total Duration**: 3-4 months of consistent study (10-15 hours/week)

```
Foundations → Core Data Structures → Essential Algorithms → Dynamic Programming → Patterns → Classic Challenges
```

## How to Use This Repository

1. **Read Theory First**: Each topic has a `theory.md` file - start here
2. **Study Demonstrations**: Review `demonstrations.py` or `demonstrations.rb` to see concepts in action
3. **Practice Exercises**: Implement solutions in `exercises.py` or `exercises.rb`
4. **Check Solutions**: Compare with `solutions.py` or `solutions.rb` after attempting
5. **Run Tests**: Validate your implementations with `pytest` (Python) or `rspec` (Ruby)

## Progress Tracker

### Phase 1: Foundations (2-3 weeks)
- [ ] Big O Notation
- [ ] Arrays
- [ ] Strings
- [ ] Hash Tables
- [ ] Techniques: Two Pointers, Sliding Window, Frequency Counting

### Phase 2: Core Data Structures (3-4 weeks)
- [ ] Linked Lists
- [ ] Stacks & Queues
- [ ] Trees (Binary Trees, BST)
- [ ] Heaps
- [ ] Techniques: Fast/Slow Pointers, Monotonic Stack, Level Order Traversal

### Phase 3: Essential Algorithms (4-5 weeks)
- [ ] Recursion & Backtracking
- [ ] Binary Search
- [ ] Sorting Algorithms
- [ ] Graph Algorithms (BFS, DFS)

### Phase 4: Dynamic Programming (3-4 weeks)
- [ ] 1D Dynamic Programming
- [ ] 2D Dynamic Programming
- [ ] Common DP Patterns

### Phase 5: Common Patterns (2-3 weeks)
- [ ] Prefix Sums
- [ ] Greedy Algorithms
- [ ] Union-Find
- [ ] Topological Sort

### Phase 6: Classic Challenges (Ongoing)
- [ ] LRU Cache
- [ ] Connect 4
- [ ] Design Twitter
- [ ] Design File System
- [ ] Rate Limiter
- [ ] Trie Autocomplete
- [ ] Calculator
- [ ] Game of Life

## Repository Structure

```
DSA/
├── 01_foundations/           # Week 1-3: Arrays, Strings, Hash Tables
├── 02_core_data_structures/  # Week 4-7: Lists, Stacks, Trees, Heaps
├── 03_essential_algorithms/  # Week 8-12: Recursion, Search, Graphs
├── 04_dynamic_programming/   # Week 13-16: DP fundamentals
├── 05_common_patterns/       # Week 17-19: Advanced patterns
├── 06_classic_challenges/    # Ongoing: Real interview problems
└── templates/                # Code templates for quick reference
```

## Setup

### Python Setup
```bash
# Clone the repository
git clone git@github.com:santiagodimeo/DSA.git
cd DSA

# Install Python dependencies
pip install -r requirements.txt

# Run Python tests
pytest
```

### Ruby Setup
```bash
# Install Ruby dependencies
bundle install

# Run Ruby tests
rspec

# Run tests with coverage
rspec --format documentation
```

## Study Schedule Template

### Daily Routine (1.5-2 hours)
- **30 min**: Read theory
- **30 min**: Study demonstrations
- **45 min**: Solve exercises
- **15 min**: Review and take notes

### Weekly Goals
- Complete 1-2 topics
- Solve 10-15 exercises
- Review previous week's material

## Resources

### External Practice
- [LeetCode](https://leetcode.com/) - 150-200 problems recommended
- [NeetCode 150](https://neetcode.io/) - Curated problem list
- [Grind 75](https://www.techinterviewhandbook.org/grind75) - Structured study plan

### Difficulty Distribution
- **Easy**: 40% (build fundamentals)
- **Medium**: 55% (interview focus)
- **Hard**: 5% (challenge yourself)

## Problem-Solving Framework

When tackling any problem:

1. **Understand**: Clarify inputs, outputs, constraints
2. **Examples**: Work through 2-3 test cases manually
3. **Approach**: Think of brute force → optimize
4. **Implement**: Write clean, working code
5. **Test**: Verify with edge cases
6. **Analyze**: Time and space complexity

## Tips for Success

- **Consistency > Intensity**: Study daily, even if just 30 minutes
- **Understand, Don't Memorize**: Focus on patterns and principles
- **Spaced Repetition**: Review problems after 1 day, 1 week, 1 month
- **Time Yourself**: Practice with 30-45 minute limits
- **Debug Without Running**: Read code to find errors
- **Explain Solutions**: Teaching solidifies understanding

## Quick Reference

### Time Complexities
- O(1) - Constant
- O(log n) - Logarithmic (Binary Search)
- O(n) - Linear (Single Pass)
- O(n log n) - Linearithmic (Efficient Sorting)
- O(n²) - Quadratic (Nested Loops)
- O(2ⁿ) - Exponential (Recursion with branching)

### Common Patterns Recognition
- **Two pointers**: Sorted array, palindrome, pair sum
- **Sliding window**: Subarray/substring problems
- **BFS**: Shortest path, level-order
- **DFS**: Explore all paths, backtracking
- **DP**: Optimal substructure, overlapping subproblems
- **Greedy**: Local optimal → global optimal

## Navigation

- [01 - Foundations](./01_foundations/README.md)
- [02 - Core Data Structures](./02_core_data_structures/README.md)
- [03 - Essential Algorithms](./03_essential_algorithms/README.md)
- [04 - Dynamic Programming](./04_dynamic_programming/README.md)
- [05 - Common Patterns](./05_common_patterns/README.md)
- [06 - Classic Challenges](./06_classic_challenges/README.md)
- [Templates](./templates/)

## Contributing

This is a personal learning repository. Feel free to fork and adapt for your own study!

## License

MIT License - Feel free to use for learning purposes.
