# Swift + DataBroker

This set of files demonstrates how to access a DataBroker from swift.

To run this demo you need

 - a python 3.6 with requirements.txt installed
 - a running local mongo server
 - a python interpreter embedded in swift/t with swift-requirements.txt installed

To run this:

 - copy local.yml to `~/.config/databroker/local.yml` (or someplace
   else on the search path, see
   https://nsls-ii.github.io/databroker/configuration.html#search-path
   )
 - run `gen_data.py` to load some synthetic data into the database
 - run `/your/install/path/swift-t -n 6 -l read_databroker.swift`

You should see 100 rows of data like

```
[4] processed: '100 aadd1a95-b812-4038-9f8d-cf59539da413: {'det': 1.9287498479639178e-22, 'motor': 10.0, 'motor_setpoint': 10.0}'
```

be printed in slightly jumbled order.
