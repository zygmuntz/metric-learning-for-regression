'PCA + random forest on kin8nm'

import numpy as np
from sklearn.decomposition import PCA
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

print "performing PCA..."

pca = PCA( n_components = train_x.shape[1] )

# on training set only
pca.fit( train_x )

# on everything
# pca.fit( np.vstack(( train_x, valid_x, test_x )))

train_x = pca.transform( train_x )
valid_x = pca.transform( valid_x )
test_x = pca.transform( test_x )

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

pca on train:

validation RMSE: 0.134099989477
test RMSE: 0.126835836624

validation RMSE: 0.135950236806
test RMSE: 0.126866507844

validation RMSE: 0.134859570111
test RMSE: 0.127866406713

pca on whole x:

validation RMSE: 0.144654448477
test RMSE: 0.138702517823

validation RMSE: 0.144685440717
test RMSE: 0.140620597785

validation RMSE: 0.144821592515
test RMSE: 0.139851355168
"""


	
	
		