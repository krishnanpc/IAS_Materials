-- create a schema in the database
CREATE SCHEMA "bigData";

-- set the desired schema
SET SCHEMA 'bigData';


-- create the table Article
CREATE TABLE "bigData".Article (
	articleId SERIAL PRIMARY KEY,
	title varchar(100),
	articleText text
);

-- create the view. Question 2.1
CREATE VIEW articleView AS

	SELECT
	a.title AS article,
	word, count(*)
FROM article AS a
CROSS JOIN regexp_split_to_table(a.articleText, E'\\W+') AS word
GROUP BY a.title, word;


