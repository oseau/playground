# Playground

A development environment for quick Python and Go experiments.

## Features

- Hot reloading - code runs automatically on save
- Supports both Python and Go
- Isolated Docker environment
- Timeout protection (10s max execution)
- Timestamp-based file naming

## Usage

### Prerequisites
- Docker
- Make
- Emacs (optional, for `emacsclient` integration)

### Quick Start

```bash
# Create and watch a Python file
make py

# Create and watch a Go file
make go

# List all available commands
make
```
