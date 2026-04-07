# E-commerce Purchase Behavior Analysis

## Overview
This project analyzes simulated e-commerce transaction data to explore customer behavior, revenue distribution, and key drivers of purchase amount.

## Dataset
The dataset is synthetically generated to simulate real-world e-commerce transactions, including:

- User ID
- Order ID
- Purchase Amount
- Product Category
- Purchase Date

## Key Analysis

### 1. Revenue Analysis
- Compared total revenue across product categories
- Identified top-performing category

### 2. Time Series Analysis
- Analyzed daily revenue trends
- Identified peak revenue day

### 3. Customer Analysis
- Calculated total spending per user
- Identified top customers
- Computed top 10 users’ revenue contribution

### 4. Customer Segmentation
- Segmented users into:
  - High Value
  - Medium Value
  - Low Value

### 5. Statistical Modeling
- Built a linear regression model:
  
  purchase_amount ~ category + month + day

### Key Findings

- Electronics category generates the highest revenue
- Product category is the strongest predictor of purchase amount
- Time variables (month/day) have limited impact
- Top users contribute a significant portion of total revenue

## Tools Used

- R
- ggplot2
- Data aggregation techniques
- Linear regression modeling

## Project Purpose

This project demonstrates end-to-end data analysis skills, including:

- Data generation
- Data cleaning
- Visualization
- Business insights
- Predictive modeling
