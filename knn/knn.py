import math
from csv import reader
from random import random, randint
import operator


class KNN:
    def __init__(self, k, filename, ratio):
        self.training_set = []
        self.test_set = []
        self.k = k
        self.filename = filename
        self.ratio = ratio

    def load_and_parse(self):
        with open(self.filename, 'rb') as data_set:
            lines = reader(data_set)
            data_set = list(lines)
            for x in range(len(data_set) - 1):
                for y in range(0, 4, 1):
                    data_set[x][y] = float(data_set[x][y])
                if random() < self.ratio:
                    self.training_set.append(data_set[x])
                else:
                    self.test_set.append(data_set[x])

    def random_test_point(self):
        return self.test_set[randint(0, len(self.test_set) - 1)]

    @staticmethod
    def distance(a, b, size):
        d = 0
        for x in range(size):
            d += pow((a[x] - b[x]), 2)
        return math.sqrt(d)

    def get_neighbors(self, test_point):
        distances = []
        size = len(test_point) - 1
        for x in range(len(self.training_set)):
            dist = self.distance(test_point, self.training_set[x], size)
            distances.append((self.training_set[x], dist))
        distances.sort(key=operator.itemgetter(1))
        neighbors = []
        for x in range(self.k):
            neighbors.append(distances[x][0])
        return neighbors

    @staticmethod
    def get_class(neighbors):
        votes = {}
        for x in range(len(neighbors)):
            klass = neighbors[x][-1]
            if klass in votes:
                votes[klass] += 1
            else:
                votes[klass] = 1
        sorted_votes = sorted(votes.items(), key=operator.itemgetter(1), reverse=True)
        return sorted_votes[0][0]

    def predict(self, test_point):
        neighbors = self.get_neighbors(test_point)
        prediction = self.get_class(neighbors)
        return prediction


if __name__ == '__main__':
    knn = KNN(k=3, filename='iris.csv', ratio=0.7)
    knn.load_and_parse()
    test_point = knn.random_test_point()
    print(test_point)
    print(knn.predict(test_point))