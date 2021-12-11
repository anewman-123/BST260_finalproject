# BST260_finalproject

# Instructions

Prior to opening any of the files, please download rideshare_kaggle.csv at https://www.kaggle.com/brllrb/uber-and-lyft-dataset-boston-ma. Ensure that this file is saved as "rideshare_kaggle.csv" in one of your local directories. Within the chunk of code for reading in the dataset, there is a line of code called setwd(). Make sure to copy and paste the directory that the data is saved into setwd(). While this line of code runs, the working directory will temporarily be set to where you saved the data so you can read in the csv file. Note that this was our only option as rideshare_kaggle.csv is too big for GoogleDrive and Github. These instructions are also repeated in each of the Rmd files. 


You will find 5 files (all of which have been knitted too). The files should be opened in the following order:

1. "Description.Rmd": gives a description of our project, including overview and motivation, related work, initial questions, data, and exploratory analysis. 

2. "HypothesisTesting.Rmd": Analysis done by Natalie Gomas. This includes a variety of hypothesis tests exploring multiple features and their relationship to price of ride. Additionally, there are comparisons for each pair of comparable car types between Uber and Lyft.

3. "Geospatial.Rmd": Analysis done by Allison newman

4. "ML_Models.Rmd" done by Valentina Carducci and Elea Bach. This file includes a variety of Machine Learning models to predict price, some data pre processing, some feature importance extraction code as well as some performance analysis and visualisations. As mentioned in the Rmd file, although we ran a plethora of random forest models to get to the best one, for the sake of time not all of them will be ran or commented (although the code is included) as they take too long to run. We made a note of all the code that is not being run, and we explained what it was used for and how it compared to the model we eventually decided to use. The best models (one for each app) for the random forest section were included, run, and throughly commented.

5. "app.R" Shiny App done by Natali Sorajja


You can also check out the knit html files that go by the same names! Have fun exploring!



