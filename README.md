# Makefile Workspace for Small C/C++ Projects

- Writing the same scripts over and over again for different boards?
- Only want to test simple basic codes, examples etc.?
- Don't want to use any IDE like Eclipse etc.

## What can you do?

- Building
- Using separate toolchain
- Running remotely
- Debugging remotely
- Getting the coredump file and running debugger on that file
- Working on the projects in the workspace arbitrarily

## How to use?

### Copying

The project should be cloned into the main project as a subdirectory. You can clone the project with the command:

```bash
$ git clone git@github.com:mustafagonul/makefile-workspace.git
```

or

```bash
$ git clone https://github.com/mustafagonul/makefile-workspace.git
```

If your main project is git project, you can keep the `makefile-workspace` project as a submodule. You can add the project to your main project as a submodule with the command:

```bash
git submodule add https://github.com/mustafagonul/makefile-workspace.git makefile-workspace
```

or

```bash
git submodule add git@github.com:mustafagonul/makefile-workspace.git makefile-workspace
```

### Configuration

#### Remote

#### Toolchain Scripts

##### toolchain.mk

##### setup.sh

#### Workspace

#### Project

#### Application (run.sh)

## TODO
