# C++ Project Template

Uses:
- CMake with CMake Presets
- Ninja
- clang-format
- VS Code (optional)

This repository is intended to be used as a **GitHub template**.
Do not clone it directly unless you want to keep the template history.

---

## Quick start

### 1. Create a new project from the template

Using GitHub CLI (recommended):

```bash
gh repo create my-project --template krundhall/cpp-template --clone
cd my-project
```

Or via GitHub UI:

- Open this repository
- Click **Use this template**
- Create a new repository
- Clone it locally

---

### 2. Rename the project

Edit one line in `CMakeLists.txt`:

```cmake
project(cpp_template LANGUAGES CXX)
```

Change it to:

```cmake
project(my_project LANGUAGES CXX)
```

This sets both the project name and the executable name.

---

### 3. Build

```bash
cmake --preset debug
cmake --build --preset debug
```

Or, if using the helper script:

```bash
./scripts/build-debug.sh
```

---

## Done

You now have:
- A clean Git history
- A working build
- Formatting configured via `.clang-format`
- Correct bracket formatting (lol)


---

## Notes

- Do **not** clone this repository directly unless you want to keep the template history.
- Requires **CMake ≥ 3.19** (tested with 3.22).
- Formatting uses `clang-format`.
