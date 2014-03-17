% run( 'D:/devel/ml/datasets/kin/matlab/kin_mlkr2.m' )

% transform the data with MLKR

data_dir = '/path/to/the/project/dir/data'
mlkr_dir = '/path/to/MLKR0.9'
output_dir = '/path/to/the/project/dir/data/rescaled_together'	% different from data_dir because file names are the same

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

% rescale and go 

cd( mlkr_dir )
setpaths

% let's try rescaling separately
% note the transpose
train_x = rescale( train_x' );
validation_x = rescale( validation_x' );
test_x = rescale( test_x' );

%% run MLKR (and visualize the embedding of the test data)
fprintf('Running minimize...\n');
tic;
L = mlkr( train_x, train_y', 'maxiter', -max_iterations, 'outdim', output_dimensionality );
% output is 8-dimensional so visualization in 2D won't be interesting
%, 'function', @(L) visLx( L, validation_x, validation_y' ));
t = toc;

fprintf( 'Training time: %2.2fs\n', t );

%{
	
Running minimize...
Function evaluation      7;  Value 1.366336e+002
Function evaluation      8;  Value 6.006428e+001
Function evaluation     10;  Value 5.238214e+001
Function evaluation     13;  Value 5.056019e+001
Function evaluation     15;  Value 4.925294e+001
Function evaluation     17;  Value 4.874575e+001
Function evaluation     18;  Value 4.824040e+001
Function evaluation     19;  Value 4.767347e+001
Function evaluation     20;  Value 4.702774e+001
Function evaluation     21;  Value 4.651451e+001
Function evaluation     22;  Value 4.604635e+001
Function evaluation     23;  Value 4.572117e+001
Function evaluation     25;  Value 4.560752e+001
Function evaluation     27;  Value 4.534928e+001
Function evaluation     28;  Value 4.512728e+001
Function evaluation     29;  Value 4.499625e+001
Function evaluation     31;  Value 4.496305e+001
Function evaluation     33;  Value 4.488169e+001
Function evaluation     35;  Value 4.482958e+001
Function evaluation     37;  Value 4.481034e+001
Function evaluation     38;  Value 4.478932e+001
Function evaluation     39;  Value 4.476916e+001
Function evaluation     41;  Value 4.475914e+001
Function evaluation     43;  Value 4.475368e+001
Function evaluation     45;  Value 4.475044e+001
Function evaluation     46;  Value 4.474721e+001
Function evaluation     48;  Value 4.474536e+001
Function evaluation     49;  Value 4.474404e+001
%}

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
