import sqlite3
import pandas as pd

# Connect to SQLite database
conn = sqlite3.connect("ecommerce.db")

# Read SQL query from file
with open("analysis.sql", "r", encoding="utf-8") as file:
    query = file.read()

# Run query
result = pd.read_sql_query(query, conn)

print(result)

conn.close()