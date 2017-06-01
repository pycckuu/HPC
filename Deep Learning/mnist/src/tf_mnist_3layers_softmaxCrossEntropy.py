"""A very simple MNIST classifier.
See extensive documentation at
http://tensorflow.org/tutorials/mnist/beginners/index.md

Modified by Weiguang Guan, Sharcnet/CC, May 2017

NOTE: Unstable while running on CPU-only mode.
"""
from tensorflow.examples.tutorials.mnist import input_data
import tensorflow as tf

# Import data
mnist = input_data.read_data_sets("../data", one_hot=True)

# Create the model
x  = tf.placeholder(tf.float32, [None, 784])
W1 = tf.Variable(tf.zeros([784, 30]))
b1 = tf.Variable(tf.zeros([30]))
y1 = tf.sigmoid(tf.matmul(x, W1) + b1)

W2 = tf.Variable(tf.zeros([30, 10]))
b2 = tf.Variable(tf.zeros([10]))
y  = tf.sigmoid(tf.matmul(y1, W2) + b2)

# Define loss and optimizer
y_ = tf.placeholder(tf.float32, [None, 10])

# The raw formulation of cross-entropy,
#
#   tf.reduce_mean(-tf.reduce_sum(y_ * tf.log(tf.nn.softmax(y)),
#                                 reduction_indices=[1]))
#
# can be numerically unstable.
#
# So here we use tf.nn.softmax_cross_entropy_with_logits on the raw
# outputs of 'y', and then average across the batch.
cross_entropy = tf.reduce_mean(
    tf.nn.softmax_cross_entropy_with_logits(labels=y_, logits=y))
train_step = tf.train.GradientDescentOptimizer(3.5).minimize(cross_entropy)

sess = tf.InteractiveSession()
tf.global_variables_initializer().run()

# Define testing
correct_prediction = tf.equal(tf.argmax(y, 1), tf.argmax(y_, 1))
accuracy = tf.reduce_mean(tf.cast(correct_prediction, tf.float32))

# Train
for i in range(60000):
  batch_xs, batch_ys = mnist.train.next_batch(500)
  sess.run(train_step, feed_dict={x: batch_xs, y_: batch_ys})
  if (i%200==0) :
      print(sess.run(accuracy, feed_dict={x: mnist.test.images,
                                                y_: mnist.test.labels}))

