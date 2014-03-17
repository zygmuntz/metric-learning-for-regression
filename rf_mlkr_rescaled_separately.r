# source( '/path/to/the/project/dir/rf_mlkr_rescaled_separately.r' )

# five points for getting the base dir automatically
base_dir = '/path/to/the/project/dir/'
setwd( base_dir )

source( 'f_rmse.r' )

# run the matlab script to produce these files
train_file = 'data/rescaled_separately/train.csv'
validation_file = 'data/rescaled_separately/validation.csv'
test_file = 'data/rescaled_separately/test.csv'
label_index = 1

source( '_rf.r' )
