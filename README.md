# Overview
Forked from mhyatt000/nvim

## Python workflow

- Pyright discovers a project-local `.venv` automatically, including environments created by `uv`, even when Neovim is launched without first activating it.
- Library source is analyzed when a dependency does not ship complete type stubs, and auto-import completions are enabled.
- LSP inlay hints are enabled when the attached language server supports them.
- A newly created `*.py` file starts with a module docstring containing the filename, author, and a description placeholder, followed by `from __future__ import annotations`.
