# Netflix Data analysis using SQL
![Netflix](https://github.com/Vinayaak42/Netflix-Data-analysis-using-SQL-/blob/main/netflix.png)

# Netflix Movies and TV Shows Data Analysis using SQL

## 📌 Overview
This project involves a **comprehensive analysis of Netflix's movies and TV shows data using SQL**.  
The goal is to extract valuable insights and answer various business questions based on the dataset.

---

## 🎯 Objectives
- Analyze the distribution of content types (**Movies vs TV Shows**).
- Identify the most common ratings for movies and TV shows.
- List and analyze content based on **release years, countries, and durations**.
- Explore and categorize content based on **specific criteria and keywords**.

---

## 📂 Dataset
**Source**: [Kaggle - Netflix Movies and TV Shows Dataset](https://www.kaggle.com/shivamb/netflix-shows)  

**Schema:**
```sql
DROP TABLE IF EXISTS netflix;
CREATE TABLE netflix (
    show_id      VARCHAR(5),
    type         VARCHAR(10),
    title        VARCHAR(250),
    director     VARCHAR(550),
    casts        VARCHAR(1050),
    country      VARCHAR(550),
    date_added   VARCHAR(55),
    release_year INT,
    rating       VARCHAR(15),
    duration     VARCHAR(15),
    listed_in    VARCHAR(250),
    description  VARCHAR(550)
);

### 🛠 Business Problems & Solutions
## 1.Count the Number of Movies vs TV Shows

```
sql

SELECT type, COUNT(*) 
FROM netflix 
GROUP BY 1;
```
