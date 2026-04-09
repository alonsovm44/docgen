<!-- gendox-provenance
model_id: qwen2.5-coder:7b
prompt_hash: a002f536e683dd50
timestamp: 2026-04-09T02:45:48Z
tool_version: gendox v0.2.0
base_commit: a870ddfe54e52b4f72367add73f0f05efdc3d102
-->

# Documentation for `gendox.hpp`

## Overview
This file provides the core functionality for the Gendox documentation generation tool. It includes commands for initializing projects, managing configuration, generating documentation, and querying existing documentation.

## Key Components

### `skeletonize` Function
- **Purpose**: Reduces source code to a "skeleton" by removing function/method bodies using Tree-sitter parsing.
- **Supported Languages**: C, C++, Python, JavaScript, TypeScript, Go, Rust.
- **Behavior**:
  - Parses code using Tree-sitter to identify function/method bodies.
  - Replaces bodies with placeholders (e.g., `{ /* implementation hidden */ }`).
  - Handles different syntax patterns for each language.
  - Returns original code for unsupported languages.

### `cmd_init` Function
- **Purpose**: Initializes a new Gendox project.
- **Actions**:
  - Creates `.gendox` directory structure.
  - Generates `Docfile` with tracking/ignoring patterns.
  - Creates initial configuration files (`gendox_config.json`, `gendox.lock`, `tree.json`).
  - Prompts for project name.

### `cmd_config` Function
- **Purpose**: Manages project configuration.
- **Subcommands**:
  - `see`: Displays current configuration.
  - `check`: Tests API connection.
  - `<key> <value>`: Updates specific configuration keys (mode, protocol, API key, model, ignore-hidden).

### `cmd_update` Function
- **Purpose**: Updates documentation for tracked files.
- **Process**:
  1. Scans files using tracking patterns from `Docfile`.
  2. Compares file hashes to detect changes.
  3. Skeletons code and generates documentation using AI.
  4. Updates metadata in `tree.json` and `gendox.lock`.

### `cmd_auto` Function
- **Purpose**: Enables auto-update mode.
- **Behavior**:
  - Watches tracked files for changes.
  - Automatically triggers `cmd_update` when changes are detected.

### `cmd_query` Function
- **Purpose**: Queries project documentation using AI.
- **Modes**:
  - Single query mode.
  - Interactive chat mode (`--chat`).
- **Context Building**:
  - Aggregates documentation from `docs/` directory.
  - Uses Tree-sitter for dependency analysis.

### `cmd_graph` Function
- **Purpose**: Generates a dependency graph.
- **Output**:
  - Creates a Graphviz DOT file (`graph.dot`).
  - Includes nodes for files and edges for dependencies.

### Utility Functions
- **`parse_docfile`**: Parses `Docfile` configuration.
- **`scan_files`**: Scans files based on tracking/ignoring patterns.
- **`call_ai`**: Handles AI interactions for documentation generation.
- **`exec_curl`**: Executes HTTP requests using `curl`.

## Usage Examples
```bash
# Initialize project
gendox init

# Update documentation
gendox update

# Query documentation
gendox query "How do I use the Foo class?"

# Enter chat mode
gendox query --chat

# Generate dependency graph
gendox graph
```

## Dependencies
- Tree-sitter for parsing source code.
- nlohmann/json for JSON handling.
- Standard C++ filesystem library.
- `curl` for HTTP requests.

## Notes
- Configuration is stored in `.gendox/gendox_config.json`.
- Documentation is generated in `.gendox/docs/`.
- Metadata is maintained in `.gendox/tree.json` and `.gendox.lock`.
- Supports both local and cloud-based AI models.