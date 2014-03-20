Metric Learning for Kernel Regression
=====================================

See [http://fastml.com/good-representations-distance-metric-learning-and-supervised-dimensionality-reduction](http://fastml.com/good-representations-distance-metric-learning-and-supervised-dimensionality-reduction/) for description.

Download and install [MLKR](http://www.cse.wustl.edu/~kilian/code/code.html) (Matlab).

Edit paths in the following scripts and run them:

	mlkr_rescale_separately.m
	rf_mlkr_rescaled_separately.r
	
	mlkr_rescale_together.m
	rf_mlkr_rescaled_together.r

The first script in each pair transforms the dataset, the second trains a random forest. 

The rescaling method doesn't seem to matter with this dataset.
