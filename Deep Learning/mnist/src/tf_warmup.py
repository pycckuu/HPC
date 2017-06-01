"""
Linear regression

Modified by Weiguang Guan, Sharcnet/CC, May 2017
"""

import os
import numpy as np
import tensorflow as tf

os.environ['TF_CPP_MIN_LOG_LEVEL'] = '3'

# Model parameters
W = tf.Variable([.3], tf.float32)
b = tf.Variable([-.3], tf.float32)

# Model input and output
x = tf.placeholder(tf.float32)
output = W * x + b
y = tf.placeholder(tf.float32)

# loss
loss = tf.reduce_sum(tf.square(output - y)) # sum of the squares

# optimizer
optimizer = tf.train.GradientDescentOptimizer(0.01)
train = optimizer.minimize(loss)

# training data
x_train = [1,2,3,4]
y_train = [0,-1,-2,-3]

# training loop
init = tf.global_variables_initializer()
sess = tf.Session()
sess.run(init) # reset values to a state for the training to start with

for i in range(1000):
    sess.run(train, {x:x_train, y:y_train})
    if (i%100==0) :
        # evaluate training accuracy
        curr_W, curr_b, curr_loss  = sess.run([W, b, loss], {x:x_train, y:y_train})
        print("W: %s b: %s loss: %s"%(curr_W, curr_b, curr_loss))

# write log
writer = tf.summary.FileWriter("log", graph=tf.get_default_graph())


