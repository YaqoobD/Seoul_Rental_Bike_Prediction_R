set.seed(8234)

library(randomForest)
library(modelr)
library(caret)
#library(ggstatsplot)
library(corrplot)
library(mice)
library(miceadds)

setwd("~/mahbub-dev/beuth_hochschule_for_technik_berlin/data_science/machine_learning_2/project-2")
df_bike <- read.csv("SeoulBikeData.csv")

numeric_cols <- c("Hour", "Temperature.C.", "Humidity...", "Wind.speed..m.s.", "Visibility..10m.", "Dew.point.temperature.C.", "Solar.Radiation..MJ.m2.", "Rainfall.mm.", "Snowfall..cm.", "Rented.Bike.Count")
df_scaled_bike <- scale(df_bike[numeric_cols])

# outlier detection ###########
boxplot(df_scaled_bike)

outliers_wind.speed <- boxplot.stats(df_scaled_bike[, 4])$out
count.outliers_wind.speed <- length(outliers_wind.speed)

outliers_solar.radiation <- boxplot.stats(df_scaled_bike[, 7])$out
count.outliers_solar.radiation <- length(outliers_solar.radiation)

outliers_rainfall <- boxplot.stats(df_scaled_bike[, 8])$out
count.outliers_rainfall <- length(outliers_rainfall)

outliers_snowfall <- boxplot.stats(df_scaled_bike[, 9])$out
count.outliers_snowfall <- length(outliers_snowfall)

outliers_rented.bike.count <- boxplot.stats(df_scaled_bike[, 10])$out
count.outliers_rented.bike.count <- length(outliers_rented.bike.count)
###############################################################################

# outlier removal ###########
df_scaled_bike <- data.frame(df_scaled_bike)
df_scaled_bike <- subset(df_scaled_bike, !Solar.Radiation..MJ.m2. %in% outliers_solar.radiation)
df_scaled_bike <- subset(df_scaled_bike, !Rainfall.mm. %in% outliers_rainfall)
df_scaled_bike <- subset(df_scaled_bike, !Snowfall..cm. %in% outliers_snowfall)
df_scaled_bike <- subset(df_scaled_bike, !Wind.speed..m.s. %in% outliers_wind.speed)
df_scaled_bike <- subset(df_scaled_bike, !Rented.Bike.Count %in% outliers_rented.bike.count)
#############################################################################################

# correlation detection #######################
cor.df_bike <- cor(df_bike[numeric_cols])
corrplot(cor.df_bike)
##############################################

# missing value detection
md.pattern(df_bike[numeric_cols])
######################################

# model creation ##############################
explanatory_cols <- c("Hour", "Temperature.C.", "Humidity...", "Wind.speed..m.s.", "Visibility..10m.", "Dew.point.temperature.C.", "Solar.Radiation..MJ.m2.", "Rainfall.mm.", "Snowfall..cm.")
outcome_col <- "Rented.Bike.Count"

# baseline ####################################
df_sample <- sample(df_bike)
df_train <- df_sample[1:7008, ]
df_test <- df_sample[7009:8760, ]

X_train <- df_train[explanatory_cols]
X_test <- df_test[explanatory_cols]

y_train <- df_train[outcome_col]
y_test <- df_test[outcome_col]

#formula Rented.Bike.Count ~ Hour + Temperature.C. + Humidity... + Wind.speed..m.s. + Visibility..10m. + Dew.point.temperature.C. + Solar.Radiation..MJ.m2. + Rainfall.mm. + Snowfall..cm.
#model.1 <- randomForest(X_train, y=y_train, xtest=X_test, ytest=y_test)
model.1 <- randomForest(Rented.Bike.Count ~ Hour + Temperature.C. + Humidity... + Wind.speed..m.s. + Visibility..10m. + Dew.point.temperature.C. + Solar.Radiation..MJ.m2. + Rainfall.mm. + Snowfall..cm., data = df_train)
summary(model.1)
train.metrics <- data.frame(
                  R2 = rsquare(model.1, data = df_train),
                  MAE = mae(model.1, data = df_train),
                  MSE = mse(model.1, data = df_train),
                  RMSE = rmse(model.1, data = df_train)
                )
train.metrics

y_predict <- predict(model.1, newdata = X_test)
test.metrics <- data.frame(
                  R2 = R2(y_predict, y_test$Rented.Bike.Count),
                  MAE = MAE(y_predict, y_test$Rented.Bike.Count),
                  MSE = mean((y_test$Rented.Bike.Count - y_predict)^2),
                  RMSE = RMSE(y_predict, y_test$Rented.Bike.Count)
                )
test.metrics
#################################################################

# second version using scaled or normalized dataset without outliers ############################
df_sample <- sample(df_scaled_bike)
df_train <- df_sample[1:5538, ]
df_test <- df_sample[5539:6923, ]

X_train <- df_train[explanatory_cols]
X_test <- df_test[explanatory_cols]

y_train <- df_train[outcome_col]
y_test <- df_test[outcome_col]

model.2 <- randomForest(Rented.Bike.Count ~ Hour + Temperature.C. + Humidity... + Wind.speed..m.s. + Visibility..10m. + Dew.point.temperature.C. + Solar.Radiation..MJ.m2. + Rainfall.mm. + Snowfall..cm., data = df_train)
summary(model.2)
train.metrics <- data.frame(
  R2 = rsquare(model.2, data = df_train),
  MAE = mae(model.2, data = df_train),
  MSE = mse(model.2, data = df_train),
  RMSE = rmse(model.2, data = df_train)
)
train.metrics

y_predict <- predict(model.2, newdata = X_test)
test.metrics <- data.frame(
  R2 = R2(y_predict, y_test$Rented.Bike.Count),
  MAE = MAE(y_predict, y_test$Rented.Bike.Count),
  MSE = mean((y_test$Rented.Bike.Count - y_predict)^2),
  RMSE = RMSE(y_predict, y_test$Rented.Bike.Count)
)
test.metrics
#####################################################################
###################################################################################

# model comparison #################
#anova(model.1)
######################################################

