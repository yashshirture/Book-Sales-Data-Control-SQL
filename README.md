# 📚 Book Sales Data Control (SQL)

## 🧩 Problem  
Book sales data was spread across multiple tables with inconsistent keys, missing values, and mismatched records.  
Directly querying this data risked inflated revenue, broken joins, and misleading business metrics.

## 🎯 Objective  
Design a reliable SQL-based data layer that produces accurate, business-ready sales metrics while preventing silent calculation errors.

## 🚨 Data Issues Identified  
- One-to-many joins inflating totals  
- Missing prices and quantities  
- Orphan records across tables  
- Inconsistent book and author IDs  
- Revenue totals not matching expectations  

## 🛠️ Approach  
1. Profiled each table to understand shape and quality  
2. Tested joins to detect row multiplication  
3. Standardized keys and filtering logic  
4. Built controlled queries for:  
   - Revenue by book  
   - Revenue by author  
   - Sales by category  
5. Added guard queries to:  
   - Detect nulls in critical fields  
   - Flag unexpected row growth  
   - Validate totals against base tables  

## 🛡️ Validation & Control Logic  
- Pre-join row count checks  
- Post-join inflation detection  
- Null-value guards on price and quantity  
- Reconciliation of revenue across query layers  

Queries are treated as **production assets**, not experiments.

## 📊 Output  
- Reliable sales summaries  
- Author and category performance metrics  
- Business-ready SQL result sets  

## 💡 Why This Matters  
SQL mistakes fail silently—and that’s dangerous.  
This project is built to:

- Assume joins can lie  
- Catch row inflation early  
- Prevent corrupted totals  
- Produce numbers that can be trusted  

The goal is not to “get results.”  
The goal is **correct results**.

## 🧰 Tools Used  
- **SQL** – JOINs, Aggregations, Validation Queries, Reconciliation Logic  

