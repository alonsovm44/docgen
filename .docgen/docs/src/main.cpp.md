```markdown
# `docgen` Command-Line Tool  
A lightweight command dispatcher that routes subcommands to internal functions defined in `core.hpp`.

---

## Overview
The `docgen` executable accepts a primary command followed by optional arguments. It validates input, dispatches to the appropriate handler, and prints usage guidance when invoked incorrectly. Unsupported commands produce an error message.

---

## Usage
```bash
docgen <command> [args...]
```

### Available Commands
- `init`
- `config`
- `track <path>`
- `ignore <path>`
- `update [-v|--verbose]`
- `reboot`
- `get-key`

---

## Command Reference

### 🧱 `init`
Initializes the tool’s environment.

**Behavior**
- Calls `cmd_init()` with no arguments.

---

### ⚙️ `config`
Manages configuration settings.

**Usage**
```bash
docgen config [args...]
```

**Behavior**
- Passes full `argc` and `argv` to `cmd_config()` for flexible configuration handling.

---

### 📁 `track`
Marks a file or directory to be tracked.

**Usage**
```bash
docgen track <path>
```

**Behavior**
- Requires a path argument.
- Calls `cmd_track_ignore("track", <path>)`.

**Error Handling**
- If `<path>` is missing, prints:
  ```
  Usage: docgen track <path>
  ```

---

### 🚫 `ignore`
Marks a file or directory to be ignored.

**Usage**
```bash
docgen ignore <path>
```

**Behavior**
- Requires a path argument.
- Calls `cmd_track_ignore("ignore", <path>)`.

**Error Handling**
- If `<path>` is missing, prints:
  ```
  Usage: docgen ignore <path>
  ```

---

### 🔄 `update`
Updates internal state or metadata.

**Usage**
```bash
docgen update [-v|--verbose]
```

**Behavior**
- Optional `-v` or `--verbose` flag enables verbose mode.
- Calls `cmd_update(verbose)`.

---

### ♻️ `reboot`
Performs a system or internal reboot operation.

**Behavior**
- Calls `cmd_reboot()`.

---

### 🔑 `get-key`
Opens a browser to retrieve an API key.

**Behavior**
- Launches the default browser to `https://apifreellm.com`.
- Platform-specific:
  - Windows: `start`
  - macOS: `open`
  - Linux: `xdg-open`

---

## Error Handling

### Unknown Command
If the user provides an unrecognized command:
```
Unknown command: <command>
```

### Missing Command
If no command is provided:
```
Usage: docgen <command> [args...]
```

---

## Program Flow Summary
1. Validate that at least one command is provided.
2. Match the command string against supported commands.
3. Validate required arguments for each command.
4. Dispatch to the corresponding handler function.
5. Print helpful usage messages on incorrect input.

---
