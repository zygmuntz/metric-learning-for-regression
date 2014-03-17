# the main part of the random forest script

library( randomForest )
ntrees = 400

train = read.csv( train_file, header = F )
validation = read.csv( validation_file, header = F )
test = read.csv( test_file, header = F )

x_train = train[, -label_index]
y_train = train[, label_index]

x_validation = validation[, -label_index]
y_validation = validation[, label_index]

x_test = test[, -label_index]
y_test = test[, label_index]

###

rf = randomForest( x_train, y_train, ntree = ntrees, do.trace = 10 ) 

p_validation = predict( rf, x_validation )
p_test = predict( rf, x_test )

cat( "validation RMSE:", rmse( y_validation, p_validation ))
cat( "test RMSE:", rmse( y_test, p_test ))
