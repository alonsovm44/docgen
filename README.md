# Docgen 

**Solve documentation hell for good.**

Docgen is a lightweight, C++ CLI tool that automates software documentation using Large Language Models (LLMs). It treats documentation generation as a build step, tracking your source code and incrementally updating documentation only when files change.

## Why this solves "Documentation Hell"?
Because you no longer have to bother writing docs yourself, just run `docgen update` and you are good to go. 

## Features

*   **Docs-as-Code**: Generates Markdown documentation that lives right next to your source code.
*   **Smart Incremental Builds**: Uses content hashing to only regenerate docs for modified files, saving time and API credits.
*   **Context-Aware (RAG)**: Automatically analyzes `#include` dependencies to provide relevant context to the AI, ensuring accurate documentation for complex projects.
*   **Flexible Backend**: 
    *   **Cloud**: Supports OpenAI, Google Gemini, and compatible APIs.
    *   **Local**: Works fully offline with Ollama (default).
*   **Zero Dependencies**: Compiled as a single static binary.

## Getting started
Run 
```bash
docgen init
```
This creates your `Docfile` and your `.docgen` repo. Using the Docfile is easy. 
Run `docgen track <path>` this adds the file/directory to your Docfile. 
Then run `docgen update` to generate your tracked files documentation. Once generated only files with changes will be updated. 
You can also run `docgen ignore` to indicate to Docgen which files or directories to ignore.

**Example Docfile**
```Docfile
Track:
# This is a comment
    main.cpp
    src/
Ignore:
    src/secret.cpp

Style:
    # these get passed to the AI as parameters when making docs
    -dont use emojis
    -be professional
    -be concise
```

## Quick Install

### Windows (PowerShell)
```powershell
irm https://raw.githubusercontent.com/alonsovm44/docgen/master/installer.ps1 | iex
```
### Linux / Mac
```bash
curl -fsSL https://raw.githubusercontent.com/alonsovm44/docgen/master/installer.sh | bash
```

## Other commands

### Status
Check which files have changed since the last update.
```bash
docgen status
```

### Summary
Generate a `SUMMARY.md` file with a high-level overview of your project.
```bash
docgen summary
```

### Graph
Generate a dependency graph in DOT format (Graphviz) at `.docgen/graph.dot`.
```bash
docgen graph
```

### Clean
Remove documentation for files that are no longer tracked.
```bash
docgen clean
```

### Validate
Verify if documentation is up-to-date (useful for CI/CD).
```bash
docgen validate
```

### Upgrade
Update docgen to the latest version.
```bash
docgen upgrade
```

### Reboot
Run this command to reset your documentation repository (asks for confirmation)
```bash
docgen reboot
```
### config
Docgen comes with a config.json file within your `./docgen` folder. In it you can configure A.I parameters

You can also run 
```shell
$ docgen config

Usage: docgen config <key> <value>
Keys: mode, protocol, key, model
```
 #### Setting up an API key
 ```bash
$ docgen config 
 ```