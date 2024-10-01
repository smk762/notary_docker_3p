source .env
SQL="SELECT t1.* FROM stats_nodes t1 INNER JOIN (SELECT name, MAX(timestamp) AS max_timestamp FROM stats_nodes GROUP BY name) t2 ON t1.name = t2.name AND t1.timestamp = t2.max_timestamp ORDER BY t1.name;"
while true; do date && sqlite3 "$MM2_DB" "$SQL"; sleep 30; done
