import sqlite3
import pandas as pd

# Connect to SQLite database
conn = sqlite3.connect("ecommerce.db")

# Read SQL queries from file
with open("analysis.sql", "r", encoding="utf-8") as file:
    sql_script = file.read()

# Split multiple SQL statements
queries = [
    query.strip()
    for query in sql_script.split(";")
    if query.strip()
]

# Run each query
for i, query in enumerate(queries, start=1):
    print(f"\n--- Query {i} ---")
    result = pd.read_sql_query(query, conn)
    print(result)

conn.close()