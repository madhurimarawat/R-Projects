# Sentimental analysis of a CSV file containing tweets regarding Virat Kohli
# Importing required Libraries
# syuzhet library is used for sentiment extraction or getting the sentiment scores
library(syuzhet)
# SentimentAnalysis library is used for Sentimental analysis
library(SentimentAnalysis)
# ggplot2 is used for plotting the final plot of the sentimental analysis
library(ggplot2)
#Importing Csv file in R which contains all the tweets
tweets<-read.csv("C:\\Users\\rawat\\Documents\\4 SEMESTER\\R for Datascience\\Assigment\\Assignment 1\\Tweets.csv")
#Data Cleaning
#Removing corrupted data/Symbols
clean_tx1 = gsub("(RT|via)((?:\\b\\w*@\\w+)+)","",tweets)
clean_tx2 = gsub("http[^[:blank:]]+","",clean_tx1)
clean_tx3 = gsub("@\\w+","",clean_tx2)
clean_tx4 = gsub("[[:punct:]]","",clean_tx3)
clean_tx5 = gsub("^[[:alnum:]]","",clean_tx4)
#Fetches the sentiments related to tweets
sentiment <- get_nrc_sentiment(clean_tx4)
sentimentscores <- data.frame(colSums(sentiment[,]))
names(sentimentscores) <- "Score"
#Viewing sentiments Score
View(sentimentscores)
#Combining in dataframe to plot
sentimentscores <- cbind("sent"=rownames(sentimentscores),sentimentscores)
rownames(sentimentscores) <- NULL
View(sentimentscores)
#Plotting Output in ggplot2
ggplot(data=sentimentscores,aes(x=sent,y=Score))+geom_bar(aes(fill=sent),stat="identity")+
  theme(legend.position = "none")+ xlab("Sentiments")+ ylab("Scores/Count") + ggtitle("Sentimental Analysis of Twitter Plot")
