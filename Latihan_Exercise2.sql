USE share;

SHOW TABLES;

SELECT * FROM follows;
SELECT * FROM comments;
SELECT * FROM likes;
SELECT * FROM photo_tags;
SELECT * FROM photos;
SELECT * FROM tags;
SELECT * FROM users;

-- User yang belum pernah post foto
SELECT id, username
FROM users
WHERE id NOT IN (SELECT DISTINCT user_id FROM photos);

-- Hari apa sebagian besar pengguna mendaftar ke aplikasi
SELECT DAYNAME(created_at) AS hari, COUNT(id) AS total
FROM users
GROUP BY hari
ORDER BY total DESC;

-- 5 pengguna awal
SELECT username, created_at
FROM users
ORDER BY created_at
LIMIT 5;

-- User dengan like terbanyak
SELECT user_id, username, COUNT(photo_id) AS total
FROM likes l
LEFT JOIN users u ON l.user_id = u.id
GROUP BY user_id
ORDER BY total DESC;

-- Tag terbanyak
SELECT tag_id, tag_name, COUNT(tag_id) AS total
FROM photo_tags pt
LEFT JOIN tags t ON pt.tag_id = t.id
GROUP BY tag_id
ORDER BY total DESC;

-- Jumlah foto diposting tiap user
SELECT user_id, username, COUNT(image_url) AS total
FROM photos p LEFT JOIN users u ON p.user_id = u.id
GROUP BY user_id
ORDER BY total DESC;

-- User yang upload foto
SELECT *
FROM users
WHERE id IN (SELECT DISTINCT user_id FROM photos);

-- User yang menyukai setiap foto
SELECT user_id, COUNT(photo_id) AS total_like
FROM likes
GROUP BY user_id
HAVING total_like = (SELECT COUNT(*) FROM photos);

-- User yang pernah membuat komentar
SELECT DISTINCT user_id, username
FROM comments c
LEFT JOIN users u ON c.user_id = u.id;

-- Jumlah user yang belum pernah memberi komentar
SELECT COUNT(id)
FROM users
WHERE id NOT IN (SELECT DISTINCT user_id FROM comments);