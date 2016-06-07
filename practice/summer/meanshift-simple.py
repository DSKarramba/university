import time
import numpy as np
from sklearn.cluster import MeanShift
from sklearn.cluster import estimate_bandwidth
from DataCollector import DataCollector
from ClusteringMachine import ClusteringMachine

class MeanShiftClusteringMachine(ClusteringMachine):
    """ A derived class from ClusteringMachine.

    Performs clustering with using Mean Shift algorithm.

    Parameters
    ----------
    X : array, [n_points, n_dimensions]
        Coordinates of points.
    useEstimateBandwidth : boolean, default True
        If true, use sklearn.cluster.estimate_bandwidth for bandwidth
        calculation.
    binSeeding : boolean, default True
        If true, speed up algorithm by initializing fewer seeds.

    """
    def __init__(self, X, useEstimateBandwidth = True, binSeeding = True):
        self.X = X
        self.fit_time = time.time()

        if useEstimateBandwidth:
            bandwidth_ = estimate_bandwidth(self.X, quantile = 0.3)
        else:
            bandwidth_ = None
        # set cluster instanse to sklearn.cluster.MeanShift with
        # given parameters
        self.cluster_instance = MeanShift(bandwidth = bandwidth_,
            bin_seeding = binSeeding)

    def fit(self):
        """ Perform clustering.

        """
        # perform clustering
        self.cluster_instance.fit(self.X)
        # get points labels
        self.labels = self.cluster_instance.labels_
        # get cluster centers
        self.cluster_centers = self.cluster_instance.cluster_centers_
        # get clusters number
        self.n_cluster = len(np.unique(self.labels))
        # calculate time
        self.fit_time = time.time() - self.fit_time

if __name__ == '__main__':
    # if running as script

    # create DataCollector object
    dc = DataCollector()
    # upload data from 'data.txt' file
    dc.uploadFromTextFile('data.txt', delimiter = ', ')
    # plot collected data
    # dc.plotData()
    # get data from dc object
    X = dc.getData()[::30]

    # create MeanShiftClusteringMachine object with default parameters
    ms = MeanShiftClusteringMachine(X)
    # perform clustering
    ms.fit()
    # print info
    time.sleep(.5)
    print('Fit time: {}, clusters: {}'.format(ms.fit_time, ms.n_cluster))
    # plot results
    # ms.plotClusters()
    # export centers to 'centers.js'
    ms.exportCentersToTextFile('c_centers.js')
    # export points to 'points.js'
    ms.exportPointsToTextFile('p_points.js')
