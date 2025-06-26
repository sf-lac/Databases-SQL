#  🗄️ SQL Reference Repository

This repository contains SQL scripts categorized by database platform and functionality. It serves as a reference for working with various types of SQL features across **MySQL**, **PostgreSQL**, **Snowflake**, and **Oracle**.

## 📁 Directory Structure

<pre>
/
├── mysql/
│ ├── window_functions/
│ └── functions/
├── postgresql/
│ ├── ctes/
│ ├── window_functions/
│ ├── distinct_on/
│ └── correlated_subqueries/
├── snowflake/
│ └── qualify/
├── oracle/
│ ├── ddl/
│ └── stored_procedures/
</pre>

Each subfolder includes sample scripts demonstrating the platform's syntax and capabilities for the listed SQL features.

**Note:**  
For PostgreSQL and MySQL, DDL and DML statements are included in the sample scripts under each subfolder. 

## 🧰 Contents

- **DDL (Data Definition Language)**  
  Scripts to create, alter, and drop tables, schemas, and indexes.

- **DML (Data Manipulation Language)**  
  Scripts/statements for inserting, updating, deleting data.

- **CTEs (Common Table Expressions)**  
  Modular, readable queries using `WITH` clauses.

- **Window Functions**  
  Advanced analytics using `OVER` clauses (e.g. ranking, running totals, time series).

- **DISTINCT ON** *(PostgreSQL only)*  
  A PostgreSQL-specific extension to return the first row of each set of duplicates.

- **QUALIFY Clause** *(Snowflake only)*  
  Filters results after window functions, similar to a `HAVING` clause for analytic functions.

- **Correlated Subqueries** *(PostgreSQL)*  
  Subqueries that reference columns from the outer query, often used for filtering or comparison.

- **Functions**  
  User-defined SQL functions for modular, reusable logic.

- **Stored Procedures**  
  Encapsulated operations written using the platform’s procedural SQL.


