from __future__ import division
import json
import time
import random
import numpy as np
from DataCollector import DataCollector
from ClusteringMachine import ClusteringMachine
from route import route

class InitMachine():
    """ Initializes centers of clusters.

    Attributes
    ----------
    centers : array, [n_clusters, n_dimensions + 1]
    """
    centers = None

    def __init__(self):
        self.centers = np.empty([0, 3])

    def grid(self, gridSize, bounds):
        """ Initialize centers by grid.

        Parameters
        ----------
        gridSize : array {size_x, size_y}
            Set grid size.
        bounds : array {bottom_border, left_border, top_border, right_border}
            Specify borders.
        """
        delta_lt = (bounds[2] - bounds[0]) / gridSize[0]
        delta_ln = (bounds[3] - bounds[1]) / gridSize[1]
        curr_lt = bounds[0] + delta_lt / 2
        curr_ln = bounds[1] + delta_ln / 2

        self.centers = np.append(self.centers,
            [[curr_lt, curr_ln, 0]], axis = 0)
        for i in range(gridSize[0] * gridSize[1]):
            if curr_ln + delta_ln > bounds[3]:
                if curr_lt + delta_lt > bounds[2]:
                    break
                else:
                    curr_lt += delta_lt
                    curr_ln -= delta_ln * (gridSize[0] - 1)
            else:
                curr_ln += delta_ln
            self.centers = np.append(self.centers,
                [[curr_lt, curr_ln, i + 1]], axis = 0)

    def random(self, count, bounds):
        """ Initialize centers by random.

        Parameters
        ----------
        count : int
            Set clusters count.
        bounds : array {bottom_border, left_border, top_border, right_border}
            Specify borders.
        """
        for i in range(count):
            self.centers = np.append(self.centers,
                [[random.uniform(bounds[0], bounds[2]),
                  random.uniform(bounds[1], bounds[3]), i]],
                axis = 0)

    def file(self, filename):
        """ Initialize centers by random.

        Parameters
        ----------
        filename : int
            Specify source file name.
        """
        i = 0
        for line in open(filename):
          if not '#' in line:
            lat, lon = line.split(' ')[:2]
            self.centers = np.append(self.centers,
                [[float(lat), float(lon), i]], axis = 0)
            i += 1

    def getCenters(self):
        """ Get centers of clusters.

        """
        return self.centers

class KMeans():
    """ K-Means clustering.

    Attributes
    ----------
    max_iteration_ : int
        Maximum iteration number. After reaching it, clustering is
        considered as completed.
    cluster_centers_ : array, [n_clusters, n_dimensions + 1]
        Centers of clusters.
    labels_ : array, [n_points]
        Labels of points.
    route_ : class route

    Parameters
    ----------
    max_iteration : int
        Set maximum iteration number.
    """
    max_iteration_ = None
    cluster_centers_ = None
    labels_ = None
    route_ = route()

    def __init__(self, max_iteration):
        self.max_iteration_ = max_iteration

    def dist(self, a, b, metric):
        """ Calculate distance between two points.

        Parameters
        ----------
        a : array, [n_dimensions]
            First point.
        b : array, [n_dimensions]
            Second point.
        metric : string
            Used metric.
            Known metrics are 'euclid', 'route'.

        Returns
        -------
        r : float
            Distance between points.
        """
        if metric == 'route':
            r = self.route_.route_distance(a, b)
        elif metric == 'euclid':
            r = np.sqrt((b[0] - a[0]) ** 2 + (b[1] - a[1]) ** 2)
        else:
            raise ValueError('Unknown metric: {}'.format(metric))
        return r

    def stop(self, iter, old, new):
        """ Check whenever clustering needs to be stopped.

        Parameters
        ----------
        iter : int
            Number of current iteration.
        old : array, [n_clusters, n_dimensions + 1]
            Centers of clusters on previous iteration.
        new : array, [n_clusters, n_dimensions + 1]
            Centers of clusters on current iteration.

        Returns
        -------
        stop : boolean
            If true, clustering is completed.
        """
        if iter >= self.max_iteration_:
            return True
        return np.array_equal(old, new)

    def fit(self, X, centroids, metric):
        """ Perform clustering.

        Parameters
        ----------
        X : array, [n_points, n_dimensions]
            Coordinates of points.
        centroids : array, [n_clusters, n_dimensions + 1]
            Centers of clusters.
        """
        # set initial parameters
        iteration = 0
        c_old = None

        c_curr = centroids
        l_curr = np.empty([len(X)])

        if metric == 'route':
            self.route_.start()
        # while clustering isn't completed
        while not self.stop(iteration, c_old, c_curr):
            # show iteration number
            print 'iteration {}'.format(iteration + 1)
            # for each point
            for i in range(len(X)):
                # calculate distance between point and all the clusters centers
                distances = [(self.dist(X[i], c_curr[each], metric), each) for
                    each in range(len(c_curr))]
                # sort distances ascending
                distances.sort(key=lambda x: x[0])
                # pick number of cluster, which center has the smallest
                # distance to point
                m = distances[0][1]
                # set label of point
                l_curr[i] = c_curr[m][2]
            # equate the previous and current centers of clusters
            c_old = c_curr

            # create empty python array
            # each item will contain all the points belongs to specific cluster
            arrays = [np.empty([0, 2]) for each in c_curr]
            # array for calculated centers of clusters
            mu = np.empty([len(c_curr), 3])
            # for each point
            for i in range(len(X)):
                # append it to array contained points of specific cluster
                arrays[int(l_curr[i])] = np.append(arrays[int(l_curr[i])],
                    [X[i]], axis = 0)

            # for each cluster
            for i in range(len(arrays)):
                # if it contains points
                if arrays[i] != np.empty([0, 2]):
                    # calculate center of cluster
                    mu[i] = np.append(np.mean(arrays[i], axis = 0), i)
                else:
                    # if it doesn't: pick the old coordinates of center
                    mu[i] = c_curr[i]
            # equate current centroids to calculated
            c_curr = mu

            # increment iteration counter
            iteration += 1
        # record results
        self.cluster_centers_ = c_curr
        self.labels_ = l_curr
        if metric == 'route':
            self.route_.stop()

