import pickle
import socket
import time
import zmq
from bluesky.run_engine import DocumentNames


deserializer = pickle.loads
address = ('localhost', 2001)

_context = zmq.Context()
print(f'=== _context: {_context}')
_socket = _context.socket(zmq.SUB)

url = "tcp://%s:%d" % address
_socket.connect(url)
_socket.setsockopt_string(zmq.SUBSCRIBE, "")
_task = None

def _poll():
    while True:
        message = _socket.recv()
        hostname, pid, RE_id, name, doc = message.split(b' ', 4)
        hostname = hostname.decode()
        name = name.decode()
        doc = deserializer(doc)
        yield (DocumentNames[name], doc)

doc_gen = _poll()

for doc in doc_gen:
    print(doc)

