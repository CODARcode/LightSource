# Swift/t + DataBroker

This set of files demonstrates how to access a DataBroker from swift.

## Environment

To run this demo you need:

 - a Python 3.6 with requirements.txt installed
 - a Python interpreter embedded in swift/t with swift-requirements.txt installed
 - a running local mongodb server

You can create a conda environment, which takes care of all the steps (except the
last one):

```
conda env create -f conda-env.yml
```

The mongodb server can be installed as follows:

```
sudo apt update && sudo apt install mongodb-server
```

## Execution

To run this:

 - copy local.yml to `~/.config/databroker/local.yml` (or someplace
   else on the search path, see
   https://nsls-ii.github.io/databroker/configuration.html#search-path)
 - then in 3 different sessions run the following:
   - **1st**: `conda activate swift-t` and `bluesky-0MQ-proxy 2000 2001`
   - **2nd**: `conda activate swift-t` and `swift-t -n <number-of-cores> -l read_databroker.swift`
   - **3rd**: `conda activate swift-t` and `ipython`, and then in the IPython
     session run `%run -i gen_data.py` to generate some synthetic data by
     RunEngine, which will be published to the 0MQ proxy. In the 2nd
     session you should see a bunch of events printed to the screen, meaning
     the swift/t received the events from the proxy.
