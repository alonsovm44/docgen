```markdown
# File: `file_utils.h`

```cpp
#pragma once
```

## Overview
This header file provides utility functions for file handling, string manipulation, and HTTP requests using `curl`. It includes functions for hashing content, reading/writing files, trimming strings, and executing HTTP POST requests with JSON bodies.

## Includes
```cpp
#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <filesystem>
#include <sstream>
#include <iomanip>
#include <cstdlib>
#include <cstdio>
#include <array>
#include <algorithm>
#include "json.hpp"
```

## Namespaces
```cpp
using json = nlohmann::json;
namespace fs = std::filesystem;
```

## Functions

### `hash_content(const std::string& content)`
**Description:** Computes a simple FNV-1a hash of the input string.  
**Parameters:**  
- `content`: The string to hash.  
**Returns:** A hexadecimal string representation of the hash.  

```cpp
inline std::string hash_content(const std::string& content) {
    // Implementation...
}
```

### `is_text_file(const fs::path& path)`
**Description:** Checks if a file is a text file by reading its contents and ensuring no null bytes are present.  
**Parameters:**  
- `path`: The file path to check.  
**Returns:** `true` if the file is a text file, otherwise `false`.  

```cpp
inline bool is_text_file(const fs::path& path) {
    // Implementation...
}
```

### `read_file(const fs::path& path)`
**Description:** Reads the entire contents of a file into a string.  
**Parameters:**  
- `path`: The file path to read.  
**Returns:** The file contents as a string, or an empty string if the file cannot be read.  

```cpp
inline std::string read_file(const fs::path& path) {
    // Implementation...
}
```

### `write_file(const fs::path& path, const std::string& content)`
**Description:** Writes a string to a file, creating directories if necessary.  
**Parameters:**  
- `path`: The file path to write to.  
- `content`: The string to write.  

```cpp
inline void write_file(const fs::path& path, const std::string& content) {
    // Implementation...
}
```

### `trim(const std::string& str)`
**Description:** Removes leading and trailing whitespace from a string.  
**Parameters:**  
- `str`: The string to trim.  
**Returns:** The trimmed string.  

```cpp
inline std::string trim(const std::string& str) {
    // Implementation...
}
```

### `exec_curl(const std::string& url, const std::vector<std::string>& headers, const json& body)`
**Description:** Executes a `curl` command to perform an HTTP POST request with JSON body.  
**Parameters:**  
- `url`: The target URL.  
- `headers`: A list of HTTP headers.  
- `body`: The JSON body to send.  
**Returns:** The response from the server as a string.  

```cpp
inline std::string exec_curl(const std::string& url, const std::vector<std::string>& headers, const json& body) {
    // Implementation...
}
```

### `match_pattern(const fs::path& path, const std::string& pattern)`
**Description:** Checks if a file path matches a given pattern (e.g., directory, extension, or exact match).  
**Parameters:**  
- `path`: The file path to check.  
- `pattern`: The pattern to match against.  
**Returns:** `true` if the path matches the pattern, otherwise `false`.  

```cpp
inline bool match_pattern(const fs::path& path, const std::string& pattern) {
    // Implementation...
}
```
```

This Markdown documentation provides a clear overview of the header file's purpose, included libraries, namespaces, and detailed descriptions of each function, including their parameters and return values.