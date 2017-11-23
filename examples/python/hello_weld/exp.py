
from lib import *
import numpy as np

import weld.bindings as weld

import time

# Input data size
size = (2 << 20)

a_orig = np.array(np.random.rand((size)), dtype="float32")

#weld.weld_set_log_level(weld.WeldLogLevelTrace)

print "Running Weld..."
start = time.time()
a = HelloWeldVector(a_orig)
a = a.exp()
res = a.weldobj.evaluate(WeldVec(WeldFloat()), verbose=True)
end = time.time()
print "Weld result:", res
weld_time = (end - start)
print "({:.3} seconds)".format(weld_time)

print "Running NumPy..."
start = time.time()
res = np.exp(a_orig)
end = time.time()
np_time = (end - start)
print "({:.3} seconds)".format(np_time)

print "NumPy result:", res
