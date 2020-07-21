SHOW databases;

USE albums_db;

DESCRIBE albums;

SELECT name
FROM albums
WHERE artist = "Pink Floyd";

SELECT release_date
FROM albums
WHERE name LIKE 'Sgt. Pepper%';

SELECT genre
FROM albums
WHERE name = 'Nevermind';

SELECT name
FROM albums
WHERE release_date BETWEEN '1990-01-01' AND '1999-12-31';

SELECT name
FROM albums
WHERE sales < 20;

SELECT name
FROM albums
WHERE genre = 'Rock';

-- This query will only return any album that is specifically categorized as 'Rock', since the query used the equal sign which means 'exactly equal to Rock'
-- However, if I used the "LIKE" operator, in this way: LIKE '%ROCK%', it would pick up any album with the word rock in any part of the genre catego›