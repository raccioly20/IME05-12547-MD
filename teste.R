library(caret)
library(C50)
churn <- data.frame(churn_y, churn_x)
table(churn$churn_y) / nrow(churn)
set.seed(42)
myFolds <- createFolds(churn$churn_y, k = 5)
# Compare class distribution
i <- myFolds$Fold1
table(churn$churn_y[i]) / length(i)

myControl <- trainControl(
  summaryFunction = twoClassSummary,
  classProbs = TRUE,
  verboseIter = TRUE,
  savePredictions = TRUE,
  index = myFolds
)

set.seed(42)
model_glmnet <- train(
  churn_y ~ .,
  churn,
  metric = "ROC",
  method = "glmnet",
  tuneGrid = expand.grid(
    alpha = 0:1,
    lambda = 0:10 / 10
  ),
  trControl = myControl
)

plot(model_glmnet)
