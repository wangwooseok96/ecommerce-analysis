import pandas as pd

# Load raw data
df = pd.read_excel("Online Retail.xlsx")

# Clean records for sales analysis
clean = df[
    (df["Quantity"] > 0)
    & (df["UnitPrice"] > 0)
    & (~df["InvoiceNo"].astype(str).str.startswith("C"))
    & (df["Description"].notna())
].copy()

# Create revenue field
clean["Revenue"] = clean["Quantity"] * clean["UnitPrice"]

# Display basic results
print("Original rows:", len(df))
print("Clean sales rows:", len(clean))
print("Rows removed:", len(df) - len(clean))
print("CustomerID missing in clean data:", clean["CustomerID"].isna().sum())

# Save cleaned data
clean.to_csv("online_retail_clean.csv", index=False)