# 📖 SQL Window Functions

A quick reference guide to the most common SQL window functions — Ranking, Value, Aggregate, and Navigation —, their behaviour, use cases, and key characteristics across major databases (PostgreSQL, MySQL 8+, Oracle, Snowflake, etc.).

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
LAG(salary, 1, 0) OVER (ORDER BY hire_date)
```
## 🧰 OVER Clause Components

All window functions require an OVER (...) clause. It is customized with:

- PARTITION BY – Group rows (like GROUP BY but without collapsing rows)

- ORDER BY – Define order within each partition

- Frame clauses:

	- ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW

	- RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING

## ✅ Summary Table

| Function Category | Examples                                       | Used for                          |
| ----------------- | ---------------------------------------------- | --------------------------------- |
| Ranking           | `ROW_NUMBER()`, `RANK()`, `DENSE_RANK()`       | Row ranking, top-N, deduplication |
| Value             | `FIRST_VALUE()`, `LAST_VALUE()`, `NTH_VALUE()` | Snapshot values from a partition  |
| Aggregate         | `SUM()`, `AVG()`, `COUNT()`                    | Running totals, moving averages   |
| Navigation        | `LAG()`, `LEAD()`                              | Compare with past/future rows     |

