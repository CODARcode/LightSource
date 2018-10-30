import python;

s = python(----
import m
m.g.inputs(7)
----,
----
m.g.result()
----);

trace(s);
