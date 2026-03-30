## hase 1: Solidify the Core (Current State)

Docker = dependency hell solved
Redis = state/cache hell solved
Docgen = doc hell solved

## for 0.3.0
### Onboarding
Implement `docgen onboard` command

`$ docgen onboard`
This takes a documentation repository (.docgen) and outputs:
``` bash
Project: docgen

Purpose:
CLI tool that automatically generates documentation for tracked files.

Architecture:
CLI Layer
  └── command_router
        └── update_engine
              ├── docfile_parser
              ├── hash_cache
              └── ai_client

Key files to start reading:
- main.cpp
- update_engine.cpp
- docfile_parser.cpp
Key docs to start reading
```
This solves a huge developer pain:
“I just cloned this repo and have no idea where to start.”
This alone could make the tool popular.


### The Architectural Fix: Map-Reduce Chunking (Future Roadmap)
If you legitimately need to document a 3,000-line source file, you cannot pass it in a single prompt. Instead, you need to implement a Map-Reduce pattern:

Map (Chunking): Split the source file into overlapping chunks (e.g., 250 lines per chunk).
First AI Pass: Loop through the chunks and ask the AI to generate a brief summary and extract key functions/classes for each chunk independently.
Reduce (Synthesis): Combine all the chunk summaries into a single prompt and ask the AI to synthesize the final, cohesive Markdown documentation for the entire file


## For 1.0.0
Advanced AST skeletonization

Instead of sending the raw code string, you parse the file into an Abstract Syntax Tree (AST). You strip out the implementation bodies of all functions and methods, leaving only the class definitions, function signatures, and docstrings. This reduces a 10,000-line file into a 500-line "skeleton" that still gives the AI 100% of the information it needs to explain what the file does, completely eliminating prompt fatigue.