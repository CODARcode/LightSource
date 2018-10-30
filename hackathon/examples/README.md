
## Setup

Install Swift/T with:

```
conda install -c lightsource2-tag swift-t
```

## Examples

### Hello world

```
$ swift-t hello.swift
trace: Hello World
```

### Simple Python

Demonstrates the two arguments to the python() function.

```
$ swift-t py.swift
trace: 3
```

### Python errors

Shows how Python errors are handled in Swift/T.

```
$ swift-t py-err.swift

PYTHON EXCEPTION:
<class 'NameError'>
name 'y' is not defined
```

### Python modules

Demonstrates accessing Python modules from Swift/T

```
$ swift-t -e PYTHONPATH=$PWD py-module.swift
trace: 14
```
