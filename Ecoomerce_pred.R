# ----------------------------------------------------------
# IMPORT DATA AND SET UP
# ----------------------------------------------------------

data <- read.csv('./Ecommerce Customers')
View(data)

str(data)

summary(data)

# ----------------------------------------------------------
# CREATE PLOTS AND SEARCH FROM INSIGHTS
# ----------------------------------------------------------

# install.packages(("ggplot2"))

library(ggplot2)

# Correlation between time on website and yearly amount spent ?

  ggplot(data, aes(x=Time.on.Website, y=Yearly.Amount.Spent)) + 
    geom_point(colour="orange") + 
    ggtitle("Time on website against vs Yearly amount spent") + 
    xlab("Time on Website") +
    ylab("Yearly Amount Spent")
  
  
  
  ggplot(data, aes(x=Avg..Session.Length, y=Yearly.Amount.Spent)) +
    geom_point(color="orange") +
    ggtitle("Avg Session Length vs Yearly amount spent") +
    xlab("Avg Session Length") +
    ylab("Yearly Amount Spent")
  
  ggplot(data, aes(x=Time.on.App, y=Yearly.Amount.Spent)) +
    geom_point(color="orange") +
    ggtitle("Time on App vs Yearly amount spent") +
    xlab("Time on App") +
    ylab("Yearly Amount Spent")
  
  
  # pairplot of all variables(continous)
  
  pairs(data[c("Avg..Session.Length", 
               "Time.on.App", 
               "Time.on.Website", 
               "Length.of.Membership",
               "Yearly.Amount.Spent")],
        col = "orange",
        pch = 16,
        labels = c("Avg Session Length", 
                   "Time on App", 
                   "Time on website",
                   "Length of Membership",
                   "Yearly spent"),
        main = "Pairplot of variables")

  
  # ----------------------------------------------------------
  # EXPLORE THE SELECTED VARIABLES
  # ----------------------------------------------------------

  # Check if the variable is normally distributed
  
  # hist(data$Length.of.Membership)
 
  # Hence, the histogram is continous  
  # with ggplot
  ggplot(data, aes(x=Length.of.Membership)) +
    geom_histogram(
      color="white",
      fill ="orange",
      binwidth=0.5
  )

  # check distribution with boxplot 
  
  # boxplot(data$Length.of.Membership)

  # with ggplot 
  ggplot(data,aes(x=Length.of.Membership)) +
    geom_boxplot(
      fill = "orange"
    )
  
  
  # ---------------------------------------------------------------------------
  # FITTING A LINEAR MODEL
  # ---------------------------------------------------------------------------
  
  attach(data)
  lm.fit1 <- lm(Yearly.Amount.Spent~Length.of.Membership)
   
  summary(lm.fit1)
 
  # --> p value is below significance level, so the variable Length of 
  #     membership is significant.
  # --> beta_1(slope) is 64.219, which means that an increase in the variable value
  #     causes an increase in the target variable.
  
  plot(Yearly.Amount.Spent~Length.of.Membership)
  abline(lm.fit1, col="red")
  
  
  # ---------------------------------------------------------------------------
  # RESIDUALS ANALYSIS (check the data is distributed normally?)
  # ---------------------------------------------------------------------------
  
  # hist(residuals(lm.fit1)) also can check directly 
  # by observing if the data is normally distributed
  
  # 1) using plots(qqplot)
  
  qqnorm(residuals(lm.fit1))
  qqline(residuals(lm.fit1),col="red")
  
  # 2)using Shapiro-Wilk Test  
  
  shapiro.test(residuals(lm.fit1))
  
  # If p ≤ 0.05, we reject H0 
  # and conclude that the data is not normal.
  # If p > 0.05, we fail to reject 𝐻0 
  # and conclude that the data is likely normal.
  
  
  # ---------------------------------------------------------------------------
  # EVALUATE THE QUALITY OF THE MODEL
  # ---------------------------------------------------------------------------
  
  # create a random training and a testing set
  
  set.seed(1)
  row.number <- sample(1:nrow(data), 0.8*nrow(data))
  
  train <- data[row.number,]
  test <- data[-row.number,]
  
  # estimate the linear fit with training set (lm.fit0.8 - as we trained on 80% of data)
  
  lm.fit0.8 <- lm(Yearly.Amount.Spent~Length.of.Membership, data=train)
  summary(lm.fit0.8)
  
  # predict on testing set
  prediction0.2 <- predict(lm.fit0.8, newdata = test)
  
  # visualize the predictions against actual values.
  df_compare <- data.frame(
    Predicted = prediction0.2,
    Actual = test$Yearly.Amount.Spent
  )
  
  ggplot(df_compare, aes(x = Predicted, y = Actual)) +
    geom_point(color = "blue") +
    geom_abline(intercept = 0, slope = 1, color = "red", linetype = "dashed") +
    labs(title = "Predicted vs Actual",
         x = "Predicted",
         y = "Actual") +
    theme_minimal()
  
  # ---------------------------------------------------------------------------
  # Model Evaluation (Error Metrics)
  # ---------------------------------------------------------------------------
  err0.2 <- prediction0.2 - test$Yearly.Amount.Spent
  
  rmse <- sqrt(mean(err0.2^2))
  mape <- mean(abs(err0.2/test$Yearly.Amount.Spent))
  
  c(RMSE = rmse, MAPE = mape, R2=summary(lm.fit0.8)$r.squared)
  
  
  # Calculating the error percentage
  rmse/mean(test$Yearly.Amount.Spent) -> errorPercentage
  errorPercentage
  
  # Calculating the accuracy of the model
  (100 - errorPercentage)
  
  
  
  
  
  
  
  