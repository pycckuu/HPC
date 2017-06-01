"""
The main program for training.

Modified by Weiguang Guan, Sharcnet/CC, May 2017
"""

import mnist_loader
import network

# load the data in a desired format
training_data, validation_data, test_data = mnist_loader.load_data_wrapper()

# define the NN
net = network.Network([784, 30, 10]) 
#net = network.Network([784, 50, 10])
#net = network.Network([784, 100, 30, 10])

# train with Stochastic Gradient Descent
net.SGD(training_data, 30, 10, 3.0, test_data=test_data) 
net.savemodel("digitsRecogModel")
#net.SGD(training_data, 30, 10, 0.01, test_data=test_data)
#net.SGD(training_data, 30, 10, 100.0, test_data=test_data)
#net.SGD(training_data, 30, 100, 3.0, test_data=test_data)
