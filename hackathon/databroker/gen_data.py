from bluesky import RunEngine
import databroker
import bluesky.plans as bp
from ophyd.sim import motor, det

db = databroker.Broker.named('local')
RE = RunEngine()
RE.subscribe(db.insert)

for j in range(10):
    RE(bp.scan([det], motor, -10, 10, 100), sample=f'sample_{j}')
