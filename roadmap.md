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
To elevate **docgen** to a professional, enterprise-ready tool suitable for commercial codebases, version 1.0.0 will focus on Security, Reliability, Scalability, and Integration.

### 1. Security & Privacy (Enterprise-Ready)
- **Environment Variable Keys:** Remove API keys from `docgen_config.json` to prevent accidental credential leaks. Read API keys exclusively from environment variables or global user configurations.
- **Native HTTP Client:** Replace `popen(curl)` with a native C++ HTTP client (e.g., `cpp-httplib` or `libcurl` directly) to eliminate command injection vulnerabilities and cross-platform brittleness.
- **Enterprise "Local Only" Enforcement:** Add a hard switch (e.g., `DOCGEN_ENFORCE_LOCAL=1`) to physically prevent the tool from making requests to external cloud providers, ensuring proprietary code never leaves the corporate network.

### 2. Scalability & Performance
- **Semantic Chunking (AST Parsing):** Instead of sending the raw code string, parse the file into an Abstract Syntax Tree (AST). Strip out the implementation bodies of all functions and methods, leaving only the class definitions, function signatures, and docstrings. This reduces a massive legacy file into a "skeleton" that still gives the AI 100% of the information it needs, completely eliminating prompt fatigue and bypassing the 50KB limit.
- **Event-Based File Watcher:** Replace the busy-wait `while(true)` polling in `docgen auto` with a native OS file system event watcher (e.g., `efsw`, `fsevents`, `inotify`) to achieve zero CPU usage when idle.

### 3. CI/CD & Workflow Integration
- **Machine-Readable Output:** Add a `--format json` or `--format sarif` flag to `docgen validate` for native integration with GitHub Advanced Security and GitLab CI dashboards.
- **Pre-commit Hooks:** Introduce `docgen install-hook` to easily set up a Git pre-commit hook that automatically runs `docgen update` or `docgen validate`.
- **Concurrency:** Parallelize `cmd_update`. Process independent files concurrently using a thread pool instead of a sequential loop, drastically reducing update times.

### 4. Output Formatting & Standards
- **Format Adapters:** Ensure generated Markdown is strictly compatible with standard static site generators like MkDocs, Hugo, or Doxygen.
- **Frontmatter Support:** Inject YAML frontmatter (e.g., `title`, `date`, `author`, `tags`) at the top of generated Markdown files for enterprise wikis and developer portals like Backstage.

### 5. Tool Codebase Health
- **Unit & Integration Testing:** Introduce a standard C++ testing framework (like Catch2 or GoogleTest).
- **Refactor `core.hpp`:** Split `core.hpp` into cohesive, maintainable modules (`cli.hpp`, `ai_client.hpp`, `fs_watcher.hpp`, `project_manager.hpp`) to encourage open-source contributions.