% run( '/path/to/mlkr_rescale_separately.m' )

% transform the data with MLKR

data_dir = '/path/to/the/project/dir/data'
mlkr_dir = '/path/to/MLKR0.9'
output_dir = '/path/to/the/project/dir/data/rescaled_separately'	% different from data_dir because file names are the same

max_iterations = 50
output_dimensionality = 8

% load data

cd( data_dir )

train = csvread( 'train.csv' );
validation = csvread( 'validation.csv' );
test = csvread( 'test.csv' );

size( train )
size( validation )
size( test )

% label index is 9

train_x = train(:,1:8);
train_y = train(:,9);

validation_x = validation(:,1:8);
validation_y = validation(:,9);

test_x = test(:,1:8);
test_y = test(:,9);

train_len = size( train_x, 1 );
validation_len = size( validation_x, 1 );

size( train_x )
size( validation_x )
size( test_x )

% rescale (together) and go

cd( mlkr_dir )
setpaths

all_x = [ train_x; validation_x; test_x ]';
all_x = rescale( all_x );

% split back
train_x = all_x(:, 1:train_len);
validation_x = all_x(:, (train_len+1):(train_len+validation_len));
test_x = all_x(:, (train_len+validation_len+1):end);

size( train_x )
size( validation_x )
size( test_x )

%% run MLKR (and visualize the embedding of the test data)
fprintf('Running minimize...\n');
tic;
L = mlkr( train_x, train_y', 'maxiter', -max_iterations, 'outdim', output_dimensionality ); 
%, 'function', @(L) visLx( L, validation_x, validation_y' ));
t = toc;

fprintf( 'Training time: %2.2fs\n', t );

% now that we have L, let's transform and save the data

cd( output_dir )

new_train_x = L * train_x;
new_validation_x = L * validation_x;
new_test_x = L * test_x;

% let's put y in the first column now
csvwrite( 'train.csv', [ train_y new_train_x' ] );
csvwrite( 'validation.csv', [ validation_y new_validation_x' ] );
csvwrite( 'test.csv', [ test_y new_test_x' ] );
csvwrite( 'L.csv', L );
