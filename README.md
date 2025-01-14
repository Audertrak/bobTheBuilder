# Yet Another Build Tool
## What
Plugin for neovim intended to automate boilerplate for compiling C programs, ideally being system/tooling/target agnostic.

## Why
I want to mitigate magic handwaving tools and obfuscation, but eliminate friction involved with compilation/project management for C programs

## How
- Create floating terminal window
- Prompt user for params
    - project name
    - project root directory
    - toolchain
    - build target
    - ...
- generate project boilerplate
    - build script
    - directory structure
    - code boilerplate templates
    - (optionally) import/symlink to headers/libraries
- interactive build/compilation interface
    - build log(s)
    - compiler error parsing/handling
        - 'code action' like behavior, e.g. prompt user for missing library etc
