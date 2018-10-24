
import location;
import python;
import string;
import sys;

// The checkerboard:
float A[][];

// may_x is the width of the board, x from left to right
max_x = string2int(argv("x"));
// max_y is the height of the board, y from top to bottom
max_y = string2int(argv("y"));

// The rank that queries for new events that will
// fill in the left-most column, top to bottom
location detector = locationFromRank(0);

// An initial Python event to fill in A[0][0]
s = python_persist("count=0;state=3.14", "str(state)");
A[0][0] = string2float(s);

// Get the next event from the detector
(int j, float v) get_event(location detector, float ready)
{
// Python snippet to accept input parameters
event_code = """
count = count+1
state = state+1
print('event: count=%i' % count)
""";
// Python snippet to produce the result
event_expr = """
str(count)+','+str(state)
""";

  // Wait for A[0][0] to ensure we are ready
  ready =>
  // Call the Python snippets to get the event slot (j) and value (v)
  s = @location=detector
    python_persist(event_code, event_expr);
  t = split(s, ",");
  j = string2int  (t[0]);
  v = string2float(t[1]);
}

// Compute new value (v) based on value on left (z) and coordinates [i,j]
(float v) f(float z, int i, int j)
{
// Python snippet to accept input parameters and compute v
f_code = """
z = %f
i = %i
j = %i
v = z+i+j
print('f('+str(z)+','+str(i)+','+str(j)+')='+str(v))
""";
// Python snippet to return the result
f_expr = """
str(v)
""";

  // Call the Python snippets
  s = python_persist(f_code%(z,i,j), f_expr);
  v = string2float(s);
}

// Fill in the left-most column based on events
for (int k = 1; k < max_y; k = k + 1)
{
  // Get initial data for row j
  // The detector tells us what j is based on its internal state
  j,v = get_event(detector, A[0][0]);
  // Assign the initial data into the left-most column
  A[0][j] = v;
}

// For each slot [i,j] in the checkerboard, compute f()
// based on the data in [i-i,j]
for (int j = 0; j < max_y; j = j + 1)
{
  for (int i = 1; i < max_x; i = i + 1)
  {
    A[i][j] = f(A[i-1][j], i, j);
  }
}
