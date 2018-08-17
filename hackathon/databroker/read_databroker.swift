import python;
import io;
import location;
import string;
import sys;

location L = locationFromRank(0);


@location=L python_persist(
----
import databroker
import json
db = databroker.Broker.named('local')
h = db[-1]
doc_gen = h.events()
----,
"json.dumps(h.start)") => process();




(string result) get_event()
{
  line = @location=L
    python_persist(
----
try:
    ev = next(doc_gen)
except StopIteration:
    ev = ''
----,
"json.dumps(ev) if ev  else ev");
  result = trim(line);
}


(string result) do_work(string inp)
{
  result = python_persist(
----
import time
time.sleep(1)
ev = %s
print(type(ev))
----
% inp
         ,
----
f"{ev['seq_num']} {ev['uid']}: {ev['data']}"
----
                  );

}


global const int MAX = 1000;
process()
{
  for (int i = 0, boolean stop = false;
       i < MAX && !stop;
       i = i+1, stop = end_of_data)
  {
    line = get_event();
    boolean end_of_data = (line == "");
    if (!end_of_data)
    {
      exp = do_work(line);

      printf("processed: '%s'", exp);
    }

  }
}
