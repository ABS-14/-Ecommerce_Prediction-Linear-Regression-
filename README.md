---

# StyleSync: Predictive Analytics for Fashion Retail

This repository contains an analysis and predictive modeling project for an online clothing store that offers in-store styling and clothing advice sessions. The goal is to determine whether the company should focus more on its **mobile app experience** or **website** based on customer purchasing behavior.  

## Table of Contents  

- [Project Overview](#project-overview)  
- [Dataset Description](#dataset-description)  
- [Methodology](#methodology)  
- [Modeling](#modeling)  
- [Usage](#usage)  
- [Results](#results)  
- [Contributing](#contributing)  
 

## Project Overview  

The clothing store collects customer data based on their **in-store styling sessions** and subsequent **purchases made via the mobile app or website**. The aim of this project is to analyze this data and use **linear regression models (built in Python and R)** to determine which sales channel contributes more to revenue.  

## Dataset Description  

The dataset includes:  
- **Customer Demographics:** Age, gender, income, etc.  
- **Session Details:** Appointment time, duration, stylist interaction.  
- **Purchase Information:** Purchase channel (mobile app vs. website), order value, items purchased.  


## Methodology  

1. **Data Exploration & Cleaning:**  
   - Checked for missing values and handled them appropriately.  
   - Performed feature engineering to create relevant variables.  

2. **Feature Transformation:**  
   - Applied encoding techniques for categorical variables.  
   - Normalized numerical features to ensure better model performance.  

3. **Predictive Modeling:**  
   - Used **Linear Regression from `sklearn.linear_model`** in Python.  
   - Used **lm() function from `stats` package** in R.  
   - Evaluated model performance using key regression metrics.  

4. **Model Evaluation (Python):**  
   - `R² Score`: Measures model accuracy.  
   - `Mean Absolute Error (MAE)`: Measures average absolute error.  
   - `Mean Squared Error (MSE)`: Penalizes larger errors more than MAE.  
   - `Root Mean Squared Error (RMSE)`: Measures average prediction error.  

## Modeling  

### **Python Implementation**  
The Python model uses **scikit-learn's Linear Regression** and evaluation metrics from `sklearn.metrics`.  

```python
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_absolute_error, mean_squared_error, r2_score

# Initializing model
model = LinearRegression()

# Training
model.fit(X_train, y_train)

# Predictions
y_pred = model.predict(X_test)

# Evaluation
r2 = r2_score(y_test, y_pred)
mae = mean_absolute_error(y_test, y_pred)
mse = mean_squared_error(y_test, y_pred)
rmse = mse ** 0.5

print(f"R² Score: {r2}")
print(f"MAE: {mae}, MSE: {mse}, RMSE: {rmse}")
```

### **R Implementation**  
The R model follows a similar approach using `lm()`.  

```r
# Load dataset
data <- read.csv("data/ecommerce.csv")

# Train linear model
model <- lm(Purchase_Amount ~ Mobile_App_Usage + Website_Usage, data=data)

# Model summary
summary(model)
```

## Usage  

1. **Clone the repository:**  
   ```bash
   git clone https://github.com/ABS-14/-Ecommerce_Prediction-Linear-Regression-.git
   cd -Ecommerce_Prediction-Linear-Regression-
   ```  

2. **Prepare the dataset:**   
   - Open the **Python Notebook (`analysis_python.ipynb`)** or **R script (`analysis_R.R`)** to explore the data.  

3. **Run the Models:**  
   - **Python:**  
     ```bash
     jupyter notebook analysis_python.ipynb
     ```
   - **R:**  
     Open `analysis_R.R` in RStudio and run the script.  

4. **Analyze Results:**  
   - Visualizations and performance metrics are included in both scripts.  

## Results  

- [Summarize findings here. Example:]  
  - **Mobile App contributed more to revenue than the website**, indicating that investing in app improvements may yield higher returns.  
  - The Python and R models showed similar results, with **R² values indicating a good fit** for predicting customer behavior.  

## Contributing  

- Fork this repo and submit a pull request for improvements or feature additions.  
- Open an issue for any bugs or feature requests.  

---
