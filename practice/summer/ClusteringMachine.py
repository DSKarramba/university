import json
import numpy as np
import matplotlib.pyplot as plt

class ClusteringMachine():
    """ General class for clustering machine.

    Parameters
    ----------
    X : array, [n_points, n_dimensions]
        Coordinates of points.

    Attributes
    ----------
    X : array, [n_points, n_dimensions]
        Coordinates of points.
    labels : array, [n_points]
        Labels of each point.
    cluster_centers : array, [n_clusters, n_dimensions]
        Coordinates of cluster centers.
    n_cluster : int
        Number of clusters.
    cluster_instance : class
        Class used for clustering.
    fit_time : float
        Time of clustering.
    """
    X = None
    labels = None
    cluster_centers = None
    n_cluster = None
    cluster_instance = None
    fit_time = 0

    def __init__(self, X):
        self.X = X

    def fit(self):
        """ Perform clustering.

        """
        self.cluster_instance.fit(self.X)

    def plotClusters(self, plotCenters = True):
        """ Plot the results of clustering.

        Parameters
        ----------
        plotCenters : boolean, default True
            If true, mark centers of clusters on plot.

        Notes
        -----
        Uses matplotlib.pyplot for plotting data.
        """
        # set colors of clusters
        colors = 10 * ['r.', 'g.', 'm.', 'c.', 'k.', 'y.', 'b.']
        # create a new figure
        plt.figure()
        # for each point in X array
        for i in range(len(self.X)):
            # plot it on figure with specified color
            plt.plot(self.X[i][0], self.X[i][1],
                     colors[self.labels[i]], markersize = 5)
        # if plotCenters set to True, plot cluster centers as "X" marks
        if plotCenters:
            plt.scatter(self.cluster_centers[:, 0],
                        self.cluster_centers[:, 1], marker = "x",
                        s = 150, linewidths = 2.5, zorder = 10)
        # showing result
        plt.show()

    def exportCentersToTextFile(self, filename):
        """ Record cluster centers to text file.

        Parameters
        ----------
        filename : string path
            Recording file name.

        Notes
        -----
        Uses JSON data format.
        """
        try:
            with open(filename, 'w') as file_:
                json.dump(self.cluster_centers.tolist(), file_)
        except IOError as e:
            print('{}'.format(e))

    def exportPointsToTextFile(self, filename):
        """ Record points with labels to text file.

        Parameters
        ----------
        filename : string path
            Recording file name.

        Notes
        -----
        Uses JSON data format.
        """
        # create new array with one more dimension for points
        X_ = np.empty((len(self.X), 3))
        # for each point in X array
        for i in range(len(X_)):
            # set X_[i][0] and X_[i][1] to point coordinates
            X_[i][0], X_[i][1] = self.X[i][0], self.X[i][1]
            # set X_[i][2] to point label
            X_[i][2] = self.labels[i]

        try:
            with open(filename, 'w') as file_:
                json.dump(X_.tolist(), file_)
        except IOError as e:
            print('{}'.format(e))
