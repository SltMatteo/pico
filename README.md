# Pico

Pico is a small, dependency-free terminal text editor written in C. It is a
guided implementation of [Kilo](https://github.com/antirez/kilo), built by
following Paige Ruten's
[Build Your Own Text Editor](https://viewsourcecode.org/snaptoken/kilo/)
tutorial.

The goal of this project is educational: to understand how a terminal editor
works below the level of libraries such as `curses`. The editor configures the
terminal directly, interprets escape sequences, maintains an in-memory row
model, renders a scrolling viewport, and reads and writes files using POSIX
APIs.

> **Why "Pico"?** I called it Pico because of
> [Nano](https://www.nano-editor.org/), before realizing Nano was inspired
> by... [Pico](https://dictionary.cambridge.org/dictionary/english/come-go-turn-full-circle).

## Features

- Open, edit, and save text files
- Create a new file by opening a path that does not exist yet
- Horizontal and vertical scrolling
- Home, End, Page Up, and Page Down navigation
- Incremental search with arrow-key navigation
- C and C++ syntax highlighting for keywords, strings, numbers, and comments
- Unsaved-change protection when quitting
- No runtime dependencies beyond a POSIX-compatible terminal

## Build

You need a C99 compiler and `make`. On macOS or Linux:

```sh
make
```

This creates the `runpico` executable. Remove build output with:

```sh
make clean
```

## Usage

Open an existing file or start a new one:

```sh
./runpico path/to/file.c
```

You can also start without a filename and choose one the first time you save:

```sh
./runpico
```

### Keyboard shortcuts

| Shortcut | Action |
| --- | --- |
| <kbd>Ctrl</kbd>+<kbd>S</kbd> | Save |
| <kbd>Ctrl</kbd>+<kbd>Q</kbd> | Quit; repeated presses confirm discarding changes |
| <kbd>Ctrl</kbd>+<kbd>F</kbd> | Search |
| Arrow keys | Move the cursor or move between search results |
| <kbd>Home</kbd> / <kbd>End</kbd> | Move to the beginning or end of a line |
| <kbd>Page Up</kbd> / <kbd>Page Down</kbd> | Move by one screen |
| <kbd>Esc</kbd> | Cancel a prompt or search |

## Project provenance

This is intentionally a guided learning project, not a claim that the editor's
design originated here. Kilo was created by Salvatore Sanfilippo and released
under the BSD 2-Clause License. The tutorial adaptation is by Paige Ruten. See
[LICENSE](LICENSE) for the retained upstream copyright and license terms.

## Current limitations

- Text is edited byte by byte; multi-byte UTF-8 characters are displayed but
  cursor movement and deletion are not Unicode-aware.
- Syntax highlighting is limited to C and C++.
- Saving overwrites the destination directly rather than using an atomic
  temporary-file-and-rename workflow.
- The editor operates on one file and has no undo history.

## Future directions

The following features would deliberately extend the project beyond the
tutorial and make it a more distinctive systems-programming portfolio piece:

- Add undo and redo using an explicit command history or edit log.
- Make cursor movement, deletion, search, and viewport widths UTF-8-aware.
- Implement atomic saves, permission preservation, and recovery files.
- Add line numbers, go-to-line, selection, clipboard operations, and status
  information such as row and column.
- Replace the hard-coded C syntax table with a small extensible language
  definition format and add more languages.
- Add configurable themes and key bindings while retaining a dependency-free
  core.
- Build pseudo-terminal integration tests and run sanitizer builds on macOS and
  Linux in CI.
- Profile rendering on large files, then document and improve the data
  structures used for editing and search.

These directions are useful because they require original design decisions in
areas such as Unicode, persistence, testing terminal software, data structures,
and failure-safe file I/O.
