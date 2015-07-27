import time
import subprocess
from json import load as json_load
from urllib import urlopen
import numpy as np
import warnings

class route():
    """ A class for get distance between points by finding a route.

    Uses OSRM-Project API for routing. It sends requests to local OSRM machine
    and gets distance from json-formatted responce.

    Possible errors:
        - Cannot find route between points:
            OSRM machine can't find route between given points. In this
            case it will try to locate given points to closest OSM node,
            and try to find route between located points.

    Attributes
    ----------
    osrm: subprocess
        Local OSRM machine.

    Notes
    -----
    See https://github.com/Project-OSRM/osrm-backend/wiki for OSRM-Project API.

    """
    osrm = None
    cache = {}

    def start(self):
        """ Start local OSRM machine.

        Needs time to start, contains a 5 seconds sleep statement.

        You can have one running machine per instance of class.

        """
        if self.osrm is None:
            osrm = subprocess.Popen('osrm-routed ~/map/map.osrm', shell=True)
            time.sleep(5)
            self.osrm = osrm

    def route_distance(self, a, b):
        """ Get distance between points.

        Get distance between points a and b by finding route on OSM map.

        Parameters
        ----------
        a: array-like, shape=[2]
            Coordinates of first point.
        b: array-like, shape=[2]
            Coordinates of second point.

        Returns
        -------
        dist: int
            Route distance between given points.

        """
        # if shape of given arrays isn't [2]
        if a.shape[0] == 1:
            a = np.array([a[0][0], a[0][1]])
        if b.shape[0] == 1:
            b = np.array([b[0][0], b[0][1]])

        # trying to find distance between points in cache
        c = map(lambda i: np.round(i, decimals=5), a)
        d = map(lambda i: np.round(i, decimals=5), b)
        key1 = '{}{}{}{}'.format(*np.append(c, d))
        key2 = '{}{}{}{}'.format(*np.append(d, c))
        try:
            dist = self.cache[key1]
        except KeyError:
            pass
        try:
            dist = self.cache[key2]
        # if not found
        except KeyError:
            if np.array_equal(c, d):
                # if points are the same return zero
                dist = 0.0
            else:
                # send request to find route between points
                url = "http://localhost:5000/viaroute?loc={},{}&loc={},{}" \
                    "&geometry=false&alt=false".format(*np.append(a, b))
                # get responce
                responce = urlopen(url)
                # parse json
                data = json_load(responce)

                # if route isn't found
                if data['status'] is not 0:
                    # show warning
                    warnings.warn('Cannot find route between {},{} ' \
                        'and {},{}. Trying to locate points.' \
                        ''.format(*np.append(a, b)))
                    # locate first point
                    loc = 'http://localhost:5000/locate?loc={},{}'.format(*a)
                    l_resp = urlopen(loc)
                    l_data = json_load(l_resp)
                    # if can't locate
                    if l_data['status'] is not 0:
                        # stop osrm machine
                        self.stop()
                        # throw error
                        raise ValueError(l_data['status_message'])
                    else:
                        first = l_data['mapped_coordinate']

                    # locate second point
                    loc = 'http://localhost:5000/locate?loc={},{}'.format(*b)
                    l_resp = urlopen(loc)
                    l_data = json_load(l_resp)
                    if l_data['status'] is not 0:
                        self.stop()
                        raise ValueError(l_data['status_message'])
                    else:
                        second = l_data['mapped_coordinate']

                    # try to find route between located points
                    url = "http://localhost:5000/viaroute?loc={},{}&loc={},{}" \
                        "&geometry=false&alt=false".format(*np.append(first, second))
                    responce = urlopen(url)
                    data = json_load(responce)
                    if data['status'] is not 0:
                        self.stop()
                        raise ValueError(data['status_message'])
                # if route is found return distance
                dist = data['route_summary']['total_distance']
            self.cache[key1] = dist
            self.cache[key2] = dist
        return dist

    def stop(self):
        """ Stop local OSRM machine.

        """
        if self.osrm is not None:
            self.osrm.terminate()
            self.osrm = None

if __name__ == "__main__":
    a = np.array([48.763205, 44.779587])
    b = np.array([48.798497, 44.765854])
    rt = route()
    rt.start()
    print(rt.route_distance(a, b))
    rt.stop()
