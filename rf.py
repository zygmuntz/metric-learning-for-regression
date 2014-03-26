'random forest on kin8nm'

import numpy as np
from sklearn.ensemble import RandomForestRegressor as RF
from sklearn.metrics import mean_squared_error as MSE
from math import sqrt

train_file = 'data/train.csv'
valid_file = 'data/validation.csv'
test_file = 'data/test.csv'

print "loading data..."

train = np.loadtxt( open( train_file ), delimiter = "," )
valid = np.loadtxt( open( valid_file ), delimiter = "," )
test = np.loadtxt( open( test_file ), delimiter = "," )

train_y = train[:,-1]
valid_y = valid[:,-1]
test_y = test[:,-1]

train_x = train[:,0:-1]
valid_x = valid[:,0:-1]
test_x = test[:,0:-1]


print "training..."

trees = 100

rf = RF( n_estimators = trees, verbose = True )
rf.fit( train_x, train_y )

p_valid = rf.predict( valid_x )
p_test = rf.predict( test_x )

###

valid_rmse = sqrt( MSE( valid_y, p_valid ))
test_rmse = sqrt( MSE( test_y, p_test ))

print "validation RMSE:", valid_rmse
print "test RMSE:", test_rmse

"""
some runs

validation RMSE: 0.140025930655
test RMSE: 0.140510695461

validation RMSE: 0.136980260324
test RMSE: 0.138909475351

validation RMSE: 0.138677092046
test RMSE: 0.138911281774
"""

	
	
		