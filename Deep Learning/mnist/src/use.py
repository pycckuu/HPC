"""
Use saved model to classify test data

Modified by Weiguang Guan, Sharcnet/CC, May 2017
"""

import mnist_loader
import network

# load the data in a desired format
training_data, validation_data, test_data = mnist_loader.load_data_wrapper()

# define the NN
net = network.Network([784, 30, 10]) 

#load a trained model 
net.loadmodel("digitsRecogModel.npy")

# evaluate
print "{0} / {1}".format(net.evaluate(validation_data), len(validation_data))
# print(net.evaluate(test_data))
