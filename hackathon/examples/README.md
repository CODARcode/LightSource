
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

### External apps

Demonstrates external `app` functions, loops, and command-line arguments.

```
$ swift-t loop.swift -n=3
dunedin
dunedin
dunedin
```
### Streaming I/O

Demonstrates use of input data stream

```
$ swift-t stream.swift --source=input.txt
opening: input.txt
processing data: '1.0 2.0 3.0'
processing data: '4.0 5.0 6.0'
processing data: '7.0 8.0 9.0'
processing data: ''
No more data!
```
