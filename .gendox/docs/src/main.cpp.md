<!-- gendox-provenance
model_id: qwen2.5-coder:7b
prompt_hash: 5f981de9f466ef06
timestamp: 2026-04-09T02:24:19Z
tool_version: gendox v0.2.0
base_commit: a870ddfe54e52b4f72367add73f0f05efdc3d102
-->

# `gendox` Command-Line Tool Documentation

## Overview
`gendox` is a command-line tool designed to manage and automate documentation generation for software projects. It provides a suite of commands to initialize, configure, track, and update documentation, as well as interact with external resources like dependency graphs and API keys.

## Version
The current version of `gendox` is **0.2.2**.

---

## Commands

### `help`
**Purpose:** Display the help message with available commands and their descriptions.  
**Usage:**  
```bash
gendox help
gendox -h
gendox --help
```

### `version`
**Purpose:** Display the current version of `gendox`.  
**Usage:**  
```bash
gendox version
gendox -version
gendox --version
```

### `init`
**Purpose:** Initialize a new documentation project.  
**Usage:**  
```bash
gendox init
```

### `config`
**Purpose:** Manage configuration settings (e.g., AI mode, API keys, models).  
**Usage:**  
```bash
gendox config [args...]
```

### `track`
**Purpose:** Track a file or directory for documentation.  
**Usage:**  
```bash
gendox track <path>
```

### `ignore`
**Purpose:** Ignore a file or directory from documentation.  
**Usage:**  
```bash
gendox ignore <path>
```

### `update`
**Purpose:** Generate or update documentation for tracked files.  
**Usage:**  
```bash
gendox update [-v | --verbose]
```
- `-v` or `--verbose`: Enable verbose output.

### `auto`
**Purpose:** Automatically update documentation when files change.  
**Usage:**  
```bash
gendox auto
```

### `status`
**Purpose:** Show the status of tracked files (new/modified).  
**Usage:**  
```bash
gendox status
```

### `validate`
**Purpose:** Check if documentation is up-to-date.  
**Usage:**  
```bash
gendox validate
```

### `clean`
**Purpose:** Remove documentation for untracked files.  
**Usage:**  
```bash
gendox clean
```

### `graph`
**Purpose:** Generate a dependency graph in DOT format.  
**Usage:**  
```bash
gendox graph
```

### `query`
**Purpose:** Ask a question about the codebase.  
**Usage:**  
```bash
gendox query "<question>"
```

### `summary`
**Purpose:** Generate a summary of the documentation status.  
**Usage:**  
```bash
gendox summary
```

### `upgrade`
**Purpose:** Upgrade `gendox` to the latest version.  
**Usage:**  
```bash
gendox upgrade
```

### `reboot`
**Purpose:** Reset the documentation repository (deletes `.gendox/` directory).  
**Usage:**  
```bash
gendox reboot
```

### `sponsor`
**Purpose:** Open the GitHub Sponsors page in the default browser.  
**Usage:**  
```bash
gendox sponsor
```

### `get-key`
**Purpose:** Open the browser to obtain a free API key.  
**Usage:**  
```bash
gendox get-key
```

---

## Platform Support
The `open_url` function supports opening URLs in the default browser on:
- **Windows** (`start`)
- **macOS** (`open`)
- **Linux** (`xdg-open`)

---

## Error Handling
- Unknown commands or incorrect usage result in an error message and exit code `1`.
- Missing arguments for commands like `track`, `ignore`, or `query` prompt usage instructions.

---

## Example Usage
```bash
# Initialize a new project
gendox init

# Track a file
gendox track src/main.cpp

# Update documentation with verbose output
gendox update --verbose

# Ask a question about the codebase
gendox query "What does the `main` function do?"
```

This documentation provides a comprehensive overview of `gendox`'s functionality and usage.