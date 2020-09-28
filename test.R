
library(readxlsb)
loandata <- read_xlsb(path = "C:(1)\\Sample-Data.xlsb",
                                     package = "readxlsb",sheet =  "Sheet1")


colnames(loandata) <- gsub("[[:punct:]]","_",colnames(loandata))
summary(loandata)

loandata$Fund_loan_Amount <- ifelse(loandata$loan_amnt == loandata$funded_amnt, "Equal","Different")
loandata$Fund_Invest_Amount <- ifelse(loandata$funded_amnt == loandata$funded_amnt_inv, "Equal","Different")
loandata$loan_amnt <- NULL
loandata$funded_amnt <- NULL
loandata$funded_amnt_inv <- NULL
loandata$id <- rownames(loandata)
loandata$sub_grade <- NULL
loandata$emp_title <- NULL
loandata$title <- NULL
loandata$zip_code <- NULL
loandata$addr_state <- NULL
loandata$earliest_cr_line <- NULL
loandata$last_pymnt_d <- NULL
loandata$issue_d <- NULL
loandata$next_pymnt_d <- NULL
loandata$last_credit_pull_d <- NULL



loandata1 <- loandata
loandata1[sapply(loandata1,is.character)] <- lapply(loandata1[sapply(loandata1, is.character)],as.factor)

Miss <- colSums(is.na(loandata1))/nrow(loandata1)*100
Miss_Value <- Miss[Miss<15]
Miss_Value.df <- data.frame(Miss_Value)
Miss_Value.df$Variable <- row.names(Miss_Value.df)
loandata2 <- loandata1[Miss_Value.df$Variable]
table(loandata2$loan_status,useNA = "always")

catdata <- loandata2[,sapply(loandata2,is.factor) & colnames(loandata2) != "id"]
catdata$loan_status <- NULL
numdata <- loandata2[,sapply(loandata2,is.numeric) ]
id <- loandata2[ , c("id","loan_status")]
catdata1 <- dummy.data.frame(catdata)
final <- cbind(id,catdata1,numdata)
# historical data
hist.loandata <- subset(final , final$loan_status != "Current")
hist.loandata$loan_status <- droplevels(hist.loandata$loan_status)
table(hist.loandata$loan_status,useNA = "always")


sampl <- rbinom(dim(hist.loandata)[1],1,0.75)

traindata <- hist.loandata[sampl == 1 ,]
testdata <- hist.loandata[sampl == 0, ]
# Model
######Building using x GBM
closure_time_x <- subset(traindata,select = -c(id,loan_status))
closure_time_y <- subset(traindata,select = c(loan_status))

###Finding optimal hyper parameters
#Base Model
#####grid
xgb_grid_default = expand.grid(
  nrounds = 100,
  max_depth = 6,
  eta=0.3,
  gamma = 0,
  colsample_bytree=1,
  min_child_weight=1,
  subsample=1
)
#####train control parameters
xgb_trcontrol_default = trainControl(
  method = "cv",
  number = 5,
  verboseIter = TRUE,
  returnData = FALSE,
  returnResamp = "all",                                                        
  allowParallel = TRUE
)
#######Train model
xgb_train_default = train(
  x = closure_time_x,
  y = closure_time_y$loan_status,
  trControl = xgb_trcontrol_default,
  tuneGrid = xgb_grid_default,
  method = "xgbTree"
)
#####Test Model for Base model conditions
closure_time_train_x <- subset(traindata,select = -c(id,loan_status))
traindata$predicted_loanstatus = predict(xgb_train_default, closure_time_train_x)
###
closure_time_test_x <- subset(testdata,select = -c(id,loan_status))
testdata$predicted_loanstatus = predict(xgb_train_default, closure_time_test_x)

traincf <- table(traindata$loan_status,traindata$predicted_loanstatus)
table(testdata$loan_status,testdata$predicted_loanstatus)

#Train accuracy
cf_matrix_train <- as.matrix(table(traindata$loan_status,traindata$predicted_loanstatus))

TN_train <- cf_matrix_train[1,1]
FN_train <- cf_matrix_train[2,1]
FP_train <- cf_matrix_train[1,2]
TP_train <- cf_matrix_train[2,2]

accuracy_train <- ((TN_train + TP_train)/(TN_train+TP_train+FN_train+FP_train) )*100
precision_train <- (TP_train / (TP_train+FP_train))*100
recall_train <- (TP_train/(TP_train+FN_train))*100
F1score_train <- (2*precision_Train*recall_train)/(precision_Train+recall_train)

# Test accuracy 
cf_matrix_test <- as.matrix(table(testdata$loan_status,testdata$predicted_loanstatus))

TN_test <- cf_matrix_test[1,1]
FN_test <- cf_matrix_test[2,1]
FP_test <- cf_matrix_test[1,2]
TP_test <- cf_matrix_test[2,2]

accuracy_test <- ((TN_test + TP_test)/(TN_test+TP_test+FN_test+FP_test) )*100
precision_test <- (TP_test / (TP_test+FP_test))*100
recall_test <- (TP_test/(TP_test+FN_test))*100
F1score_test <- (2*precision_test*recall_test)/(precision_test+recall_test)
##### prediction for open opportunity

pred.loandata <- subset(final , final$loan_status == "Current")
preddata <- subset(pred.loandata,select = -c(id,loan_status))
pred.loandata$predicted_loanstatus = predict(xgb_train_default, preddata)
pred.loandata$predicted_probability = predict(xgb_train_default, preddata,type = "prob")
table(pred.loandata$predicted_loanstatus,useNA = "always")

# variable importance
varImp(xgb_train_default)