class KMeansClusteringMachine(ClusteringMachine):
    """ A derived class from ClusteringMachine.

    Performs clustering with using K-Means algorithm.

    Parameters
    ----------
    X : array, [n_points, n_dimensions]
        Coordinates of points.
    init : string, default 'random'
        Specify the initializing type.
    count : int, default 40
        Set clusters count (in random initializing).
    gridSize : array {size_x, size_y}, default [7, 7]
        Set size of grid (in grid initializing).
    filename : string path, default 'init.txt'
        Specify the name of initialize file (in file initializing).
    max_iteration : int, default 50
        Set maximum iteration number.
    header : string, default None
        Set header that contains info about borders.

    Attributes
    ----------
    initM : InitMachine object
        Initializes centers of clusters.
    bounds : array {bottom_border, left_border, top_border, right_border}
        Bounds of initial centers generation.
    """
    initM = None
    bounds = None

    def __init__(self, X, init = 'random', count = 40, gridSize = [7, 7],
                 filename = 'init.txt', max_iteration = 50, header = None):
        self.X = X

        self.initM = InitMachine()
        self.bounds = self.getBounds(header_ = header, points_ = X)
        if init == 'random':
            self.initM.random(count = count, bounds = self.bounds)
        elif init == 'grid':
            self.initM.grid(gridSize = gridSize, bounds = self.bounds)
        elif init == 'file':
            self.initM.file(filename = filename)
        else:
            print('Unrecognized init type: {}'.format(init))
        self.cluster_centers = self.initM.getCenters()
        self.cluster_instance = KMeans(max_iteration = max_iteration)

    def getBounds(self, header_ = None, points_ = None):
        """ Calculate bounds of initial centers generation.

        Parameters
        ----------
        header_ : string
            String contains info about borders.
        points_ : array [n_points, n_dimensions]
            Coordinates of points

        Returns
        -------
        bounds : array {bottom_border, left_border, top_border, right_border}
            Bounds of initial centers generation.
        """
        bounds_ = None
        # if both header_ and points_ are not setted show error
        if header_ == None and points_ == None:
            print('No source to get bounds')
        else:
            # if header_ is setted, split it to get bounds
            if header_:
                bounds_ = [float(n) for n in header_.split()]
            else:
                # if points are setted, choose four coordinates
                # of different points: most bottom, most left,
                # most top and most right, as bounds
                t, r, b, l = points_[0], points_[1], points_[0], points_[1]
                for p in points_[1:]:
                    if p[0] > t[0]:
                        t = p
                    if p[0] < b[0]:
                        b = p
                    if p[1] > r[1]:
                        r = p
                    if p[1] < l[1]:
                        l = p
                bounds_ = [b[0], l[1], t[0], r[1]]
        return bounds_

    def fit(self, metric="route"):
        """ Perform clustering.

        """
        t_start = time.time()
        # perform clustering
        self.cluster_instance.fit(self.X, self.cluster_centers, metric)
        # calculate time
        self.fit_time = time.time() - t_start
        # get points labels
        self.labels = self.cluster_instance.labels_
        # get cluster centers
        self.cluster_centers = self.cluster_instance.cluster_centers_
        # get clusters number
        self.n_cluster = len(np.unique(self.labels))

if __name__ == '__main__':
    # if running as script

    # create DataCollector object
    dc = DataCollector()
    # upload data from 'data.txt' file
    dc.uploadFromTextFile('data.txt', delimiter = ', ')
    # plot collected data
    # dc.plotData()
    # get data from dc object
    X = dc.getData()

    # create KMeansClusteringMachine object with specified parameters
    km = KMeansClusteringMachine(X, init = 'random', max_iteration = 100, count = 40)
    # perform clustering
    km.fit('route')
    # print info
    print('Fit time: {}, clusters: {}'.format(km.fit_time, km.n_cluster))
    # plot results
    # km.plotClusters()
    # export centers to 'centers.js'
    km.exportCentersToTextFile('k_centers.js')
    # export points to 'points.js'
    km.exportPointsToTextFile('k_points.js')
