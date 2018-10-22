import python;
import io;
import location;
import string;
import sys;

location L = locationFromRank(0);


@location=L python_persist(
----
import json
import pickle
import socket
import time
import zmq
from bluesky.run_engine import DocumentNames


deserializer = pickle.loads
address = ('localhost', 2001)

_context = zmq.Context()
_socket = _context.socket(zmq.SUB)

url = "tcp://%s:%d" % address
_socket.connect(url)
print('connect')

_socket.setsockopt_string(zmq.SUBSCRIBE, "")
_task = None

def _poll(_socket, deserializer, DocumentNames):
    while True:
        message = _socket.recv()
        hostname, pid, RE_id, name, doc = message.split(b' ', 4)
        hostname = hostname.decode()
        name = name.decode()
        doc = deserializer(doc)
        yield (name, doc)

doc_gen = _poll(_socket, deserializer, DocumentNames)
----,
"'setup'") => process();




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
name, doc = %s
----
% inp
         ,
----
name
----
                  );

}


global const int MAX = 1000;
process()
{
  for (int i = 0, boolean stop = false;
       !stop;
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
