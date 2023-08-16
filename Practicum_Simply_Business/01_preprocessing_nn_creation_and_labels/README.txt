
The first part of this ETL pipeline does the following:

1. Downloads images for specific boroughs
2. Loads those images and the labels, which were done by hand
	(Unless you want to label more by hand, you can't change the boroughts)
3. Builds a neural network based on hand-made labels

That neural network is then used by other resources later in the pipeline
Path variables may need to be updated after unzipping.


