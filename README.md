# Docgen 
**Solve documentation drift for good.**

Docgen is a lightweight, C++ CLI tool that automates software documentation using Large Language Models (LLMs). It treats documentation generation as a build step, tracking your source code and incrementally updating documentation only when files change.

## 🚀 Features

*   **Docs-as-Code**: Generates Markdown documentation that lives right next to your source code.
*   **Smart Incremental Builds**: Uses content hashing to only regenerate docs for modified files, saving time and API credits.
*   **Context-Aware (RAG)**: Automatically analyzes `#include` dependencies to provide relevant context to the AI, ensuring accurate documentation for complex projects.
*   **Flexible Backend**: 
    *   **Cloud**: Supports OpenAI, Google Gemini, and compatible APIs.
    *   **Local**: Works fully offline with Ollama (default).
*   **Zero Dependencies**: Compiled as a single static binary.

## 📦 Quick Install

### Windows (PowerShell)
```powershell
.\installer.ps1