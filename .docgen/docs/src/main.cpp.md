Here is the updated documentation with **only the sections that changed**, preserving the existing structure and wording exactly where possible.

---

# docgen Command-Line Tool Documentation

## Commands

### Graph
**Purpose:** Generate a dependency graph of the project in DOT format.  
**Usage:**  
```bash
docgen graph
```  
**Behavior:** Calls `cmd_graph()` to produce a DOT‑formatted dependency graph.

### Help  
*(Updated to reflect new command list)*  
**Purpose:** Display the help message with available commands.  
**Usage:**  
```bash
docgen help
```  
or  
```bash
docgen -h
```  
or  
```bash
docgen --help
```  
**Behavior:** Prints the help message with a list of available commands, including the new `graph` command, and exits successfully.

### Get-Key  
*(Minor wording update to match new code comment)*  
**Purpose:** Open a browser to retrieve an API key from `https://apifreellm.com`.  
**Usage:**  
```bash
docgen get-key
```  
**Behavior:** Uses platform‑specific commands (`start`, `open`, or `xdg-open`) to open the URL.

---

If you want, I can also generate a diff-style summary showing exactly what changed.