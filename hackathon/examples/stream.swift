
import io;
import location;
import python;
import string;
import sys;

source = argv("source");

location L = locationFromRank(0);

@location=L python_persist(
----
filename = "%s"               
print("opening: " + filename)
fp = open(filename, "r")
----
% source) =>
loop();

(string result) get_line()
{
  line = @location=L
    python_persist("", "fp.readline()");
  result = trim(line);
}

process(string line)
{
  python_persist(
----
print("processing data: '%s'")
---- % line);
}

global const int MAX = 1000;
loop()
{
  for (int i = 0, boolean stop = false;
       i < MAX && !stop;
       i = i+1, stop = end_of_data)
  {
    line = get_line();
    process(line);
    boolean end_of_data = (line == "");
    if (end_of_data)
    {
      printf("No more data!");
    }
  }
}
