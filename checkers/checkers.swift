
import location;
import python;
import string;
import sys;

float A[][];

max_x = string2int(argv("x"));
max_y = string2int(argv("y"));

location detector = locationFromRank(0);

s = python_persist("count=0;state=3.14", "str(state)");
A[0][0] = string2float(s);

(int j, float v) get_event(location detector)
{
event_code = """
count = count+1
state = state+1
print('event: count=%i' % count)
""";
event_expr = """
str(count)+','+str(state)'
""";

  s = @location=detector
    python_persist(event_code, event_expr);
  t = split(s, ",");
  j = string2int  (t[0]);
  v = string2float(t[1]);
}

(float v) f(float z, int i, int j)
{
f_code = """
z = %f
i = %i
j = %j
v = z+i+j
print('f(%f,%i,%i)=%f'%(z,i,j,v))
""";
f_expr = """
str(v)
""";

  s = python(f_code%(z,i,j), f_expr);
  v = string2float(s);
}

for (int k = 1; k < max_y; k = k + 1)
{
  j,v = get_event(detector);
  A[0][j] = v;
}
/*
for (int j = 0; j < max_y; j = j + 1)
{
  for (int i = 1; i < max_x; i = i + 1)
  {
    A[i][j] = f(A[i][j-1], i, j);
  }
}
*/
