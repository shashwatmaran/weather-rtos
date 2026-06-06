-- Quick smoke check for the continuous aggregate
SELECT bucket, continent, country, region, city, sample_count
FROM weather_city_minute_cagg
ORDER BY bucket DESC
LIMIT 25;
