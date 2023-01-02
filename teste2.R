library(arules)
data()
data("Groceries")
dim(Groceries)
itemLabels(Groceries)
summary(Groceries)
itemFrequencyPlot(Groceries, topN=10)
rules <- apriori(Groceries, parameter = list(supp=0.1, conf=0.9, target= "rules"))
summary(rules)

market_basket <-  
  list(  
    c("apple", "beer", "rice", "meat"),
    c("apple", "beer", "rice"),
    c("apple", "beer"), 
    c("apple", "pear"),
    c("milk", "beer", "rice", "meat"), 
    c("milk", "beer", "rice"), 
    c("milk", "beer"),
    c("milk", "pear")
  )

# set transaction names (T1 to T8)
names(market_basket) <- paste("T", c(1:8), sep = "")
trans <- as(market_basket, "transactions")
dim(trans)
itemLabels(trans)
summary(trans)
itemFrequencyPlot(trans, topN=10)
rules <- apriori(trans, parameter = list(supp=0.3, conf=0.5, maxlen=10, target= "rules"))
summary(rules)
