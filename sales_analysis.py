import pandas as pd

# Load cleaned data
df = pd.read_csv("online_retail_clean.csv", dtype={"InvoiceNo": str})

# Convert date column
df["InvoiceDate"] = pd.to_datetime(df["InvoiceDate"])

# Create monthly revenue
df["Month"] = df["InvoiceDate"].dt.to_period("M")

monthly_revenue = (
    df.groupby("Month")["Revenue"]
    .sum()
    .reset_index()
)

print(monthly_revenue)

import matplotlib.pyplot as plt

monthly_revenue["Month"] = monthly_revenue["Month"].astype(str)

plt.figure(figsize=(10, 5))
plt.plot(
    monthly_revenue["Month"],
    monthly_revenue["Revenue"],
    marker="o"
)

plt.title("Monthly Revenue Trend")
plt.xlabel("Month")
plt.ylabel("Revenue (£)")
plt.xticks(rotation=45)
plt.tight_layout()

plt.savefig("monthly_revenue.png", dpi=300, bbox_inches="tight")
plt.show()

country_revenue = (
    df.groupby("Country")["Revenue"]
    .sum()
    .sort_values(ascending=False)
    .head(10)
    .reset_index()
)

print(country_revenue)

plt.figure(figsize=(10, 6))

plt.barh(
    country_revenue["Country"][::-1],
    country_revenue["Revenue"][::-1]
)

plt.title("Top 10 Countries by Revenue")
plt.xlabel("Revenue (£)")
plt.ylabel("Country")
plt.tight_layout()

plt.savefig("top_countries_revenue.png", dpi=300, bbox_inches="tight")
plt.show()

country_orders = (
    df.groupby("Country")["InvoiceNo"]
    .nunique()
    .sort_values(ascending=False)
    .head(10)
    .reset_index(name="Orders")
)

print(country_orders)

country_summary = (
    df.groupby("Country")
    .agg(
        Revenue=("Revenue", "sum"),
        Orders=("InvoiceNo", "nunique")
    )
    .reset_index()
)

country_summary["AOV"] = (
    country_summary["Revenue"] / country_summary["Orders"]
)

country_summary = (
    country_summary
    .sort_values("Revenue", ascending=False)
    .head(10)
)

print(country_summary)