# BST260_finalproject

# Instructions

The dataset that all of the Rmd files utilized is called "rideshare_kaggle.csv.zip". Since the data was too big to be downloaded directly into Github via the website interface or the terminal, we had to compress the data so it is less than 100 MB. Then, the data was added and pushed to the repository via the terminal. It is surprisingly easy to work with zip file, as you can call read_csv("rideshare_kaggle.csv.zip") or read.csv(unz("rideshare_kaggle.csv.zip", "rideshare_kaggle.csv")). After using comparedf(), you can see that read_csv("rideshare_kaggle.csv.zip") is equivalent to read_csv("rideshare_kaggle.csv") and read.csv(unz("rideshare_kaggle.csv.zip", "rideshare_kaggle.csv")) is the same as read.csv("rideshare_kaggle.csv"). The values within the data frames stay the same, but a few of the variable types slightly change. This generally does not create issues, and each team member chose the method that matched the data frame of the method they used before we compressed the file. 


You will find 5 files (all of which have been knitted too). The files should be opened in the following order:

1. "Description.Rmd": gives a description of our project, including overview and motivation, related work, initial questions, data, and exploratory analysis. 

2. "HypothesisTesting.Rmd": Analysis done by Natalie Gomas. This includes a variety of hypothesis tests exploring multiple features and their relationship to price of ride. Additionally, there are comparisons for each pair of comparable car types between Uber and Lyft.

3. "geospatial_analysis.Rmd": Analysis done by Allison Newman. This includes various map visualizations to identify the cheaper routes between UberX and Lyft. Additionally, the average prices and distanced traveled for rides going into each destination is identified and analyzed via tables and maps. 

4. "ML_Models.Rmd" done by Valentina Carducci and Elea Bach. This file includes a variety of Machine Learning models to predict price, some data pre processing, some feature importance extraction code as well as some performance analysis and visualisations. As mentioned in the Rmd file, although we ran a plethora of random forest models to get to the best one, for the sake of time not all of them will be ran or commented (although the code is included) as they take too long to run. We made a note of all the code that is not being run, and we explained what it was used for and how it compared to the model we eventually decided to use. The best models (one for each app) for the random forest section were included, run, and throughly commented.

5. "app.R" Shiny App done by Natali Soraja. This app uses two xgBoost regression models, created by Elea and Valentina, to predict price. The user puts in several inputs that are predictors within this model (ex: information about the weather and current time), and if they indicate that they would like to use UberX, their inputs are then put into a model that was trained specifically to UberX data. Conversely, if they would like to use Lyft, their inputs are then put into a different xgBoost model that was trained to Lyft data. The output, which is their printed predicted price, is designed to be reactive to each input, so it changes immediately with new entered information. 


You can also check out the knit html files that go by the same names! Have fun exploring!



