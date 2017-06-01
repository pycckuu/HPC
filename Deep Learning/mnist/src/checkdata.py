"""
Check mnist data ...

Modified by Weiguang Guan, Sharcnet/CC, May 2017
"""

import matplotlib.cm as cm      # color map
import matplotlib.pyplot as plt  # plot

import gzip     # gzip
import pickle   # used for loading mnist dataset

# Load the dataset
with gzip.open('../data/mnist.pkl.gz', 'rb') as f:
    train_set, valid_set, test_set = pickle.load(f, encoding='latin1')

#print("Size of training set: "+ str(len(train_set)))
#print("Size of validation set: "+ str(len(valid_set)))
#print("Size of testing set: "+ str(len(test_set)))

train_x, train_y = train_set    # image data and labels

print("Number of samples in the training set: " + str(len(train_x)))
print("Size of image: " + str(len(train_x[0])))

# display the first 20 images in a 4x5 grid layout
fig = plt.figure()
for i in range(20):
    fig.add_subplot(4, 5, i + 1)
    plt.imshow(train_x[i].reshape((28, 28)), cmap=cm.Greys_r)
    print("Label of image: " + str(train_y[i]))
plt.show()
