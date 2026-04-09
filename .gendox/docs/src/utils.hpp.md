<!-- gendox-provenance
model_id: qwen2.5-coder:7b
prompt_hash: 6d375d776ccd3bc4
timestamp: 2026-04-09T02:25:31Z
tool_version: gendox v0.2.0
base_commit: a870ddfe54e52b4f72367add73f0f05efdc3d102
-->

# File: `utils.hpp`

## Overview
This header file provides utility functions for file handling, string manipulation, hashing, and executing shell commands. It is designed to support various operations such as reading/writing files, trimming strings, computing hashes, and interacting with Git and HTTP services.

---

## Functions

### 1. **Hash Content**
```cpp
inline std::string hash_content(const std::string& content);
```
- **Purpose**: Computes a FNV-1a hash of the input string.
- **Usage**: Use to generate a unique hash for file or string content.
- **Behavior**: Iterates over each character in the string, updating the hash using the FNV-1a algorithm. Returns the hash as a 16-character hexadecimal string.

---

### 2. **Check if File is Text**
```cpp
inline bool is_text_file(const fs::path& path);
```
- **Purpose**: Determines if a file is a text file by checking for null bytes.
- **Usage**: Use to validate file type before processing.
- **Behavior**: Reads the first 1024 bytes of the file. If any byte is null (`\0`), it returns `false`; otherwise, `true`.

---

### 3. **Read File Content**
```cpp
inline std::string read_file(const fs::path& path);
```
- **Purpose**: Reads the entire content of a file into a string.
- **Usage**: Use to load file content for processing.
- **Behavior**: Opens the file in binary mode and reads its content into a stringstream, returning the result as a string.

---

### 4. **Write File Content**
```cpp
inline void write_file(const fs::path& path, const std::string& content);
```
- **Purpose**: Writes a string to a file, creating directories if necessary.
- **Usage**: Use to save processed data to disk.
- **Behavior**: Creates any missing parent directories and writes the content to the file in binary mode.

---

### 5. **Trim String**
```cpp
inline std::string trim(const std::string& str);
```
- **Purpose**: Removes leading and trailing whitespace from a string.
- **Usage**: Use to clean up strings before further processing.
- **Behavior**: Finds the first and last non-whitespace characters and returns the substring between them.

---

### 6. **Get Git Commit Hash**
```cpp
inline std::string get_git_commit();
```
- **Purpose**: Retrieves the current Git commit hash.
- **Usage**: Use to version control integration.
- **Behavior**: Executes `git rev-parse HEAD` and captures the output. Returns "unknown" if the command fails or the output is empty.

---

### 7. **Execute HTTP Request with Curl**
```cpp
inline std::string exec_curl(const std::string& url, const std::vector<std::string>& headers, const json& body);
```
- **Purpose**: Sends an HTTP POST request using `curl`.
- **Usage**: Use for API interactions.
- **Behavior**: Writes the JSON body to a temporary file, constructs a `curl` command, and executes it. Returns the response or an empty string on failure.

---

### 8. **Match File Pattern**
```cpp
inline bool match_pattern(const fs::path& path, const std::string& pattern);
```
- **Purpose**: Checks if a file path matches a given pattern.
- **Usage**: Use for filtering files based on patterns.
- **Behavior**: Supports directory matches (e.g., `dir/`), extension matches (e.g., `*.cpp`), and exact matches. Normalizes path separators before comparison.

---

### 9. **Extract Includes/Imports**
```cpp
inline std::vector<std::string> extract_includes(const std::string& content);
```
- **Purpose**: Extracts include/import statements from code.
- **Usage**: Use for dependency analysis.
- **Behavior**: Uses a regex to match `#include`, `import`, `using`, `from ... import`, and `package` statements in C++, Python, C#, Java, and Go code. Returns a list of matched modules/files.

---

## Dependencies
- **C++ Standard Library**: `<iostream>`, `<fstream>`, `<string>`, `<vector>`, `<filesystem>`, `<sstream>`, `<iomanip>`, `<cstdlib>`, `<cstdio>`, `<array>`, `<algorithm>`, `<regex>`.
- **External**: `nlohmann::json` (for JSON handling).

---

## Platform Compatibility
- Supports both Windows and Unix-like systems via conditional compilation (`#ifdef _WIN32`).

---

## Example Usage
```cpp
#include "utils.hpp"

int main() {
    fs::path file_path = "example.txt";
    std::string content = read_file(file_path);
    std::string hash = hash_content(content);
    std::cout << "File hash: " << hash << std::endl;
    return 0;
}
```

This documentation provides a clear overview of the utility functions, their purposes, and how to use them effectively.