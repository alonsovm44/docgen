```markdown
# Documentation Generator (DocGen)

This module provides functionality for initializing, configuring, and updating documentation for code files using AI-generated Markdown.

## Functions

### `cmd_init()`
Initializes the documentation repository by creating necessary files and directories:
- **Docfile**: Tracks and ignores file patterns.
- **.docgen directory**: Stores configuration and generated documentation.
- **Config file**: Sets up local and cloud AI model configurations.
- **Lockfile**: Tracks file hashes for update checks.

**Error Handling**: Exits if `.docgen/` or `Docfile` already exists.

---

### `cmd_config(int argc, char* argv[])`
Manages configuration settings via command-line arguments.  
**Usage**:
- `docgen config see`: Displays current configuration.
- `docgen config <key> <value>`: Updates configuration keys (`mode`, `protocol`).

**Supported Keys**:
- `mode`: Switch between `local` and `cloud` AI modes.
- `protocol`: Sets cloud API protocol (e.g., `simple`, `openai`).

**Error Handling**: Validates inputs and requires `docgen init` if config files are missing.

---

### `cmd_track_ignore(const std::string& cmd, const std::string& path)`
Adds file patterns to `Track:` or `Ignore:` sections in `Docfile`.  
**Parameters**:
- `cmd`: Either `"track"` or `"ignore"`.
- `path`: File pattern to add (e.g., `*.cpp`).

**Error Handling**: Requires `Docfile` to exist.

---

### `call_ai(const std::string& filepath, const std::string& content, bool verbose = false)`
Generates Markdown documentation using AI models.  
**Parameters**:
- `filepath`: Source file path (relative).
- `content`: File content to process.
- `verbose`: Enables detailed logging.

**Features**:
- Supports local and cloud AI modes.
- Retries up to 5 times with exponential backoff.
- Handles rate limits and API errors.

**Output**: Saves generated Markdown to `.docgen/docs/<filepath>.md`.

---

### `cmd_update(bool verbose = false)`
Updates documentation for tracked files.  
**Process**:
1. Parses `Docfile` for tracked/ignored patterns.
2. Scans files matching patterns, skipping ignored or non-text files.
3. Compares file hashes to determine updates needed.
4. Calls `call_ai()` for outdated files.

**Error Handling**: Requires `Docfile` and exits if missing.

---

### `cmd_reboot()`
Resets the documentation repository by deleting:
- `Docfile`
- `.docgen/` directory

**Confirmation**: Prompts user before deletion.

## Dependencies
- **FileSystem (`fs`)**: For file/directory operations.
- **JSON Library**: For configuration handling.
- **CURL (`exec_curl`)**: For API requests.
- **Hashing (`hash_content`)**: Tracks file changes.

## Constants
- `DOCGEN_DIR`, `DOCFILE`, `CONFIG_FILE`, `LOCK_FILE`, `DOCS_DIR`: Define paths for repository structure.

## Notes
- Ensure API keys are set for cloud mode via `docgen config key <value>`.
- Local mode requires a running Ollama instance (`http://localhost:11434`).
```