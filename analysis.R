# ========================
# E-commerce Purchase Behavior Analysis (R)
# ========================

# ------------------------
# 1. Data Generation
# ------------------------
set.seed(123)

df <- data.frame(
  user_id = sample(1001:1100, 500, replace = TRUE),
  order_id = 1:500,
  purchase_amount = round(runif(500, 10, 500), 2),
  category = sample(c("Electronics", "Clothing", "Home", "Beauty"), 500, replace = TRUE),
  purchase_date = sample(
    seq(as.Date("2024-01-01"), as.Date("2024-03-31"), by = "day"),
    500,
    replace = TRUE
  )
)

# Quick checks
head(df)
summary(df)
table(df$category)

# ------------------------
# 2. Revenue by Category
# ------------------------
library(ggplot2)

revenue <- tapply(df$purchase_amount, df$category, sum)

revenue_df <- data.frame(
  category = names(revenue),
  revenue = as.numeric(revenue)
)

ggplot(revenue_df, aes(x = category, y = revenue, fill = category)) +
  geom_bar(stat = "identity") +
  labs(
    title = "Revenue by Product Category",
    subtitle = "Simulated E-commerce Data Analysis",
    x = "Category",
    y = "Total Revenue ($)"
  ) +
  theme_minimal() +
  theme(
    legend.position = "none",
    plot.title = element_text(size = 16, face = "bold"),
    plot.subtitle = element_text(size = 12)
  )

max_category <- revenue_df[which.max(revenue_df$revenue), ]
max_category

# ------------------------
# 3. Daily Revenue Trend
# ------------------------
daily_revenue <- aggregate(purchase_amount ~ purchase_date, data = df, sum)
head(daily_revenue)

ggplot(daily_revenue, aes(x = purchase_date, y = purchase_amount)) +
  geom_line(color = "blue") +
  labs(
    title = "Daily Revenue Trend",
    x = "Date",
    y = "Revenue ($)"
  ) +
  theme_minimal()

peak_day <- daily_revenue[which.max(daily_revenue$purchase_amount), ]
peak_day

# ------------------------
# 4. User Revenue Analysis
# ------------------------
user_revenue <- aggregate(purchase_amount ~ user_id, data = df, sum)
head(user_revenue)

top_user <- user_revenue[which.max(user_revenue$purchase_amount), ]
top_user

user_revenue_sorted <- user_revenue[order(-user_revenue$purchase_amount), ]
top10 <- head(user_revenue_sorted, 10)
top10

top10_share <- sum(top10$purchase_amount) / sum(user_revenue$purchase_amount)
top10_share

# ------------------------
# 5. Customer Segmentation
# ------------------------
user_revenue$segment <- ifelse(
  user_revenue$purchase_amount > 2000, "High Value",
  ifelse(user_revenue$purchase_amount > 1000, "Medium Value", "Low Value")
)

head(user_revenue)
table(user_revenue$segment)

# ------------------------
# 6. Feature Engineering
# ------------------------
df$month <- format(df$purchase_date, "%m")
df$day <- format(df$purchase_date, "%d")

head(df)

df$month <- as.numeric(df$month)
df$day <- as.numeric(df$day)
df$category <- as.factor(df$category)

str(df)

# ------------------------
# 7. Initial Linear Model
# ------------------------
model <- lm(purchase_amount ~ category + month + day, data = df)
summary(model)

# ------------------------
# 8. Structured Purchase Amount for Better Modeling
# ------------------------
df$purchase_amount <- round(
  ifelse(df$category == "Electronics", runif(500, 200, 500),
  ifelse(df$category == "Home", runif(500, 150, 400),
  ifelse(df$category == "Clothing", runif(500, 100, 300),
         runif(500, 50, 200)))),
  2
)

model <- lm(purchase_amount ~ category + month + day, data = df)
summary(model)

# ------------------------
# 9. Boxplot by Category
# ------------------------
ggplot(df, aes(x = category, y = purchase_amount, fill = category)) +
  geom_boxplot() +
  labs(
    title = "Purchase Distribution by Category",
    x = "Category",
    y = "Purchase Amount ($)"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

# ------------------------
# 10. Monthly Revenue Trend by Category
# ------------------------
monthly_revenue <- aggregate(purchase_amount ~ month + category, data = df, sum)

ggplot(monthly_revenue, aes(x = month, y = purchase_amount, color = category)) +
  geom_line(linewidth = 1) +
  geom_point() +
  labs(
    title = "Monthly Revenue Trend by Category",
    x = "Month",
    y = "Revenue ($)"
  ) +
  theme_minimal()