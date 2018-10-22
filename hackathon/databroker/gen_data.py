import databroker
import bluesky.plans as bp
from bluesky import RunEngine
from bluesky.callbacks.zmq import Publisher
from bluesky.callbacks.best_effort import BestEffortCallback
from ophyd.sim import motor, det

db = databroker.Broker.named('local')
bec = BestEffortCallback()
RE = RunEngine()
RE.subscribe(db.insert)
RE.subscribe(bec)

pub = Publisher('localhost:2000', RE=RE)

for j in range(10):
    RE(bp.scan([det], motor, -10, 10, 100), sample=f'sample_{j}')
