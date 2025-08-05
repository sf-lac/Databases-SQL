# 📖 SQL Window Functions

A quick reference guide to the most common SQL window functions — Ranking, Value, Aggregate, and Navigation —, their behaviour, use cases, and key characteristics across major databases (PostgreSQL, MySQL 8+, Oracle, Snowflake, etc.).

Window functions perform calculations across a subset of rows related to the current row based on defined ordering within specified partition(s).

---

## 🔝 1. Ranking Functions

| Function        | Description                                 | Ties Handling       | Gaps in Ranking | Use Case                             |
|-----------------|---------------------------------------------|----------------------|------------------|----------------------------------------|
| `ROW_NUMBER()`   | Assigns unique sequential number per row   | No ties              | No               | Top-N per group, pagination            |
| `RANK()`         | Assigns same rank to ties                  | Ties get same rank   | Yes              | Ranking    |
| `DENSE_RANK()`   | Like `RANK()`, but no gaps after ties      | Ties get same rank   | No               | Dense ranking                          |
| `NTILE(n)`       | Divides rows into `n` buckets              | Even distribution    | N/A              | Quartiles, deciles                     |

---

## 🔍 2. Value Functions

| Function         | Description                                             | Frame-Sensitive | Use Case                                |
|------------------|---------------------------------------------------------|------------------|-------------------------------------------|
| `FIRST_VALUE()`   | Returns the first value in the window frame            | ✅ Yes           | Snapshot of earliest row                  |
| `LAST_VALUE()`    | Returns the last value in the window frame             | ✅ Yes           | Snapshot of latest row                    |
| `NTH_VALUE(expr, n)` | Returns the n-th value in the frame                | ✅ Yes           | Peek at specific position in frame        |

> ⚠️ **Note:** Value functions depend on the window (ROWS or RANGE) frame specification. Default may not always include the entire partition/last row.

---

## 🧮 3. Aggregate Window Functions

| Function         | Description                                   | Use Case                               |
|------------------|-----------------------------------------------|------------------------------------------|
| `SUM()`           | Running total                                 | Cumulative sales, rolling totals         |
| `AVG()`           | Running average                               | Trend analysis                           |
| `MIN()` / `MAX()` | Running min/max                               | Time series extremes                     |
| `COUNT()`         | Cumulative count                              | Running event counts                     |

These functions behave like their GROUP BY counterparts but preserve individual row context.

---

## ⏪ 4. Navigation Functions

| Function     | Description                                     | Use Case                                 |
|--------------|-------------------------------------------------|-------------------------------------------|
| `LAG(expr, n)` | Value from `n` rows **before** current row   | Compare with prior record                 |
| `LEAD(expr, n)`| Value from `n` rows **after** current row    | Compare with upcoming record              |

Default for n is 1. A default value can be added if the row is out of bounds:

```sql
-- Example with default fallback value
-- LAG(column, offset, default) OVER (ORDER BY ...)
LAG(salary, 1, 0) OVER (ORDER BY hire_date)
```
## 🧰 OVER Clause Components

All window functions require an OVER (...) clause. It is customized with:

- PARTITION BY – Group rows (like GROUP BY but without collapsing rows). PARTITION BY clause can be omitted when the window function needs to operate on the complete set of rows returned by a SQL query (after any WHERE clauses) and are simply interested in the ordering of those results. The window function will treat the entire result set as a single partition and will perform its calculation across all the rows in the query's result, as if they all belonged to one large group.

- ORDER BY – Define order within each partition; specifies how the rows in each partition should be processed by the window function.

- Frame clauses:

	In window functions, ROWS BETWEEN and RANGE BETWEEN frames define how a window of rows is selected for calculations. ROWS is based on row number, while RANGE is based on the value of the ORDER BY column. ROWS is more precise when dealing with physical positions, while RANGE is more flexible when dealing with logical relationships. When there are duplicate values in the ORDER BY column, ROWS will include only the specified number of rows, while RANGE might include more rows based on the value range.
	
	- ROWS BETWEEN specifies a fixed number of rows before and after the current row, regardless of their values. 
		- ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
		- Defines the window frame based on the physical position of rows relative to the current row. 
		- Uses PRECEDING and FOLLOWING clauses to specify a fixed number of rows before and after the current row. 
		- Example: ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING includes the current row, the previous row, and the next row. 
		- Useful when performing calculations based on a specific number of preceding and following rows, regardless of their values, like calculating moving averages or running totals; precise row-level control, counting specific positions regardless of duplicate values, predictable results based on physical row positions. 

	
	- RANGE BETWEEN specifies a range of values, including rows with similar values in the ORDER BY column, potentially including more rows than a ROWS frame with the same offset. 
		- RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
		- Defines the window frame based on the logical relationship of values in the ORDER BY column. 
		- Uses PRECEDING and FOLLOWING clauses to specify a range of values relative to the current row's value. 
		- Example: RANGE BETWEEN 1 PRECEDING AND 1 FOLLOWING includes all rows where the ORDER BY column's value is within 1 of the current row's value. 
		- Useful when performing calculations based on grouped values, especially when dealing with duplicate values in the ORDER BY column, when the order of rows within a group matters, or want to perform calculations based on ranges of values. 


## ✅ Summary Table

| Function Category | Examples                                       | Used for                          |
| ----------------- | ---------------------------------------------- | --------------------------------- |
| Ranking           | `ROW_NUMBER()`, `RANK()`, `DENSE_RANK()`       | Row ranking, top-N, deduplication |
| Value             | `FIRST_VALUE()`, `LAST_VALUE()`, `NTH_VALUE()` | Snapshot values from a partition  |
| Aggregate         | `SUM()`, `AVG()`, `COUNT()`                    | Running totals, moving averages   |
| Navigation        | `LAG()`, `LEAD()`                              | Compare with past/future rows     |

