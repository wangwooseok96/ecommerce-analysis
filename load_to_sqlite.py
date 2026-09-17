import pandas as pd
import sqlite3

# Load cleaned data
df = pd.read_csv(
    "online_retail_clean.csv",
    dtype={"InvoiceNo": str}
)

# Create SQLite database
conn = sqlite3.connect("ecommerce.db")

# Load data into a SQL table
df.to_sql(
    "transactions",
    conn,
    if_exists="replace",
    index=False
)

conn.close()

print("Database created successfully.")