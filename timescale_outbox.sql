-- batch 1779026026345780296
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026026322641455-0', 'collector:europe', 'Europe', 'Europe', 'europe', 'London', to_timestamp(1779026026322 / 1000.0), to_timestamp(1779026026322650576 / 1000.0), 16.1, 39, 13, '{"created_at":1779026026322650576,"message_id":"collector:europe-1779026026322641455-0","message_type":"weather.packet","payload":{"city":"London","continent":"Europe","country":"Europe","humidity":39.0,"region":"europe","temperature":16.1,"timestamp":1779026026322,"wind_speed":13.0},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779025980000 / 1000.0), 'Europe', 'Europe', 'europe', 'London', 1, 16.1, 16.1, 16.1, 39, 13);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026026346570504
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026026322375879-0', 'collector:north_india', 'Asia', 'India', 'north_india', 'Mumbai', to_timestamp(1779026026322 / 1000.0), to_timestamp(1779026026322383493 / 1000.0), 30.4, 76, 9, '{"created_at":1779026026322383493,"message_id":"collector:north_india-1779026026322375879-0","message_type":"weather.packet","payload":{"city":"Mumbai","continent":"Asia","country":"India","humidity":76.0,"region":"north_india","temperature":30.4,"timestamp":1779026026322,"wind_speed":9.0},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779025980000 / 1000.0), 'Asia', 'India', 'north_india', 'Mumbai', 1, 30.4, 30.4, 30.4, 76, 9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026026347563465
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026026322768773-0', 'collector:south_india', 'Asia', 'India', 'south_india', 'Bangalore', to_timestamp(1779026026322 / 1000.0), to_timestamp(1779026026322777820 / 1000.0), 29.5, 45, 10.7, '{"created_at":1779026026322777820,"message_id":"collector:south_india-1779026026322768773-0","message_type":"weather.packet","payload":{"city":"Bangalore","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":29.5,"timestamp":1779026026322,"wind_speed":10.7},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779025980000 / 1000.0), 'Asia', 'India', 'south_india', 'Bangalore', 1, 29.5, 29.5, 29.5, 45, 10.7);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026026348553702
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026026323585958-0', 'collector:americas', 'Americas', 'USA', 'americas', 'New York', to_timestamp(1779026026322 / 1000.0), to_timestamp(1779026026323594571 / 1000.0), 25.4, 54, 7.9, '{"created_at":1779026026323594571,"message_id":"collector:americas-1779026026323585958-0","message_type":"weather.packet","payload":{"city":"New York","continent":"Americas","country":"USA","humidity":54.0,"region":"americas","temperature":25.4,"timestamp":1779026026322,"wind_speed":7.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779025980000 / 1000.0), 'Americas', 'USA', 'americas', 'New York', 1, 25.4, 25.4, 25.4, 54, 7.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026026349335301
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026026327239935-1', 'collector:europe', 'Europe', 'Europe', 'europe', 'Paris', to_timestamp(1779026026322 / 1000.0), to_timestamp(1779026026327247456 / 1000.0), 14.3, 76, 9.3, '{"created_at":1779026026327247456,"message_id":"collector:europe-1779026026327239935-1","message_type":"weather.packet","payload":{"city":"Paris","continent":"Europe","country":"Europe","humidity":76.0,"region":"europe","temperature":14.3,"timestamp":1779026026322,"wind_speed":9.3},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779025980000 / 1000.0), 'Europe', 'Europe', 'europe', 'Paris', 1, 14.3, 14.3, 14.3, 76, 9.3);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026026350003671
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026026323531503-1', 'collector:north_india', 'Asia', 'India', 'north_india', 'Delhi', to_timestamp(1779026026322 / 1000.0), to_timestamp(1779026026323537780 / 1000.0), 37, 26, 13.6, '{"created_at":1779026026323537780,"message_id":"collector:north_india-1779026026323531503-1","message_type":"weather.packet","payload":{"city":"Delhi","continent":"Asia","country":"India","humidity":26.0,"region":"north_india","temperature":37.0,"timestamp":1779026026322,"wind_speed":13.6},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779025980000 / 1000.0), 'Asia', 'India', 'north_india', 'Delhi', 1, 37, 37, 37, 26, 13.6);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026026350622652
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026026326208663-1', 'collector:americas', 'Americas', 'USA', 'americas', 'Los Angeles', to_timestamp(1779026026323 / 1000.0), to_timestamp(1779026026326215662 / 1000.0), 16.2, 78, 5.9, '{"created_at":1779026026326215662,"message_id":"collector:americas-1779026026326208663-1","message_type":"weather.packet","payload":{"city":"Los Angeles","continent":"Americas","country":"USA","humidity":78.0,"region":"americas","temperature":16.2,"timestamp":1779026026323,"wind_speed":5.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779025980000 / 1000.0), 'Americas', 'USA', 'americas', 'Los Angeles', 1, 16.2, 16.2, 16.2, 78, 5.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026028201115791
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026028197428662-1', 'collector:south_india', 'Asia', 'India', 'south_india', 'Hyderabad', to_timestamp(1779026028127 / 1000.0), to_timestamp(1779026028197493229 / 1000.0), 33.2, 45, 6.2, '{"created_at":1779026028197493229,"message_id":"collector:south_india-1779026028197428662-1","message_type":"weather.packet","payload":{"city":"Hyderabad","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":33.2,"timestamp":1779026028127,"wind_speed":6.2},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779025980000 / 1000.0), 'Asia', 'India', 'south_india', 'Hyderabad', 1, 33.2, 33.2, 33.2, 45, 6.2);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026031569748031
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026031561469118-2', 'collector:north_india', 'Asia', 'India', 'north_india', 'Mumbai', to_timestamp(1779026031561 / 1000.0), to_timestamp(1779026031561476941 / 1000.0), 30.4, 76, 9, '{"created_at":1779026031561476941,"message_id":"collector:north_india-1779026031561469118-2","message_type":"weather.packet","payload":{"city":"Mumbai","continent":"Asia","country":"India","humidity":76.0,"region":"north_india","temperature":30.4,"timestamp":1779026031561,"wind_speed":9.0},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779025980000 / 1000.0), 'Asia', 'India', 'north_india', 'Mumbai', 1, 30.4, 30.4, 30.4, 76, 9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026031570670341
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026031562004101-2', 'collector:americas', 'Americas', 'USA', 'americas', 'New York', to_timestamp(1779026031561 / 1000.0), to_timestamp(1779026031562011513 / 1000.0), 25.4, 54, 7.9, '{"created_at":1779026031562011513,"message_id":"collector:americas-1779026031562004101-2","message_type":"weather.packet","payload":{"city":"New York","continent":"Americas","country":"USA","humidity":54.0,"region":"americas","temperature":25.4,"timestamp":1779026031561,"wind_speed":7.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779025980000 / 1000.0), 'Americas', 'USA', 'americas', 'New York', 1, 25.4, 25.4, 25.4, 54, 7.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026031571716170
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026031561825346-3', 'collector:north_india', 'Asia', 'India', 'north_india', 'Delhi', to_timestamp(1779026031561 / 1000.0), to_timestamp(1779026031561830383 / 1000.0), 37, 26, 13.6, '{"created_at":1779026031561830383,"message_id":"collector:north_india-1779026031561825346-3","message_type":"weather.packet","payload":{"city":"Delhi","continent":"Asia","country":"India","humidity":26.0,"region":"north_india","temperature":37.0,"timestamp":1779026031561,"wind_speed":13.6},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779025980000 / 1000.0), 'Asia', 'India', 'north_india', 'Delhi', 1, 37, 37, 37, 26, 13.6);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026031572714978
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026031562912704-2', 'collector:europe', 'Europe', 'Europe', 'europe', 'Paris', to_timestamp(1779026031561 / 1000.0), to_timestamp(1779026031562920744 / 1000.0), 14.3, 76, 9.3, '{"created_at":1779026031562920744,"message_id":"collector:europe-1779026031562912704-2","message_type":"weather.packet","payload":{"city":"Paris","continent":"Europe","country":"Europe","humidity":76.0,"region":"europe","temperature":14.3,"timestamp":1779026031561,"wind_speed":9.3},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779025980000 / 1000.0), 'Europe', 'Europe', 'europe', 'Paris', 1, 14.3, 14.3, 14.3, 76, 9.3);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026031573619807
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026031562521355-3', 'collector:americas', 'Americas', 'USA', 'americas', 'Los Angeles', to_timestamp(1779026031562 / 1000.0), to_timestamp(1779026031562526773 / 1000.0), 16.2, 78, 5.9, '{"created_at":1779026031562526773,"message_id":"collector:americas-1779026031562521355-3","message_type":"weather.packet","payload":{"city":"Los Angeles","continent":"Americas","country":"USA","humidity":78.0,"region":"americas","temperature":16.2,"timestamp":1779026031562,"wind_speed":5.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779025980000 / 1000.0), 'Americas', 'USA', 'americas', 'Los Angeles', 1, 16.2, 16.2, 16.2, 78, 5.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026031574549038
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026031563373107-3', 'collector:europe', 'Europe', 'Europe', 'europe', 'London', to_timestamp(1779026031561 / 1000.0), to_timestamp(1779026031563378477 / 1000.0), 16.1, 39, 13, '{"created_at":1779026031563378477,"message_id":"collector:europe-1779026031563373107-3","message_type":"weather.packet","payload":{"city":"London","continent":"Europe","country":"Europe","humidity":39.0,"region":"europe","temperature":16.1,"timestamp":1779026031561,"wind_speed":13.0},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779025980000 / 1000.0), 'Europe', 'Europe', 'europe', 'London', 1, 16.1, 16.1, 16.1, 39, 13);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026031624425580
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026031619553625-2', 'collector:south_india', 'Asia', 'India', 'south_india', 'Bangalore', to_timestamp(1779026031561 / 1000.0), to_timestamp(1779026031619559410 / 1000.0), 29.5, 45, 10.7, '{"created_at":1779026031619559410,"message_id":"collector:south_india-1779026031619553625-2","message_type":"weather.packet","payload":{"city":"Bangalore","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":29.5,"timestamp":1779026031561,"wind_speed":10.7},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779025980000 / 1000.0), 'Asia', 'India', 'south_india', 'Bangalore', 1, 29.5, 29.5, 29.5, 45, 10.7);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026033457666068
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026033453333145-3', 'collector:south_india', 'Asia', 'India', 'south_india', 'Hyderabad', to_timestamp(1779026033447 / 1000.0), to_timestamp(1779026033453338252 / 1000.0), 33.2, 45, 6.2, '{"created_at":1779026033453338252,"message_id":"collector:south_india-1779026033453333145-3","message_type":"weather.packet","payload":{"city":"Hyderabad","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":33.2,"timestamp":1779026033447,"wind_speed":6.2},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779025980000 / 1000.0), 'Asia', 'India', 'south_india', 'Hyderabad', 1, 33.2, 33.2, 33.2, 45, 6.2);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026036759937891
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026036753631253-4', 'collector:north_india', 'Asia', 'India', 'north_india', 'Mumbai', to_timestamp(1779026036753 / 1000.0), to_timestamp(1779026036753637513 / 1000.0), 30.4, 76, 9, '{"created_at":1779026036753637513,"message_id":"collector:north_india-1779026036753631253-4","message_type":"weather.packet","payload":{"city":"Mumbai","continent":"Asia","country":"India","humidity":76.0,"region":"north_india","temperature":30.4,"timestamp":1779026036753,"wind_speed":9.0},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779025980000 / 1000.0), 'Asia', 'India', 'north_india', 'Mumbai', 1, 30.4, 30.4, 30.4, 76, 9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026036766419694
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026036761759293-4', 'collector:americas', 'Americas', 'USA', 'americas', 'New York', to_timestamp(1779026036761 / 1000.0), to_timestamp(1779026036761768256 / 1000.0), 25.4, 54, 7.9, '{"created_at":1779026036761768256,"message_id":"collector:americas-1779026036761759293-4","message_type":"weather.packet","payload":{"city":"New York","continent":"Americas","country":"USA","humidity":54.0,"region":"americas","temperature":25.4,"timestamp":1779026036761,"wind_speed":7.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779025980000 / 1000.0), 'Americas', 'USA', 'americas', 'New York', 1, 25.4, 25.4, 25.4, 54, 7.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026036803116381
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026036798984027-4', 'collector:europe', 'Europe', 'Europe', 'europe', 'London', to_timestamp(1779026036798 / 1000.0), to_timestamp(1779026036798987865 / 1000.0), 16.1, 39, 13, '{"created_at":1779026036798987865,"message_id":"collector:europe-1779026036798984027-4","message_type":"weather.packet","payload":{"city":"London","continent":"Europe","country":"Europe","humidity":39.0,"region":"europe","temperature":16.1,"timestamp":1779026036798,"wind_speed":13.0},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779025980000 / 1000.0), 'Europe', 'Europe', 'europe', 'London', 1, 16.1, 16.1, 16.1, 39, 13);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026036830773746
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026036827072053-4', 'collector:south_india', 'Asia', 'India', 'south_india', 'Bangalore', to_timestamp(1779026036759 / 1000.0), to_timestamp(1779026036827077492 / 1000.0), 29.5, 45, 10.7, '{"created_at":1779026036827077492,"message_id":"collector:south_india-1779026036827072053-4","message_type":"weather.packet","payload":{"city":"Bangalore","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":29.5,"timestamp":1779026036759,"wind_speed":10.7},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779025980000 / 1000.0), 'Asia', 'India', 'south_india', 'Bangalore', 1, 29.5, 29.5, 29.5, 45, 10.7);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026036862785775
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026036858710979-5', 'collector:north_india', 'Asia', 'India', 'north_india', 'Delhi', to_timestamp(1779026036760 / 1000.0), to_timestamp(1779026036858716627 / 1000.0), 37, 26, 13.6, '{"created_at":1779026036858716627,"message_id":"collector:north_india-1779026036858710979-5","message_type":"weather.packet","payload":{"city":"Delhi","continent":"Asia","country":"India","humidity":26.0,"region":"north_india","temperature":37.0,"timestamp":1779026036760,"wind_speed":13.6},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779025980000 / 1000.0), 'Asia', 'India', 'north_india', 'Delhi', 1, 37, 37, 37, 26, 13.6);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026036866382114
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026036862692206-5', 'collector:americas', 'Americas', 'USA', 'americas', 'Los Angeles', to_timestamp(1779026036764 / 1000.0), to_timestamp(1779026036862697346 / 1000.0), 16.2, 78, 5.9, '{"created_at":1779026036862697346,"message_id":"collector:americas-1779026036862692206-5","message_type":"weather.packet","payload":{"city":"Los Angeles","continent":"Americas","country":"USA","humidity":78.0,"region":"americas","temperature":16.2,"timestamp":1779026036764,"wind_speed":5.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779025980000 / 1000.0), 'Americas', 'USA', 'americas', 'Los Angeles', 1, 16.2, 16.2, 16.2, 78, 5.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026036904721694
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026036900606034-5', 'collector:europe', 'Europe', 'Europe', 'europe', 'Paris', to_timestamp(1779026036880 / 1000.0), to_timestamp(1779026036900611404 / 1000.0), 14.3, 76, 9.3, '{"created_at":1779026036900611404,"message_id":"collector:europe-1779026036900606034-5","message_type":"weather.packet","payload":{"city":"Paris","continent":"Europe","country":"Europe","humidity":76.0,"region":"europe","temperature":14.3,"timestamp":1779026036880,"wind_speed":9.3},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779025980000 / 1000.0), 'Europe', 'Europe', 'europe', 'Paris', 1, 14.3, 14.3, 14.3, 76, 9.3);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026038768648218
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026038764504767-5', 'collector:south_india', 'Asia', 'India', 'south_india', 'Hyderabad', to_timestamp(1779026038743 / 1000.0), to_timestamp(1779026038764510267 / 1000.0), 33.2, 45, 6.2, '{"created_at":1779026038764510267,"message_id":"collector:south_india-1779026038764504767-5","message_type":"weather.packet","payload":{"city":"Hyderabad","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":33.2,"timestamp":1779026038743,"wind_speed":6.2},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779025980000 / 1000.0), 'Asia', 'India', 'south_india', 'Hyderabad', 1, 33.2, 33.2, 33.2, 45, 6.2);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026041963134673
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026041957264244-6', 'collector:north_india', 'Asia', 'India', 'north_india', 'Mumbai', to_timestamp(1779026041956 / 1000.0), to_timestamp(1779026041957272085 / 1000.0), 30.4, 76, 9, '{"created_at":1779026041957272085,"message_id":"collector:north_india-1779026041957264244-6","message_type":"weather.packet","payload":{"city":"Mumbai","continent":"Asia","country":"India","humidity":76.0,"region":"north_india","temperature":30.4,"timestamp":1779026041956,"wind_speed":9.0},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Asia', 'India', 'north_india', 'Mumbai', 1, 30.4, 30.4, 30.4, 76, 9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026041972058142
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026041967596723-6', 'collector:americas', 'Americas', 'USA', 'americas', 'New York', to_timestamp(1779026041967 / 1000.0), to_timestamp(1779026041967601595 / 1000.0), 25.4, 54, 7.9, '{"created_at":1779026041967601595,"message_id":"collector:americas-1779026041967596723-6","message_type":"weather.packet","payload":{"city":"New York","continent":"Americas","country":"USA","humidity":54.0,"region":"americas","temperature":25.4,"timestamp":1779026041967,"wind_speed":7.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Americas', 'USA', 'americas', 'New York', 1, 25.4, 25.4, 25.4, 54, 7.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026042019255091
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026042015186773-6', 'collector:south_india', 'Asia', 'India', 'south_india', 'Bangalore', to_timestamp(1779026041966 / 1000.0), to_timestamp(1779026042015193071 / 1000.0), 29.5, 45, 10.7, '{"created_at":1779026042015193071,"message_id":"collector:south_india-1779026042015186773-6","message_type":"weather.packet","payload":{"city":"Bangalore","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":29.5,"timestamp":1779026041966,"wind_speed":10.7},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Asia', 'India', 'south_india', 'Bangalore', 1, 29.5, 29.5, 29.5, 45, 10.7);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026042044042658
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026042040111339-6', 'collector:europe', 'Europe', 'Europe', 'europe', 'London', to_timestamp(1779026042039 / 1000.0), to_timestamp(1779026042040116823 / 1000.0), 16.1, 39, 13, '{"created_at":1779026042040116823,"message_id":"collector:europe-1779026042040111339-6","message_type":"weather.packet","payload":{"city":"London","continent":"Europe","country":"Europe","humidity":39.0,"region":"europe","temperature":16.1,"timestamp":1779026042039,"wind_speed":13.0},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Europe', 'Europe', 'europe', 'London', 1, 16.1, 16.1, 16.1, 39, 13);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026042062800330
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026042059024439-7', 'collector:north_india', 'Asia', 'India', 'north_india', 'Delhi', to_timestamp(1779026041980 / 1000.0), to_timestamp(1779026042059030332 / 1000.0), 37, 26, 13.6, '{"created_at":1779026042059030332,"message_id":"collector:north_india-1779026042059024439-7","message_type":"weather.packet","payload":{"city":"Delhi","continent":"Asia","country":"India","humidity":26.0,"region":"north_india","temperature":37.0,"timestamp":1779026041980,"wind_speed":13.6},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Asia', 'India', 'north_india', 'Delhi', 1, 37, 37, 37, 26, 13.6);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026042072642955
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026042069003727-7', 'collector:americas', 'Americas', 'USA', 'americas', 'Los Angeles', to_timestamp(1779026041972 / 1000.0), to_timestamp(1779026042069009331 / 1000.0), 16.2, 78, 5.9, '{"created_at":1779026042069009331,"message_id":"collector:americas-1779026042069003727-7","message_type":"weather.packet","payload":{"city":"Los Angeles","continent":"Americas","country":"USA","humidity":78.0,"region":"americas","temperature":16.2,"timestamp":1779026041972,"wind_speed":5.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Americas', 'USA', 'americas', 'Los Angeles', 1, 16.2, 16.2, 16.2, 78, 5.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026042248424258
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026042244637108-7', 'collector:europe', 'Europe', 'Europe', 'europe', 'Paris', to_timestamp(1779026042147 / 1000.0), to_timestamp(1779026042244643577 / 1000.0), 14.3, 76, 9.3, '{"created_at":1779026042244643577,"message_id":"collector:europe-1779026042244637108-7","message_type":"weather.packet","payload":{"city":"Paris","continent":"Europe","country":"Europe","humidity":76.0,"region":"europe","temperature":14.3,"timestamp":1779026042147,"wind_speed":9.3},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Europe', 'Europe', 'europe', 'Paris', 1, 14.3, 14.3, 14.3, 76, 9.3);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026044102221537
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026044095696435-7', 'collector:south_india', 'Asia', 'India', 'south_india', 'Hyderabad', to_timestamp(1779026044019 / 1000.0), to_timestamp(1779026044095704741 / 1000.0), 33.2, 45, 6.2, '{"created_at":1779026044095704741,"message_id":"collector:south_india-1779026044095696435-7","message_type":"weather.packet","payload":{"city":"Hyderabad","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":33.2,"timestamp":1779026044019,"wind_speed":6.2},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Asia', 'India', 'south_india', 'Hyderabad', 1, 33.2, 33.2, 33.2, 45, 6.2);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026047142327308
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026047136184877-8', 'collector:north_india', 'Asia', 'India', 'north_india', 'Mumbai', to_timestamp(1779026047135 / 1000.0), to_timestamp(1779026047136192423 / 1000.0), 30.4, 76, 9, '{"created_at":1779026047136192423,"message_id":"collector:north_india-1779026047136184877-8","message_type":"weather.packet","payload":{"city":"Mumbai","continent":"Asia","country":"India","humidity":76.0,"region":"north_india","temperature":30.4,"timestamp":1779026047135,"wind_speed":9.0},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Asia', 'India', 'north_india', 'Mumbai', 1, 30.4, 30.4, 30.4, 76, 9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026047160332622
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026047156575015-8', 'collector:americas', 'Americas', 'USA', 'americas', 'New York', to_timestamp(1779026047156 / 1000.0), to_timestamp(1779026047156579257 / 1000.0), 25.4, 54, 7.9, '{"created_at":1779026047156579257,"message_id":"collector:americas-1779026047156575015-8","message_type":"weather.packet","payload":{"city":"New York","continent":"Americas","country":"USA","humidity":54.0,"region":"americas","temperature":25.4,"timestamp":1779026047156,"wind_speed":7.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Americas', 'USA', 'americas', 'New York', 1, 25.4, 25.4, 25.4, 54, 7.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026047160872049
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026047156905656-9', 'collector:americas', 'Americas', 'USA', 'americas', 'Los Angeles', to_timestamp(1779026047156 / 1000.0), to_timestamp(1779026047156909248 / 1000.0), 16.2, 78, 5.9, '{"created_at":1779026047156909248,"message_id":"collector:americas-1779026047156905656-9","message_type":"weather.packet","payload":{"city":"Los Angeles","continent":"Americas","country":"USA","humidity":78.0,"region":"americas","temperature":16.2,"timestamp":1779026047156,"wind_speed":5.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Americas', 'USA', 'americas', 'Los Angeles', 1, 16.2, 16.2, 16.2, 78, 5.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026047192941254
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026047189347805-8', 'collector:south_india', 'Asia', 'India', 'south_india', 'Bangalore', to_timestamp(1779026047149 / 1000.0), to_timestamp(1779026047189352651 / 1000.0), 29.5, 45, 10.7, '{"created_at":1779026047189352651,"message_id":"collector:south_india-1779026047189347805-8","message_type":"weather.packet","payload":{"city":"Bangalore","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":29.5,"timestamp":1779026047149,"wind_speed":10.7},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Asia', 'India', 'south_india', 'Bangalore', 1, 29.5, 29.5, 29.5, 45, 10.7);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026047222995328
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026047219411722-8', 'collector:europe', 'Europe', 'Europe', 'europe', 'London', to_timestamp(1779026047219 / 1000.0), to_timestamp(1779026047219416041 / 1000.0), 16.1, 39, 13, '{"created_at":1779026047219416041,"message_id":"collector:europe-1779026047219411722-8","message_type":"weather.packet","payload":{"city":"London","continent":"Europe","country":"Europe","humidity":39.0,"region":"europe","temperature":16.1,"timestamp":1779026047219,"wind_speed":13.0},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Europe', 'Europe', 'europe', 'London', 1, 16.1, 16.1, 16.1, 39, 13);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026047240113198
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026047236735117-9', 'collector:north_india', 'Asia', 'India', 'north_india', 'Delhi', to_timestamp(1779026047157 / 1000.0), to_timestamp(1779026047236739929 / 1000.0), 37, 26, 13.6, '{"created_at":1779026047236739929,"message_id":"collector:north_india-1779026047236735117-9","message_type":"weather.packet","payload":{"city":"Delhi","continent":"Asia","country":"India","humidity":26.0,"region":"north_india","temperature":37.0,"timestamp":1779026047157,"wind_speed":13.6},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Asia', 'India', 'north_india', 'Delhi', 1, 37, 37, 37, 26, 13.6);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026047423536416
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026047420022864-9', 'collector:europe', 'Europe', 'Europe', 'europe', 'Paris', to_timestamp(1779026047379 / 1000.0), to_timestamp(1779026047420028316 / 1000.0), 14.3, 76, 9.3, '{"created_at":1779026047420028316,"message_id":"collector:europe-1779026047420022864-9","message_type":"weather.packet","payload":{"city":"Paris","continent":"Europe","country":"Europe","humidity":76.0,"region":"europe","temperature":14.3,"timestamp":1779026047379,"wind_speed":9.3},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Europe', 'Europe', 'europe', 'Paris', 1, 14.3, 14.3, 14.3, 76, 9.3);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026049241226199
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026049237180693-9', 'collector:south_india', 'Asia', 'India', 'south_india', 'Hyderabad', to_timestamp(1779026049228 / 1000.0), to_timestamp(1779026049237186638 / 1000.0), 33.2, 45, 6.2, '{"created_at":1779026049237186638,"message_id":"collector:south_india-1779026049237180693-9","message_type":"weather.packet","payload":{"city":"Hyderabad","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":33.2,"timestamp":1779026049228,"wind_speed":6.2},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Asia', 'India', 'south_india', 'Hyderabad', 1, 33.2, 33.2, 33.2, 45, 6.2);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026050104982414
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026050098698896-10', 'collector:north_india', 'Asia', 'India', 'north_india', 'Mumbai', to_timestamp(1779026050098 / 1000.0), to_timestamp(1779026050098704547 / 1000.0), 30.4, 76, 9, '{"created_at":1779026050098704547,"message_id":"collector:north_india-1779026050098698896-10","message_type":"weather.packet","payload":{"city":"Mumbai","continent":"Asia","country":"India","humidity":76.0,"region":"north_india","temperature":30.4,"timestamp":1779026050098,"wind_speed":9.0},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Asia', 'India', 'north_india', 'Mumbai', 1, 30.4, 30.4, 30.4, 76, 9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026050128328543
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026050124699060-10', 'collector:americas', 'Americas', 'USA', 'americas', 'New York', to_timestamp(1779026050124 / 1000.0), to_timestamp(1779026050124703999 / 1000.0), 25.4, 54, 7.9, '{"created_at":1779026050124703999,"message_id":"collector:americas-1779026050124699060-10","message_type":"weather.packet","payload":{"city":"New York","continent":"Americas","country":"USA","humidity":54.0,"region":"americas","temperature":25.4,"timestamp":1779026050124,"wind_speed":7.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Americas', 'USA', 'americas', 'New York', 1, 25.4, 25.4, 25.4, 54, 7.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026050203114306
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026050198100117-10', 'collector:south_india', 'Asia', 'India', 'south_india', 'Bangalore', to_timestamp(1779026050109 / 1000.0), to_timestamp(1779026050198106315 / 1000.0), 29.5, 45, 10.7, '{"created_at":1779026050198106315,"message_id":"collector:south_india-1779026050198100117-10","message_type":"weather.packet","payload":{"city":"Bangalore","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":29.5,"timestamp":1779026050109,"wind_speed":10.7},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Asia', 'India', 'south_india', 'Bangalore', 1, 29.5, 29.5, 29.5, 45, 10.7);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026050204843219
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026050200404360-11', 'collector:north_india', 'Asia', 'India', 'north_india', 'Delhi', to_timestamp(1779026050158 / 1000.0), to_timestamp(1779026050200412991 / 1000.0), 37, 26, 13.6, '{"created_at":1779026050200412991,"message_id":"collector:north_india-1779026050200404360-11","message_type":"weather.packet","payload":{"city":"Delhi","continent":"Asia","country":"India","humidity":26.0,"region":"north_india","temperature":37.0,"timestamp":1779026050158,"wind_speed":13.6},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Asia', 'India', 'north_india', 'Delhi', 1, 37, 37, 37, 26, 13.6);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026050229343200
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026050225386460-11', 'collector:americas', 'Americas', 'USA', 'americas', 'Los Angeles', to_timestamp(1779026050142 / 1000.0), to_timestamp(1779026050225391551 / 1000.0), 16.2, 78, 5.9, '{"created_at":1779026050225391551,"message_id":"collector:americas-1779026050225386460-11","message_type":"weather.packet","payload":{"city":"Los Angeles","continent":"Americas","country":"USA","humidity":78.0,"region":"americas","temperature":16.2,"timestamp":1779026050142,"wind_speed":5.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Americas', 'USA', 'americas', 'Los Angeles', 1, 16.2, 16.2, 16.2, 78, 5.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026050260030185
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026050255919241-10', 'collector:europe', 'Europe', 'Europe', 'europe', 'London', to_timestamp(1779026050255 / 1000.0), to_timestamp(1779026050255923264 / 1000.0), 16.1, 39, 13, '{"created_at":1779026050255923264,"message_id":"collector:europe-1779026050255919241-10","message_type":"weather.packet","payload":{"city":"London","continent":"Europe","country":"Europe","humidity":39.0,"region":"europe","temperature":16.1,"timestamp":1779026050255,"wind_speed":13.0},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Europe', 'Europe', 'europe', 'London', 1, 16.1, 16.1, 16.1, 39, 13);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026050364595265
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026050360591451-11', 'collector:europe', 'Europe', 'Europe', 'europe', 'Paris', to_timestamp(1779026050359 / 1000.0), to_timestamp(1779026050360595916 / 1000.0), 14.3, 76, 9.3, '{"created_at":1779026050360595916,"message_id":"collector:europe-1779026050360591451-11","message_type":"weather.packet","payload":{"city":"Paris","continent":"Europe","country":"Europe","humidity":76.0,"region":"europe","temperature":14.3,"timestamp":1779026050359,"wind_speed":9.3},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Europe', 'Europe', 'europe', 'Paris', 1, 14.3, 14.3, 14.3, 76, 9.3);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026052253721258
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026052249055855-11', 'collector:south_india', 'Asia', 'India', 'south_india', 'Hyderabad', to_timestamp(1779026052245 / 1000.0), to_timestamp(1779026052249060887 / 1000.0), 33.2, 45, 6.2, '{"created_at":1779026052249060887,"message_id":"collector:south_india-1779026052249055855-11","message_type":"weather.packet","payload":{"city":"Hyderabad","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":33.2,"timestamp":1779026052245,"wind_speed":6.2},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Asia', 'India', 'south_india', 'Hyderabad', 1, 33.2, 33.2, 33.2, 45, 6.2);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026055281405088
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026055276007990-12', 'collector:north_india', 'Asia', 'India', 'north_india', 'Mumbai', to_timestamp(1779026055275 / 1000.0), to_timestamp(1779026055276014094 / 1000.0), 30.4, 76, 9, '{"created_at":1779026055276014094,"message_id":"collector:north_india-1779026055276007990-12","message_type":"weather.packet","payload":{"city":"Mumbai","continent":"Asia","country":"India","humidity":76.0,"region":"north_india","temperature":30.4,"timestamp":1779026055275,"wind_speed":9.0},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Asia', 'India', 'north_india', 'Mumbai', 1, 30.4, 30.4, 30.4, 76, 9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026055313003193
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026055309421707-12', 'collector:americas', 'Americas', 'USA', 'americas', 'New York', to_timestamp(1779026055309 / 1000.0), to_timestamp(1779026055309426213 / 1000.0), 25.4, 54, 7.9, '{"created_at":1779026055309426213,"message_id":"collector:americas-1779026055309421707-12","message_type":"weather.packet","payload":{"city":"New York","continent":"Americas","country":"USA","humidity":54.0,"region":"americas","temperature":25.4,"timestamp":1779026055309,"wind_speed":7.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Americas', 'USA', 'americas', 'New York', 1, 25.4, 25.4, 25.4, 54, 7.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026055335127826
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026055331654386-12', 'collector:south_india', 'Asia', 'India', 'south_india', 'Bangalore', to_timestamp(1779026055286 / 1000.0), to_timestamp(1779026055331659510 / 1000.0), 29.5, 45, 10.7, '{"created_at":1779026055331659510,"message_id":"collector:south_india-1779026055331654386-12","message_type":"weather.packet","payload":{"city":"Bangalore","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":29.5,"timestamp":1779026055286,"wind_speed":10.7},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Asia', 'India', 'south_india', 'Bangalore', 1, 29.5, 29.5, 29.5, 45, 10.7);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026055380276354
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026055376527197-13', 'collector:north_india', 'Asia', 'India', 'north_india', 'Delhi', to_timestamp(1779026055345 / 1000.0), to_timestamp(1779026055376532906 / 1000.0), 37, 26, 13.6, '{"created_at":1779026055376532906,"message_id":"collector:north_india-1779026055376527197-13","message_type":"weather.packet","payload":{"city":"Delhi","continent":"Asia","country":"India","humidity":26.0,"region":"north_india","temperature":37.0,"timestamp":1779026055345,"wind_speed":13.6},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Asia', 'India', 'north_india', 'Delhi', 1, 37, 37, 37, 26, 13.6);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026055413695247
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026055410030987-13', 'collector:americas', 'Americas', 'USA', 'americas', 'Los Angeles', to_timestamp(1779026055326 / 1000.0), to_timestamp(1779026055410036445 / 1000.0), 16.2, 78, 5.9, '{"created_at":1779026055410036445,"message_id":"collector:americas-1779026055410030987-13","message_type":"weather.packet","payload":{"city":"Los Angeles","continent":"Americas","country":"USA","humidity":78.0,"region":"americas","temperature":16.2,"timestamp":1779026055326,"wind_speed":5.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Americas', 'USA', 'americas', 'Los Angeles', 1, 16.2, 16.2, 16.2, 78, 5.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026055438749107
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026055435396696-12', 'collector:europe', 'Europe', 'Europe', 'europe', 'London', to_timestamp(1779026055435 / 1000.0), to_timestamp(1779026055435400875 / 1000.0), 16.1, 39, 13, '{"created_at":1779026055435400875,"message_id":"collector:europe-1779026055435396696-12","message_type":"weather.packet","payload":{"city":"London","continent":"Europe","country":"Europe","humidity":39.0,"region":"europe","temperature":16.1,"timestamp":1779026055435,"wind_speed":13.0},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Europe', 'Europe', 'europe', 'London', 1, 16.1, 16.1, 16.1, 39, 13);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026055639486694
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026055635999144-13', 'collector:europe', 'Europe', 'Europe', 'europe', 'Paris', to_timestamp(1779026055600 / 1000.0), to_timestamp(1779026055636004375 / 1000.0), 14.3, 76, 9.3, '{"created_at":1779026055636004375,"message_id":"collector:europe-1779026055635999144-13","message_type":"weather.packet","payload":{"city":"Paris","continent":"Europe","country":"Europe","humidity":76.0,"region":"europe","temperature":14.3,"timestamp":1779026055600,"wind_speed":9.3},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Europe', 'Europe', 'europe', 'Paris', 1, 14.3, 14.3, 14.3, 76, 9.3);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026057667044955
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026057662857779-13', 'collector:south_india', 'Asia', 'India', 'south_india', 'Hyderabad', to_timestamp(1779026057586 / 1000.0), to_timestamp(1779026057662864710 / 1000.0), 33.2, 45, 6.2, '{"created_at":1779026057662864710,"message_id":"collector:south_india-1779026057662857779-13","message_type":"weather.packet","payload":{"city":"Hyderabad","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":33.2,"timestamp":1779026057586,"wind_speed":6.2},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Asia', 'India', 'south_india', 'Hyderabad', 1, 33.2, 33.2, 33.2, 45, 6.2);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026060473793508
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026060467811450-14', 'collector:north_india', 'Asia', 'India', 'north_india', 'Mumbai', to_timestamp(1779026060467 / 1000.0), to_timestamp(1779026060467817955 / 1000.0), 30.4, 76, 9, '{"created_at":1779026060467817955,"message_id":"collector:north_india-1779026060467811450-14","message_type":"weather.packet","payload":{"city":"Mumbai","continent":"Asia","country":"India","humidity":76.0,"region":"north_india","temperature":30.4,"timestamp":1779026060467,"wind_speed":9.0},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Asia', 'India', 'north_india', 'Mumbai', 1, 30.4, 30.4, 30.4, 76, 9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026060522093907
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026060518169835-14', 'collector:americas', 'Americas', 'USA', 'americas', 'New York', to_timestamp(1779026060517 / 1000.0), to_timestamp(1779026060518174947 / 1000.0), 25.4, 54, 7.9, '{"created_at":1779026060518174947,"message_id":"collector:americas-1779026060518169835-14","message_type":"weather.packet","payload":{"city":"New York","continent":"Americas","country":"USA","humidity":54.0,"region":"americas","temperature":25.4,"timestamp":1779026060517,"wind_speed":7.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Americas', 'USA', 'americas', 'New York', 1, 25.4, 25.4, 25.4, 54, 7.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026060575619848
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026060571813992-14', 'collector:south_india', 'Asia', 'India', 'south_india', 'Bangalore', to_timestamp(1779026060479 / 1000.0), to_timestamp(1779026060571819192 / 1000.0), 29.5, 45, 10.7, '{"created_at":1779026060571819192,"message_id":"collector:south_india-1779026060571813992-14","message_type":"weather.packet","payload":{"city":"Bangalore","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":29.5,"timestamp":1779026060479,"wind_speed":10.7},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Asia', 'India', 'south_india', 'Bangalore', 1, 29.5, 29.5, 29.5, 45, 10.7);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026060580089750
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026060576639909-15', 'collector:north_india', 'Asia', 'India', 'north_india', 'Delhi', to_timestamp(1779026060545 / 1000.0), to_timestamp(1779026060576644966 / 1000.0), 37, 26, 13.6, '{"created_at":1779026060576644966,"message_id":"collector:north_india-1779026060576639909-15","message_type":"weather.packet","payload":{"city":"Delhi","continent":"Asia","country":"India","humidity":26.0,"region":"north_india","temperature":37.0,"timestamp":1779026060545,"wind_speed":13.6},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Asia', 'India', 'north_india', 'Delhi', 1, 37, 37, 37, 26, 13.6);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026060626222634
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026060622446011-15', 'collector:americas', 'Americas', 'USA', 'americas', 'Los Angeles', to_timestamp(1779026060530 / 1000.0), to_timestamp(1779026060622451407 / 1000.0), 16.2, 78, 5.9, '{"created_at":1779026060622451407,"message_id":"collector:americas-1779026060622446011-15","message_type":"weather.packet","payload":{"city":"Los Angeles","continent":"Americas","country":"USA","humidity":78.0,"region":"americas","temperature":16.2,"timestamp":1779026060530,"wind_speed":5.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Americas', 'USA', 'americas', 'Los Angeles', 1, 16.2, 16.2, 16.2, 78, 5.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026060638262894
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026060634035187-14', 'collector:europe', 'Europe', 'Europe', 'europe', 'London', to_timestamp(1779026060633 / 1000.0), to_timestamp(1779026060634039593 / 1000.0), 16.1, 39, 13, '{"created_at":1779026060634039593,"message_id":"collector:europe-1779026060634035187-14","message_type":"weather.packet","payload":{"city":"London","continent":"Europe","country":"Europe","humidity":39.0,"region":"europe","temperature":16.1,"timestamp":1779026060633,"wind_speed":13.0},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Europe', 'Europe', 'europe', 'London', 1, 16.1, 16.1, 16.1, 39, 13);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026060942522575
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026060937392315-15', 'collector:europe', 'Europe', 'Europe', 'europe', 'Paris', to_timestamp(1779026060915 / 1000.0), to_timestamp(1779026060937398855 / 1000.0), 14.3, 76, 9.3, '{"created_at":1779026060937398855,"message_id":"collector:europe-1779026060937392315-15","message_type":"weather.packet","payload":{"city":"Paris","continent":"Europe","country":"Europe","humidity":76.0,"region":"europe","temperature":14.3,"timestamp":1779026060915,"wind_speed":9.3},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Europe', 'Europe', 'europe', 'Paris', 1, 14.3, 14.3, 14.3, 76, 9.3);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026062848819296
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026062840334386-15', 'collector:south_india', 'Asia', 'India', 'south_india', 'Hyderabad', to_timestamp(1779026062833 / 1000.0), to_timestamp(1779026062840343013 / 1000.0), 33.2, 45, 6.2, '{"created_at":1779026062840343013,"message_id":"collector:south_india-1779026062840334386-15","message_type":"weather.packet","payload":{"city":"Hyderabad","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":33.2,"timestamp":1779026062833,"wind_speed":6.2},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Asia', 'India', 'south_india', 'Hyderabad', 1, 33.2, 33.2, 33.2, 45, 6.2);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026065670366286
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026065661788550-16', 'collector:north_india', 'Asia', 'India', 'north_india', 'Mumbai', to_timestamp(1779026065661 / 1000.0), to_timestamp(1779026065661795670 / 1000.0), 30.4, 76, 9, '{"created_at":1779026065661795670,"message_id":"collector:north_india-1779026065661788550-16","message_type":"weather.packet","payload":{"city":"Mumbai","continent":"Asia","country":"India","humidity":76.0,"region":"north_india","temperature":30.4,"timestamp":1779026065661,"wind_speed":9.0},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Asia', 'India', 'north_india', 'Mumbai', 1, 30.4, 30.4, 30.4, 76, 9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026065723346363
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026065714191785-16', 'collector:south_india', 'Asia', 'India', 'south_india', 'Bangalore', to_timestamp(1779026065681 / 1000.0), to_timestamp(1779026065714197491 / 1000.0), 29.5, 45, 10.7, '{"created_at":1779026065714197491,"message_id":"collector:south_india-1779026065714191785-16","message_type":"weather.packet","payload":{"city":"Bangalore","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":29.5,"timestamp":1779026065681,"wind_speed":10.7},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Asia', 'India', 'south_india', 'Bangalore', 1, 29.5, 29.5, 29.5, 45, 10.7);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026065730743667
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026065724461292-16', 'collector:americas', 'Americas', 'USA', 'americas', 'New York', to_timestamp(1779026065724 / 1000.0), to_timestamp(1779026065724465316 / 1000.0), 25.4, 54, 7.9, '{"created_at":1779026065724465316,"message_id":"collector:americas-1779026065724461292-16","message_type":"weather.packet","payload":{"city":"New York","continent":"Americas","country":"USA","humidity":54.0,"region":"americas","temperature":25.4,"timestamp":1779026065724,"wind_speed":7.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Americas', 'USA', 'americas', 'New York', 1, 25.4, 25.4, 25.4, 54, 7.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026065740535227
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026065736773207-17', 'collector:americas', 'Americas', 'USA', 'americas', 'Los Angeles', to_timestamp(1779026065735 / 1000.0), to_timestamp(1779026065736777790 / 1000.0), 16.2, 78, 5.9, '{"created_at":1779026065736777790,"message_id":"collector:americas-1779026065736773207-17","message_type":"weather.packet","payload":{"city":"Los Angeles","continent":"Americas","country":"USA","humidity":78.0,"region":"americas","temperature":16.2,"timestamp":1779026065735,"wind_speed":5.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Americas', 'USA', 'americas', 'Los Angeles', 1, 16.2, 16.2, 16.2, 78, 5.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026065753761479
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026065750021676-17', 'collector:north_india', 'Asia', 'India', 'north_india', 'Delhi', to_timestamp(1779026065749 / 1000.0), to_timestamp(1779026065750026079 / 1000.0), 37, 26, 13.6, '{"created_at":1779026065750026079,"message_id":"collector:north_india-1779026065750021676-17","message_type":"weather.packet","payload":{"city":"Delhi","continent":"Asia","country":"India","humidity":26.0,"region":"north_india","temperature":37.0,"timestamp":1779026065749,"wind_speed":13.6},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Asia', 'India', 'north_india', 'Delhi', 1, 37, 37, 37, 26, 13.6);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026065916008368
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026065912042153-16', 'collector:europe', 'Europe', 'Europe', 'europe', 'London', to_timestamp(1779026065844 / 1000.0), to_timestamp(1779026065912048029 / 1000.0), 16.1, 39, 13, '{"created_at":1779026065912048029,"message_id":"collector:europe-1779026065912042153-16","message_type":"weather.packet","payload":{"city":"London","continent":"Europe","country":"Europe","humidity":39.0,"region":"europe","temperature":16.1,"timestamp":1779026065844,"wind_speed":13.0},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Europe', 'Europe', 'europe', 'London', 1, 16.1, 16.1, 16.1, 39, 13);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026066220738876
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026066216251403-17', 'collector:europe', 'Europe', 'Europe', 'europe', 'Paris', to_timestamp(1779026066164 / 1000.0), to_timestamp(1779026066216257821 / 1000.0), 14.3, 76, 9.3, '{"created_at":1779026066216257821,"message_id":"collector:europe-1779026066216251403-17","message_type":"weather.packet","payload":{"city":"Paris","continent":"Europe","country":"Europe","humidity":76.0,"region":"europe","temperature":14.3,"timestamp":1779026066164,"wind_speed":9.3},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Europe', 'Europe', 'europe', 'Paris', 1, 14.3, 14.3, 14.3, 76, 9.3);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026068146937075
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026068139190540-17', 'collector:south_india', 'Asia', 'India', 'south_india', 'Hyderabad', to_timestamp(1779026068104 / 1000.0), to_timestamp(1779026068139196961 / 1000.0), 33.2, 45, 6.2, '{"created_at":1779026068139196961,"message_id":"collector:south_india-1779026068139190540-17","message_type":"weather.packet","payload":{"city":"Hyderabad","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":33.2,"timestamp":1779026068104,"wind_speed":6.2},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Asia', 'India', 'south_india', 'Hyderabad', 1, 33.2, 33.2, 33.2, 45, 6.2);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026070869772219
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026070863744826-18', 'collector:north_india', 'Asia', 'India', 'north_india', 'Mumbai', to_timestamp(1779026070863 / 1000.0), to_timestamp(1779026070863752561 / 1000.0), 30.4, 76, 9, '{"created_at":1779026070863752561,"message_id":"collector:north_india-1779026070863744826-18","message_type":"weather.packet","payload":{"city":"Mumbai","continent":"Asia","country":"India","humidity":76.0,"region":"north_india","temperature":30.4,"timestamp":1779026070863,"wind_speed":9.0},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Asia', 'India', 'north_india', 'Mumbai', 1, 30.4, 30.4, 30.4, 76, 9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026070938041494
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026070934022090-18', 'collector:americas', 'Americas', 'USA', 'americas', 'Los Angeles', to_timestamp(1779026070933 / 1000.0), to_timestamp(1779026070934026619 / 1000.0), 16.2, 78, 5.9, '{"created_at":1779026070934026619,"message_id":"collector:americas-1779026070934022090-18","message_type":"weather.packet","payload":{"city":"Los Angeles","continent":"Americas","country":"USA","humidity":78.0,"region":"americas","temperature":16.2,"timestamp":1779026070933,"wind_speed":5.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Americas', 'USA', 'americas', 'Los Angeles', 1, 16.2, 16.2, 16.2, 78, 5.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026070960008260
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026070956450042-18', 'collector:south_india', 'Asia', 'India', 'south_india', 'Bangalore', to_timestamp(1779026070871 / 1000.0), to_timestamp(1779026070956455263 / 1000.0), 29.5, 45, 10.7, '{"created_at":1779026070956455263,"message_id":"collector:south_india-1779026070956450042-18","message_type":"weather.packet","payload":{"city":"Bangalore","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":29.5,"timestamp":1779026070871,"wind_speed":10.7},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Asia', 'India', 'south_india', 'Bangalore', 1, 29.5, 29.5, 29.5, 45, 10.7);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026070971127052
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026070967747002-19', 'collector:north_india', 'Asia', 'India', 'north_india', 'Delhi', to_timestamp(1779026070935 / 1000.0), to_timestamp(1779026070967752388 / 1000.0), 37, 26, 13.6, '{"created_at":1779026070967752388,"message_id":"collector:north_india-1779026070967747002-19","message_type":"weather.packet","payload":{"city":"Delhi","continent":"Asia","country":"India","humidity":26.0,"region":"north_india","temperature":37.0,"timestamp":1779026070935,"wind_speed":13.6},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Asia', 'India', 'north_india', 'Delhi', 1, 37, 37, 37, 26, 13.6);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026071038056966
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026071034456203-19', 'collector:americas', 'Americas', 'USA', 'americas', 'New York', to_timestamp(1779026070939 / 1000.0), to_timestamp(1779026071034460919 / 1000.0), 25.4, 54, 7.9, '{"created_at":1779026071034460919,"message_id":"collector:americas-1779026071034456203-19","message_type":"weather.packet","payload":{"city":"New York","continent":"Americas","country":"USA","humidity":54.0,"region":"americas","temperature":25.4,"timestamp":1779026070939,"wind_speed":7.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Americas', 'USA', 'americas', 'New York', 1, 25.4, 25.4, 25.4, 54, 7.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026071067698002
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026071064297640-18', 'collector:europe', 'Europe', 'Europe', 'europe', 'London', to_timestamp(1779026071026 / 1000.0), to_timestamp(1779026071064302444 / 1000.0), 16.1, 39, 13, '{"created_at":1779026071064302444,"message_id":"collector:europe-1779026071064297640-18","message_type":"weather.packet","payload":{"city":"London","continent":"Europe","country":"Europe","humidity":39.0,"region":"europe","temperature":16.1,"timestamp":1779026071026,"wind_speed":13.0},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Europe', 'Europe', 'europe', 'London', 1, 16.1, 16.1, 16.1, 39, 13);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026071370854575
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026071365421668-19', 'collector:europe', 'Europe', 'Europe', 'europe', 'Paris', to_timestamp(1779026071343 / 1000.0), to_timestamp(1779026071365428028 / 1000.0), 14.3, 76, 9.3, '{"created_at":1779026071365428028,"message_id":"collector:europe-1779026071365421668-19","message_type":"weather.packet","payload":{"city":"Paris","continent":"Europe","country":"Europe","humidity":76.0,"region":"europe","temperature":14.3,"timestamp":1779026071343,"wind_speed":9.3},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Europe', 'Europe', 'europe', 'Paris', 1, 14.3, 14.3, 14.3, 76, 9.3);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026073438127564
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026073432213001-19', 'collector:south_india', 'Asia', 'India', 'south_india', 'Hyderabad', to_timestamp(1779026073394 / 1000.0), to_timestamp(1779026073432221007 / 1000.0), 33.2, 45, 6.2, '{"created_at":1779026073432221007,"message_id":"collector:south_india-1779026073432213001-19","message_type":"weather.packet","payload":{"city":"Hyderabad","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":33.2,"timestamp":1779026073394,"wind_speed":6.2},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Asia', 'India', 'south_india', 'Hyderabad', 1, 33.2, 33.2, 33.2, 45, 6.2);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026076060224476
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026076053788256-20', 'collector:north_india', 'Asia', 'India', 'north_india', 'Mumbai', to_timestamp(1779026076053 / 1000.0), to_timestamp(1779026076053796600 / 1000.0), 30.4, 76, 9, '{"created_at":1779026076053796600,"message_id":"collector:north_india-1779026076053788256-20","message_type":"weather.packet","payload":{"city":"Mumbai","continent":"Asia","country":"India","humidity":76.0,"region":"north_india","temperature":30.4,"timestamp":1779026076053,"wind_speed":9.0},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Asia', 'India', 'north_india', 'Mumbai', 1, 30.4, 30.4, 30.4, 76, 9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026076142877279
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026076136490815-20', 'collector:americas', 'Americas', 'USA', 'americas', 'Los Angeles', to_timestamp(1779026076135 / 1000.0), to_timestamp(1779026076136497915 / 1000.0), 16.2, 78, 5.9, '{"created_at":1779026076136497915,"message_id":"collector:americas-1779026076136490815-20","message_type":"weather.packet","payload":{"city":"Los Angeles","continent":"Americas","country":"USA","humidity":78.0,"region":"americas","temperature":16.2,"timestamp":1779026076135,"wind_speed":5.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Americas', 'USA', 'americas', 'Los Angeles', 1, 16.2, 16.2, 16.2, 78, 5.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026076148114000
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026076143419023-20', 'collector:south_india', 'Asia', 'India', 'south_india', 'Bangalore', to_timestamp(1779026076064 / 1000.0), to_timestamp(1779026076143424945 / 1000.0), 29.5, 45, 10.7, '{"created_at":1779026076143424945,"message_id":"collector:south_india-1779026076143419023-20","message_type":"weather.packet","payload":{"city":"Bangalore","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":29.5,"timestamp":1779026076064,"wind_speed":10.7},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Asia', 'India', 'south_india', 'Bangalore', 1, 29.5, 29.5, 29.5, 45, 10.7);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026076149958847
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026076146056955-21', 'collector:americas', 'Americas', 'USA', 'americas', 'New York', to_timestamp(1779026076145 / 1000.0), to_timestamp(1779026076146062403 / 1000.0), 25.4, 54, 7.9, '{"created_at":1779026076146062403,"message_id":"collector:americas-1779026076146056955-21","message_type":"weather.packet","payload":{"city":"New York","continent":"Americas","country":"USA","humidity":54.0,"region":"americas","temperature":25.4,"timestamp":1779026076145,"wind_speed":7.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Americas', 'USA', 'americas', 'New York', 1, 25.4, 25.4, 25.4, 54, 7.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026076158316587
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026076154442724-21', 'collector:north_india', 'Asia', 'India', 'north_india', 'Delhi', to_timestamp(1779026076140 / 1000.0), to_timestamp(1779026076154447954 / 1000.0), 37, 26, 13.6, '{"created_at":1779026076154447954,"message_id":"collector:north_india-1779026076154442724-21","message_type":"weather.packet","payload":{"city":"Delhi","continent":"Asia","country":"India","humidity":26.0,"region":"north_india","temperature":37.0,"timestamp":1779026076140,"wind_speed":13.6},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Asia', 'India', 'north_india', 'Delhi', 1, 37, 37, 37, 26, 13.6);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026076307276005
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026076303653735-20', 'collector:europe', 'Europe', 'Europe', 'europe', 'London', to_timestamp(1779026076221 / 1000.0), to_timestamp(1779026076303659078 / 1000.0), 16.1, 39, 13, '{"created_at":1779026076303659078,"message_id":"collector:europe-1779026076303653735-20","message_type":"weather.packet","payload":{"city":"London","continent":"Europe","country":"Europe","humidity":39.0,"region":"europe","temperature":16.1,"timestamp":1779026076221,"wind_speed":13.0},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Europe', 'Europe', 'europe', 'London', 1, 16.1, 16.1, 16.1, 39, 13);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026076624244374
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026076617533608-21', 'collector:europe', 'Europe', 'Europe', 'europe', 'Paris', to_timestamp(1779026076550 / 1000.0), to_timestamp(1779026076617543014 / 1000.0), 14.3, 76, 9.3, '{"created_at":1779026076617543014,"message_id":"collector:europe-1779026076617533608-21","message_type":"weather.packet","payload":{"city":"Paris","continent":"Europe","country":"Europe","humidity":76.0,"region":"europe","temperature":14.3,"timestamp":1779026076550,"wind_speed":9.3},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Europe', 'Europe', 'europe', 'Paris', 1, 14.3, 14.3, 14.3, 76, 9.3);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026078750041363
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026078743129791-21', 'collector:south_india', 'Asia', 'India', 'south_india', 'Hyderabad', to_timestamp(1779026078719 / 1000.0), to_timestamp(1779026078743137295 / 1000.0), 33.2, 45, 6.2, '{"created_at":1779026078743137295,"message_id":"collector:south_india-1779026078743129791-21","message_type":"weather.packet","payload":{"city":"Hyderabad","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":33.2,"timestamp":1779026078719,"wind_speed":6.2},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Asia', 'India', 'south_india', 'Hyderabad', 1, 33.2, 33.2, 33.2, 45, 6.2);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026079060965768
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026079054037044-22', 'collector:north_india', 'Asia', 'India', 'north_india', 'Mumbai', to_timestamp(1779026079053 / 1000.0), to_timestamp(1779026079054044096 / 1000.0), 30.4, 76, 9, '{"created_at":1779026079054044096,"message_id":"collector:north_india-1779026079054037044-22","message_type":"weather.packet","payload":{"city":"Mumbai","continent":"Asia","country":"India","humidity":76.0,"region":"north_india","temperature":30.4,"timestamp":1779026079053,"wind_speed":9.0},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Asia', 'India', 'north_india', 'Mumbai', 1, 30.4, 30.4, 30.4, 76, 9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026079131508835
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026079127553328-22', 'collector:south_india', 'Asia', 'India', 'south_india', 'Bangalore', to_timestamp(1779026079072 / 1000.0), to_timestamp(1779026079127558583 / 1000.0), 29.5, 45, 10.7, '{"created_at":1779026079127558583,"message_id":"collector:south_india-1779026079127553328-22","message_type":"weather.packet","payload":{"city":"Bangalore","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":29.5,"timestamp":1779026079072,"wind_speed":10.7},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Asia', 'India', 'south_india', 'Bangalore', 1, 29.5, 29.5, 29.5, 45, 10.7);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026079149482064
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026079145696848-22', 'collector:americas', 'Americas', 'USA', 'americas', 'Los Angeles', to_timestamp(1779026079145 / 1000.0), to_timestamp(1779026079145702624 / 1000.0), 16.2, 78, 5.9, '{"created_at":1779026079145702624,"message_id":"collector:americas-1779026079145696848-22","message_type":"weather.packet","payload":{"city":"Los Angeles","continent":"Americas","country":"USA","humidity":78.0,"region":"americas","temperature":16.2,"timestamp":1779026079145,"wind_speed":5.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Americas', 'USA', 'americas', 'Los Angeles', 1, 16.2, 16.2, 16.2, 78, 5.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026079251528905
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026079246555156-23', 'collector:americas', 'Americas', 'USA', 'americas', 'New York', to_timestamp(1779026079161 / 1000.0), to_timestamp(1779026079246561091 / 1000.0), 25.4, 54, 7.9, '{"created_at":1779026079246561091,"message_id":"collector:americas-1779026079246555156-23","message_type":"weather.packet","payload":{"city":"New York","continent":"Americas","country":"USA","humidity":54.0,"region":"americas","temperature":25.4,"timestamp":1779026079161,"wind_speed":7.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Americas', 'USA', 'americas', 'New York', 1, 25.4, 25.4, 25.4, 54, 7.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026079252106446
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026079246395863-22', 'collector:europe', 'Europe', 'Europe', 'europe', 'London', to_timestamp(1779026079219 / 1000.0), to_timestamp(1779026079246402661 / 1000.0), 16.1, 39, 13, '{"created_at":1779026079246402661,"message_id":"collector:europe-1779026079246395863-22","message_type":"weather.packet","payload":{"city":"London","continent":"Europe","country":"Europe","humidity":39.0,"region":"europe","temperature":16.1,"timestamp":1779026079219,"wind_speed":13.0},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Europe', 'Europe', 'europe', 'London', 1, 16.1, 16.1, 16.1, 39, 13);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026079270659949
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026079266633370-23', 'collector:north_india', 'Asia', 'India', 'north_india', 'Delhi', to_timestamp(1779026079165 / 1000.0), to_timestamp(1779026079266638656 / 1000.0), 37, 26, 13.6, '{"created_at":1779026079266638656,"message_id":"collector:north_india-1779026079266633370-23","message_type":"weather.packet","payload":{"city":"Delhi","continent":"Asia","country":"India","humidity":26.0,"region":"north_india","temperature":37.0,"timestamp":1779026079165,"wind_speed":13.6},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Asia', 'India', 'north_india', 'Delhi', 1, 37, 37, 37, 26, 13.6);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026079677273878
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026079669626370-23', 'collector:europe', 'Europe', 'Europe', 'europe', 'Paris', to_timestamp(1779026079660 / 1000.0), to_timestamp(1779026079669634076 / 1000.0), 14.3, 76, 9.3, '{"created_at":1779026079669634076,"message_id":"collector:europe-1779026079669626370-23","message_type":"weather.packet","payload":{"city":"Paris","continent":"Europe","country":"Europe","humidity":76.0,"region":"europe","temperature":14.3,"timestamp":1779026079660,"wind_speed":9.3},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Europe', 'Europe', 'europe', 'Paris', 1, 14.3, 14.3, 14.3, 76, 9.3);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026081813340002
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026081807718339-23', 'collector:south_india', 'Asia', 'India', 'south_india', 'Hyderabad', to_timestamp(1779026081767 / 1000.0), to_timestamp(1779026081807725275 / 1000.0), 33.2, 45, 6.2, '{"created_at":1779026081807725275,"message_id":"collector:south_india-1779026081807718339-23","message_type":"weather.packet","payload":{"city":"Hyderabad","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":33.2,"timestamp":1779026081767,"wind_speed":6.2},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Asia', 'India', 'south_india', 'Hyderabad', 1, 33.2, 33.2, 33.2, 45, 6.2);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026084251067288
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026084244782672-24', 'collector:north_india', 'Asia', 'India', 'north_india', 'Mumbai', to_timestamp(1779026084244 / 1000.0), to_timestamp(1779026084244790268 / 1000.0), 30.4, 76, 9, '{"created_at":1779026084244790268,"message_id":"collector:north_india-1779026084244782672-24","message_type":"weather.packet","payload":{"city":"Mumbai","continent":"Asia","country":"India","humidity":76.0,"region":"north_india","temperature":30.4,"timestamp":1779026084244,"wind_speed":9.0},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Asia', 'India', 'north_india', 'Mumbai', 1, 30.4, 30.4, 30.4, 76, 9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026084321485462
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026084317617056-24', 'collector:south_india', 'Asia', 'India', 'south_india', 'Bangalore', to_timestamp(1779026084268 / 1000.0), to_timestamp(1779026084317623099 / 1000.0), 29.5, 45, 10.7, '{"created_at":1779026084317623099,"message_id":"collector:south_india-1779026084317617056-24","message_type":"weather.packet","payload":{"city":"Bangalore","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":29.5,"timestamp":1779026084268,"wind_speed":10.7},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Asia', 'India', 'south_india', 'Bangalore', 1, 29.5, 29.5, 29.5, 45, 10.7);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026084364079248
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026084360274329-24', 'collector:americas', 'Americas', 'USA', 'americas', 'Los Angeles', to_timestamp(1779026084360 / 1000.0), to_timestamp(1779026084360278358 / 1000.0), 16.2, 78, 5.9, '{"created_at":1779026084360278358,"message_id":"collector:americas-1779026084360274329-24","message_type":"weather.packet","payload":{"city":"Los Angeles","continent":"Americas","country":"USA","humidity":78.0,"region":"americas","temperature":16.2,"timestamp":1779026084360,"wind_speed":5.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Americas', 'USA', 'americas', 'Los Angeles', 1, 16.2, 16.2, 16.2, 78, 5.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026084430488341
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026084426502038-24', 'collector:europe', 'Europe', 'Europe', 'europe', 'London', to_timestamp(1779026084414 / 1000.0), to_timestamp(1779026084426507324 / 1000.0), 16.1, 39, 13, '{"created_at":1779026084426507324,"message_id":"collector:europe-1779026084426502038-24","message_type":"weather.packet","payload":{"city":"London","continent":"Europe","country":"Europe","humidity":39.0,"region":"europe","temperature":16.1,"timestamp":1779026084414,"wind_speed":13.0},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Europe', 'Europe', 'europe', 'London', 1, 16.1, 16.1, 16.1, 39, 13);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026084460455048
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026084456624697-25', 'collector:north_india', 'Asia', 'India', 'north_india', 'Delhi', to_timestamp(1779026084380 / 1000.0), to_timestamp(1779026084456631081 / 1000.0), 37, 26, 13.6, '{"created_at":1779026084456631081,"message_id":"collector:north_india-1779026084456624697-25","message_type":"weather.packet","payload":{"city":"Delhi","continent":"Asia","country":"India","humidity":26.0,"region":"north_india","temperature":37.0,"timestamp":1779026084380,"wind_speed":13.6},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Asia', 'India', 'north_india', 'Delhi', 1, 37, 37, 37, 26, 13.6);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026084464838166
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026084460833515-25', 'collector:americas', 'Americas', 'USA', 'americas', 'New York', to_timestamp(1779026084381 / 1000.0), to_timestamp(1779026084460838375 / 1000.0), 25.4, 54, 7.9, '{"created_at":1779026084460838375,"message_id":"collector:americas-1779026084460833515-25","message_type":"weather.packet","payload":{"city":"New York","continent":"Americas","country":"USA","humidity":54.0,"region":"americas","temperature":25.4,"timestamp":1779026084381,"wind_speed":7.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Americas', 'USA', 'americas', 'New York', 1, 25.4, 25.4, 25.4, 54, 7.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026084943637698
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026084938828510-25', 'collector:europe', 'Europe', 'Europe', 'europe', 'Paris', to_timestamp(1779026084873 / 1000.0), to_timestamp(1779026084938835574 / 1000.0), 14.3, 76, 9.3, '{"created_at":1779026084938835574,"message_id":"collector:europe-1779026084938828510-25","message_type":"weather.packet","payload":{"city":"Paris","continent":"Europe","country":"Europe","humidity":76.0,"region":"europe","temperature":14.3,"timestamp":1779026084873,"wind_speed":9.3},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Europe', 'Europe', 'europe', 'Paris', 1, 14.3, 14.3, 14.3, 76, 9.3);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026087115962294
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026087110161905-25', 'collector:south_india', 'Asia', 'India', 'south_india', 'Hyderabad', to_timestamp(1779026087093 / 1000.0), to_timestamp(1779026087110169478 / 1000.0), 33.2, 45, 6.2, '{"created_at":1779026087110169478,"message_id":"collector:south_india-1779026087110161905-25","message_type":"weather.packet","payload":{"city":"Hyderabad","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":33.2,"timestamp":1779026087093,"wind_speed":6.2},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Asia', 'India', 'south_india', 'Hyderabad', 1, 33.2, 33.2, 33.2, 45, 6.2);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026089446158037
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026089439834918-26', 'collector:north_india', 'Asia', 'India', 'north_india', 'Mumbai', to_timestamp(1779026089439 / 1000.0), to_timestamp(1779026089439842027 / 1000.0), 30.4, 76, 9, '{"created_at":1779026089439842027,"message_id":"collector:north_india-1779026089439834918-26","message_type":"weather.packet","payload":{"city":"Mumbai","continent":"Asia","country":"India","humidity":76.0,"region":"north_india","temperature":30.4,"timestamp":1779026089439,"wind_speed":9.0},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Asia', 'India', 'north_india', 'Mumbai', 1, 30.4, 30.4, 30.4, 76, 9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026089577146683
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026089572593605-26', 'collector:south_india', 'Asia', 'India', 'south_india', 'Bangalore', to_timestamp(1779026089520 / 1000.0), to_timestamp(1779026089572600759 / 1000.0), 29.5, 45, 10.7, '{"created_at":1779026089572600759,"message_id":"collector:south_india-1779026089572593605-26","message_type":"weather.packet","payload":{"city":"Bangalore","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":29.5,"timestamp":1779026089520,"wind_speed":10.7},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Asia', 'India', 'south_india', 'Bangalore', 1, 29.5, 29.5, 29.5, 45, 10.7);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026089584497713
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026089580696364-26', 'collector:americas', 'Americas', 'USA', 'americas', 'Los Angeles', to_timestamp(1779026089580 / 1000.0), to_timestamp(1779026089580702127 / 1000.0), 16.2, 78, 5.9, '{"created_at":1779026089580702127,"message_id":"collector:americas-1779026089580696364-26","message_type":"weather.packet","payload":{"city":"Los Angeles","continent":"Americas","country":"USA","humidity":78.0,"region":"americas","temperature":16.2,"timestamp":1779026089580,"wind_speed":5.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Americas', 'USA', 'americas', 'Los Angeles', 1, 16.2, 16.2, 16.2, 78, 5.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026089597507913
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026089593480882-27', 'collector:americas', 'Americas', 'USA', 'americas', 'New York', to_timestamp(1779026089593 / 1000.0), to_timestamp(1779026089593487309 / 1000.0), 25.4, 54, 7.9, '{"created_at":1779026089593487309,"message_id":"collector:americas-1779026089593480882-27","message_type":"weather.packet","payload":{"city":"New York","continent":"Americas","country":"USA","humidity":54.0,"region":"americas","temperature":25.4,"timestamp":1779026089593,"wind_speed":7.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Americas', 'USA', 'americas', 'New York', 1, 25.4, 25.4, 25.4, 54, 7.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026089613262612
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026089609328165-26', 'collector:europe', 'Europe', 'Europe', 'europe', 'London', to_timestamp(1779026089606 / 1000.0), to_timestamp(1779026089609332772 / 1000.0), 16.1, 39, 13, '{"created_at":1779026089609332772,"message_id":"collector:europe-1779026089609328165-26","message_type":"weather.packet","payload":{"city":"London","continent":"Europe","country":"Europe","humidity":39.0,"region":"europe","temperature":16.1,"timestamp":1779026089606,"wind_speed":13.0},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Europe', 'Europe', 'europe', 'London', 1, 16.1, 16.1, 16.1, 39, 13);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026089657501684
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026089653648760-27', 'collector:north_india', 'Asia', 'India', 'north_india', 'Delhi', to_timestamp(1779026089585 / 1000.0), to_timestamp(1779026089653654238 / 1000.0), 37, 26, 13.6, '{"created_at":1779026089653654238,"message_id":"collector:north_india-1779026089653648760-27","message_type":"weather.packet","payload":{"city":"Delhi","continent":"Asia","country":"India","humidity":26.0,"region":"north_india","temperature":37.0,"timestamp":1779026089585,"wind_speed":13.6},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Asia', 'India', 'north_india', 'Delhi', 1, 37, 37, 37, 26, 13.6);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026090130191945
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026090122870100-27', 'collector:europe', 'Europe', 'Europe', 'europe', 'Paris', to_timestamp(1779026090115 / 1000.0), to_timestamp(1779026090122879009 / 1000.0), 14.3, 76, 9.3, '{"created_at":1779026090122879009,"message_id":"collector:europe-1779026090122870100-27","message_type":"weather.packet","payload":{"city":"Paris","continent":"Europe","country":"Europe","humidity":76.0,"region":"europe","temperature":14.3,"timestamp":1779026090115,"wind_speed":9.3},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Europe', 'Europe', 'europe', 'Paris', 1, 14.3, 14.3, 14.3, 76, 9.3);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026092372332938
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026092366357592-27', 'collector:south_india', 'Asia', 'India', 'south_india', 'Hyderabad', to_timestamp(1779026092330 / 1000.0), to_timestamp(1779026092366365792 / 1000.0), 33.2, 45, 6.2, '{"created_at":1779026092366365792,"message_id":"collector:south_india-1779026092366357592-27","message_type":"weather.packet","payload":{"city":"Hyderabad","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":33.2,"timestamp":1779026092330,"wind_speed":6.2},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Asia', 'India', 'south_india', 'Hyderabad', 1, 33.2, 33.2, 33.2, 45, 6.2);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026094637135279
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026094631478501-28', 'collector:north_india', 'Asia', 'India', 'north_india', 'Mumbai', to_timestamp(1779026094630 / 1000.0), to_timestamp(1779026094631484964 / 1000.0), 30.4, 76, 9, '{"created_at":1779026094631484964,"message_id":"collector:north_india-1779026094631478501-28","message_type":"weather.packet","payload":{"city":"Mumbai","continent":"Asia","country":"India","humidity":76.0,"region":"north_india","temperature":30.4,"timestamp":1779026094630,"wind_speed":9.0},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Asia', 'India', 'north_india', 'Mumbai', 1, 30.4, 30.4, 30.4, 76, 9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026094758363742
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026094753114579-28', 'collector:south_india', 'Asia', 'India', 'south_india', 'Bangalore', to_timestamp(1779026094715 / 1000.0), to_timestamp(1779026094753119990 / 1000.0), 29.5, 45, 10.7, '{"created_at":1779026094753119990,"message_id":"collector:south_india-1779026094753114579-28","message_type":"weather.packet","payload":{"city":"Bangalore","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":29.5,"timestamp":1779026094715,"wind_speed":10.7},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Asia', 'India', 'south_india', 'Bangalore', 1, 29.5, 29.5, 29.5, 45, 10.7);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026094797895847
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026094793385498-28', 'collector:americas', 'Americas', 'USA', 'americas', 'Los Angeles', to_timestamp(1779026094793 / 1000.0), to_timestamp(1779026094793391947 / 1000.0), 16.2, 78, 5.9, '{"created_at":1779026094793391947,"message_id":"collector:americas-1779026094793385498-28","message_type":"weather.packet","payload":{"city":"Los Angeles","continent":"Americas","country":"USA","humidity":78.0,"region":"americas","temperature":16.2,"timestamp":1779026094793,"wind_speed":5.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Americas', 'USA', 'americas', 'Los Angeles', 1, 16.2, 16.2, 16.2, 78, 5.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026094816204712
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026094811789356-28', 'collector:europe', 'Europe', 'Europe', 'europe', 'London', to_timestamp(1779026094797 / 1000.0), to_timestamp(1779026094811794398 / 1000.0), 16.1, 39, 13, '{"created_at":1779026094811794398,"message_id":"collector:europe-1779026094811789356-28","message_type":"weather.packet","payload":{"city":"London","continent":"Europe","country":"Europe","humidity":39.0,"region":"europe","temperature":16.1,"timestamp":1779026094797,"wind_speed":13.0},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Europe', 'Europe', 'europe', 'London', 1, 16.1, 16.1, 16.1, 39, 13);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026094837073134
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026094833076406-29', 'collector:north_india', 'Asia', 'India', 'north_india', 'Delhi', to_timestamp(1779026094782 / 1000.0), to_timestamp(1779026094833081717 / 1000.0), 37, 26, 13.6, '{"created_at":1779026094833081717,"message_id":"collector:north_india-1779026094833076406-29","message_type":"weather.packet","payload":{"city":"Delhi","continent":"Asia","country":"India","humidity":26.0,"region":"north_india","temperature":37.0,"timestamp":1779026094782,"wind_speed":13.6},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Asia', 'India', 'north_india', 'Delhi', 1, 37, 37, 37, 26, 13.6);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026094899852669
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026094896168444-29', 'collector:americas', 'Americas', 'USA', 'americas', 'New York', to_timestamp(1779026094799 / 1000.0), to_timestamp(1779026094896173726 / 1000.0), 25.4, 54, 7.9, '{"created_at":1779026094896173726,"message_id":"collector:americas-1779026094896168444-29","message_type":"weather.packet","payload":{"city":"New York","continent":"Americas","country":"USA","humidity":54.0,"region":"americas","temperature":25.4,"timestamp":1779026094799,"wind_speed":7.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Americas', 'USA', 'americas', 'New York', 1, 25.4, 25.4, 25.4, 54, 7.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026095637498518
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026095631706527-29', 'collector:europe', 'Europe', 'Europe', 'europe', 'Paris', to_timestamp(1779026095547 / 1000.0), to_timestamp(1779026095631715854 / 1000.0), 14.3, 76, 9.3, '{"created_at":1779026095631715854,"message_id":"collector:europe-1779026095631706527-29","message_type":"weather.packet","payload":{"city":"Paris","continent":"Europe","country":"Europe","humidity":76.0,"region":"europe","temperature":14.3,"timestamp":1779026095547,"wind_speed":9.3},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Europe', 'Europe', 'europe', 'Paris', 1, 14.3, 14.3, 14.3, 76, 9.3);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026097630887258
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026097624982269-29', 'collector:south_india', 'Asia', 'India', 'south_india', 'Hyderabad', to_timestamp(1779026097580 / 1000.0), to_timestamp(1779026097624989538 / 1000.0), 33.2, 45, 6.2, '{"created_at":1779026097624989538,"message_id":"collector:south_india-1779026097624982269-29","message_type":"weather.packet","payload":{"city":"Hyderabad","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":33.2,"timestamp":1779026097580,"wind_speed":6.2},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Asia', 'India', 'south_india', 'Hyderabad', 1, 33.2, 33.2, 33.2, 45, 6.2);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026099866659261
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026099859690207-30', 'collector:north_india', 'Asia', 'India', 'north_india', 'Mumbai', to_timestamp(1779026099859 / 1000.0), to_timestamp(1779026099859698647 / 1000.0), 30.4, 76, 9, '{"created_at":1779026099859698647,"message_id":"collector:north_india-1779026099859690207-30","message_type":"weather.packet","payload":{"city":"Mumbai","continent":"Asia","country":"India","humidity":76.0,"region":"north_india","temperature":30.4,"timestamp":1779026099859,"wind_speed":9.0},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026040000 / 1000.0), 'Asia', 'India', 'north_india', 'Mumbai', 1, 30.4, 30.4, 30.4, 76, 9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026100137102749
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026100129165193-30', 'collector:americas', 'Americas', 'USA', 'americas', 'Los Angeles', to_timestamp(1779026100128 / 1000.0), to_timestamp(1779026100129172837 / 1000.0), 16.2, 78, 5.9, '{"created_at":1779026100129172837,"message_id":"collector:americas-1779026100129165193-30","message_type":"weather.packet","payload":{"city":"Los Angeles","continent":"Americas","country":"USA","humidity":78.0,"region":"americas","temperature":16.2,"timestamp":1779026100128,"wind_speed":5.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING,
  ('collector:americas-1779026100129521521-31', 'collector:americas', 'Americas', 'USA', 'americas', 'New York', to_timestamp(1779026100128 / 1000.0), to_timestamp(1779026100129526388 / 1000.0), 25.4, 54, 7.9, '{"created_at":1779026100129526388,"message_id":"collector:americas-1779026100129521521-31","message_type":"weather.packet","payload":{"city":"New York","continent":"Americas","country":"USA","humidity":54.0,"region":"americas","temperature":25.4,"timestamp":1779026100128,"wind_speed":7.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Americas', 'USA', 'americas', 'Los Angeles', 1, 16.2, 16.2, 16.2, 78, 5.9),
  (to_timestamp(1779026100000 / 1000.0), 'Americas', 'USA', 'americas', 'New York', 1, 25.4, 25.4, 25.4, 54, 7.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026100141291800
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026100135378375-30', 'collector:south_india', 'Asia', 'India', 'south_india', 'Bangalore', to_timestamp(1779026100128 / 1000.0), to_timestamp(1779026100135385144 / 1000.0), 29.5, 45, 10.7, '{"created_at":1779026100135385144,"message_id":"collector:south_india-1779026100135378375-30","message_type":"weather.packet","payload":{"city":"Bangalore","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":29.5,"timestamp":1779026100128,"wind_speed":10.7},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Asia', 'India', 'south_india', 'Bangalore', 1, 29.5, 29.5, 29.5, 45, 10.7);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026100182050003
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026100177632102-31', 'collector:north_india', 'Asia', 'India', 'north_india', 'Delhi', to_timestamp(1779026100127 / 1000.0), to_timestamp(1779026100177640187 / 1000.0), 37, 26, 13.6, '{"created_at":1779026100177640187,"message_id":"collector:north_india-1779026100177632102-31","message_type":"weather.packet","payload":{"city":"Delhi","continent":"Asia","country":"India","humidity":26.0,"region":"north_india","temperature":37.0,"timestamp":1779026100127,"wind_speed":13.6},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Asia', 'India', 'north_india', 'Delhi', 1, 37, 37, 37, 26, 13.6);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026100217661242
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026100213894865-30', 'collector:europe', 'Europe', 'Europe', 'europe', 'London', to_timestamp(1779026100127 / 1000.0), to_timestamp(1779026100213903124 / 1000.0), 16.1, 39, 13, '{"created_at":1779026100213903124,"message_id":"collector:europe-1779026100213894865-30","message_type":"weather.packet","payload":{"city":"London","continent":"Europe","country":"Europe","humidity":39.0,"region":"europe","temperature":16.1,"timestamp":1779026100127,"wind_speed":13.0},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Europe', 'Europe', 'europe', 'London', 1, 16.1, 16.1, 16.1, 39, 13);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026100838141541
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026100831097204-31', 'collector:europe', 'Europe', 'Europe', 'europe', 'Paris', to_timestamp(1779026100796 / 1000.0), to_timestamp(1779026100831104325 / 1000.0), 14.3, 76, 9.3, '{"created_at":1779026100831104325,"message_id":"collector:europe-1779026100831097204-31","message_type":"weather.packet","payload":{"city":"Paris","continent":"Europe","country":"Europe","humidity":76.0,"region":"europe","temperature":14.3,"timestamp":1779026100796,"wind_speed":9.3},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Europe', 'Europe', 'europe', 'Paris', 1, 14.3, 14.3, 14.3, 76, 9.3);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026102865146761
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026102859126460-31', 'collector:south_india', 'Asia', 'India', 'south_india', 'Hyderabad', to_timestamp(1779026102797 / 1000.0), to_timestamp(1779026102859134988 / 1000.0), 33.2, 45, 6.2, '{"created_at":1779026102859134988,"message_id":"collector:south_india-1779026102859126460-31","message_type":"weather.packet","payload":{"city":"Hyderabad","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":33.2,"timestamp":1779026102797,"wind_speed":6.2},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Asia', 'India', 'south_india', 'Hyderabad', 1, 33.2, 33.2, 33.2, 45, 6.2);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026105201271805
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026105196793072-32', 'collector:north_india', 'Asia', 'India', 'north_india', 'Mumbai', to_timestamp(1779026105134 / 1000.0), to_timestamp(1779026105196799271 / 1000.0), 30.4, 76, 9, '{"created_at":1779026105196799271,"message_id":"collector:north_india-1779026105196793072-32","message_type":"weather.packet","payload":{"city":"Mumbai","continent":"Asia","country":"India","humidity":76.0,"region":"north_india","temperature":30.4,"timestamp":1779026105134,"wind_speed":9.0},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Asia', 'India', 'north_india', 'Mumbai', 1, 30.4, 30.4, 30.4, 76, 9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026105376088590
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026105368882956-32', 'collector:americas', 'Americas', 'USA', 'americas', 'Los Angeles', to_timestamp(1779026105368 / 1000.0), to_timestamp(1779026105368887404 / 1000.0), 16.2, 78, 5.9, '{"created_at":1779026105368887404,"message_id":"collector:americas-1779026105368882956-32","message_type":"weather.packet","payload":{"city":"Los Angeles","continent":"Americas","country":"USA","humidity":78.0,"region":"americas","temperature":16.2,"timestamp":1779026105368,"wind_speed":5.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Americas', 'USA', 'americas', 'Los Angeles', 1, 16.2, 16.2, 16.2, 78, 5.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026105376846465
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026105369122696-33', 'collector:americas', 'Americas', 'USA', 'americas', 'New York', to_timestamp(1779026105368 / 1000.0), to_timestamp(1779026105369125736 / 1000.0), 25.4, 54, 7.9, '{"created_at":1779026105369125736,"message_id":"collector:americas-1779026105369122696-33","message_type":"weather.packet","payload":{"city":"New York","continent":"Americas","country":"USA","humidity":54.0,"region":"americas","temperature":25.4,"timestamp":1779026105368,"wind_speed":7.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Americas', 'USA', 'americas', 'New York', 1, 25.4, 25.4, 25.4, 54, 7.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026105379081316
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026105374078375-32', 'collector:europe', 'Europe', 'Europe', 'europe', 'London', to_timestamp(1779026105368 / 1000.0), to_timestamp(1779026105374082940 / 1000.0), 16.1, 39, 13, '{"created_at":1779026105374082940,"message_id":"collector:europe-1779026105374078375-32","message_type":"weather.packet","payload":{"city":"London","continent":"Europe","country":"Europe","humidity":39.0,"region":"europe","temperature":16.1,"timestamp":1779026105368,"wind_speed":13.0},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Europe', 'Europe', 'europe', 'London', 1, 16.1, 16.1, 16.1, 39, 13);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026105409896323
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026105406040041-33', 'collector:north_india', 'Asia', 'India', 'north_india', 'Delhi', to_timestamp(1779026105368 / 1000.0), to_timestamp(1779026105406045540 / 1000.0), 37, 26, 13.6, '{"created_at":1779026105406045540,"message_id":"collector:north_india-1779026105406040041-33","message_type":"weather.packet","payload":{"city":"Delhi","continent":"Asia","country":"India","humidity":26.0,"region":"north_india","temperature":37.0,"timestamp":1779026105368,"wind_speed":13.6},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Asia', 'India', 'north_india', 'Delhi', 1, 37, 37, 37, 26, 13.6);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026105420863504
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026105417194351-32', 'collector:south_india', 'Asia', 'India', 'south_india', 'Bangalore', to_timestamp(1779026105367 / 1000.0), to_timestamp(1779026105417199228 / 1000.0), 29.5, 45, 10.7, '{"created_at":1779026105417199228,"message_id":"collector:south_india-1779026105417194351-32","message_type":"weather.packet","payload":{"city":"Bangalore","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":29.5,"timestamp":1779026105367,"wind_speed":10.7},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Asia', 'India', 'south_india', 'Bangalore', 1, 29.5, 29.5, 29.5, 45, 10.7);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026106107545150
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026106100919834-33', 'collector:europe', 'Europe', 'Europe', 'europe', 'Paris', to_timestamp(1779026106033 / 1000.0), to_timestamp(1779026106100929971 / 1000.0), 14.3, 76, 9.3, '{"created_at":1779026106100929971,"message_id":"collector:europe-1779026106100919834-33","message_type":"weather.packet","payload":{"city":"Paris","continent":"Europe","country":"Europe","humidity":76.0,"region":"europe","temperature":14.3,"timestamp":1779026106033,"wind_speed":9.3},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Europe', 'Europe', 'europe', 'Paris', 1, 14.3, 14.3, 14.3, 76, 9.3);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026108077880094
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026108072222890-33', 'collector:south_india', 'Asia', 'India', 'south_india', 'Hyderabad', to_timestamp(1779026108030 / 1000.0), to_timestamp(1779026108072229958 / 1000.0), 33.2, 45, 6.2, '{"created_at":1779026108072229958,"message_id":"collector:south_india-1779026108072222890-33","message_type":"weather.packet","payload":{"city":"Hyderabad","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":33.2,"timestamp":1779026108030,"wind_speed":6.2},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Asia', 'India', 'south_india', 'Hyderabad', 1, 33.2, 33.2, 33.2, 45, 6.2);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026110432227007
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026110427797637-34', 'collector:north_india', 'Asia', 'India', 'north_india', 'Mumbai', to_timestamp(1779026110359 / 1000.0), to_timestamp(1779026110427804517 / 1000.0), 30.4, 76, 9, '{"created_at":1779026110427804517,"message_id":"collector:north_india-1779026110427797637-34","message_type":"weather.packet","payload":{"city":"Mumbai","continent":"Asia","country":"India","humidity":76.0,"region":"north_india","temperature":30.4,"timestamp":1779026110359,"wind_speed":9.0},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Asia', 'India', 'north_india', 'Mumbai', 1, 30.4, 30.4, 30.4, 76, 9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026110585427792
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026110581778406-34', 'collector:americas', 'Americas', 'USA', 'americas', 'Los Angeles', to_timestamp(1779026110581 / 1000.0), to_timestamp(1779026110581782709 / 1000.0), 16.2, 78, 5.9, '{"created_at":1779026110581782709,"message_id":"collector:americas-1779026110581778406-34","message_type":"weather.packet","payload":{"city":"Los Angeles","continent":"Americas","country":"USA","humidity":78.0,"region":"americas","temperature":16.2,"timestamp":1779026110581,"wind_speed":5.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Americas', 'USA', 'americas', 'Los Angeles', 1, 16.2, 16.2, 16.2, 78, 5.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026110585964959
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026110582175489-35', 'collector:americas', 'Americas', 'USA', 'americas', 'New York', to_timestamp(1779026110581 / 1000.0), to_timestamp(1779026110582179686 / 1000.0), 25.4, 54, 7.9, '{"created_at":1779026110582179686,"message_id":"collector:americas-1779026110582175489-35","message_type":"weather.packet","payload":{"city":"New York","continent":"Americas","country":"USA","humidity":54.0,"region":"americas","temperature":25.4,"timestamp":1779026110581,"wind_speed":7.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Americas', 'USA', 'americas', 'New York', 1, 25.4, 25.4, 25.4, 54, 7.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026110607519921
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026110603858598-34', 'collector:europe', 'Europe', 'Europe', 'europe', 'London', to_timestamp(1779026110581 / 1000.0), to_timestamp(1779026110603863942 / 1000.0), 16.1, 39, 13, '{"created_at":1779026110603863942,"message_id":"collector:europe-1779026110603858598-34","message_type":"weather.packet","payload":{"city":"London","continent":"Europe","country":"Europe","humidity":39.0,"region":"europe","temperature":16.1,"timestamp":1779026110581,"wind_speed":13.0},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Europe', 'Europe', 'europe', 'London', 1, 16.1, 16.1, 16.1, 39, 13);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026110613300409
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026110609772907-34', 'collector:south_india', 'Asia', 'India', 'south_india', 'Bangalore', to_timestamp(1779026110581 / 1000.0), to_timestamp(1779026110609778402 / 1000.0), 29.5, 45, 10.7, '{"created_at":1779026110609778402,"message_id":"collector:south_india-1779026110609772907-34","message_type":"weather.packet","payload":{"city":"Bangalore","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":29.5,"timestamp":1779026110581,"wind_speed":10.7},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Asia', 'India', 'south_india', 'Bangalore', 1, 29.5, 29.5, 29.5, 45, 10.7);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026110641277259
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026110637530804-35', 'collector:north_india', 'Asia', 'India', 'north_india', 'Delhi', to_timestamp(1779026110581 / 1000.0), to_timestamp(1779026110637535962 / 1000.0), 37, 26, 13.6, '{"created_at":1779026110637535962,"message_id":"collector:north_india-1779026110637530804-35","message_type":"weather.packet","payload":{"city":"Delhi","continent":"Asia","country":"India","humidity":26.0,"region":"north_india","temperature":37.0,"timestamp":1779026110581,"wind_speed":13.6},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Asia', 'India', 'north_india', 'Delhi', 1, 37, 37, 37, 26, 13.6);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026109077350700
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026109071785443-35', 'collector:europe', 'Europe', 'Europe', 'europe', 'Paris', to_timestamp(1779026111249 / 1000.0), to_timestamp(1779026109071792314 / 1000.0), 14.3, 76, 9.3, '{"created_at":1779026109071792314,"message_id":"collector:europe-1779026109071785443-35","message_type":"weather.packet","payload":{"city":"Paris","continent":"Europe","country":"Europe","humidity":76.0,"region":"europe","temperature":14.3,"timestamp":1779026111249,"wind_speed":9.3},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Europe', 'Europe', 'europe', 'Paris', 1, 14.3, 14.3, 14.3, 76, 9.3);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026111158001530
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026111151558961-35', 'collector:south_india', 'Asia', 'India', 'south_india', 'Hyderabad', to_timestamp(1779026111087 / 1000.0), to_timestamp(1779026111151566759 / 1000.0), 33.2, 45, 6.2, '{"created_at":1779026111151566759,"message_id":"collector:south_india-1779026111151558961-35","message_type":"weather.packet","payload":{"city":"Hyderabad","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":33.2,"timestamp":1779026111087,"wind_speed":6.2},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Asia', 'India', 'south_india', 'Hyderabad', 1, 33.2, 33.2, 33.2, 45, 6.2);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026113336934479
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026113328051685-36', 'collector:north_india', 'Asia', 'India', 'north_india', 'Mumbai', to_timestamp(1779026113327 / 1000.0), to_timestamp(1779026113328058929 / 1000.0), 30.4, 76, 9, '{"created_at":1779026113328058929,"message_id":"collector:north_india-1779026113328051685-36","message_type":"weather.packet","payload":{"city":"Mumbai","continent":"Asia","country":"India","humidity":76.0,"region":"north_india","temperature":30.4,"timestamp":1779026113327,"wind_speed":9.0},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Asia', 'India', 'north_india', 'Mumbai', 1, 30.4, 30.4, 30.4, 76, 9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026113530199983
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026113526579563-36', 'collector:americas', 'Americas', 'USA', 'americas', 'New York', to_timestamp(1779026113526 / 1000.0), to_timestamp(1779026113526584339 / 1000.0), 25.4, 54, 7.9, '{"created_at":1779026113526584339,"message_id":"collector:americas-1779026113526579563-36","message_type":"weather.packet","payload":{"city":"New York","continent":"Americas","country":"USA","humidity":54.0,"region":"americas","temperature":25.4,"timestamp":1779026113526,"wind_speed":7.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Americas', 'USA', 'americas', 'New York', 1, 25.4, 25.4, 25.4, 54, 7.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026113543941324
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026113540017990-36', 'collector:europe', 'Europe', 'Europe', 'europe', 'London', to_timestamp(1779026113539 / 1000.0), to_timestamp(1779026113540021841 / 1000.0), 16.1, 39, 13, '{"created_at":1779026113540021841,"message_id":"collector:europe-1779026113540017990-36","message_type":"weather.packet","payload":{"city":"London","continent":"Europe","country":"Europe","humidity":39.0,"region":"europe","temperature":16.1,"timestamp":1779026113539,"wind_speed":13.0},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Europe', 'Europe', 'europe', 'London', 1, 16.1, 16.1, 16.1, 39, 13);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026113545564182
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026113541903872-37', 'collector:north_india', 'Asia', 'India', 'north_india', 'Delhi', to_timestamp(1779026113518 / 1000.0), to_timestamp(1779026113541908620 / 1000.0), 37, 26, 13.6, '{"created_at":1779026113541908620,"message_id":"collector:north_india-1779026113541903872-37","message_type":"weather.packet","payload":{"city":"Delhi","continent":"Asia","country":"India","humidity":26.0,"region":"north_india","temperature":37.0,"timestamp":1779026113518,"wind_speed":13.6},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Asia', 'India', 'north_india', 'Delhi', 1, 37, 37, 37, 26, 13.6);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026113623515252
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026113619659154-36', 'collector:south_india', 'Asia', 'India', 'south_india', 'Bangalore', to_timestamp(1779026113528 / 1000.0), to_timestamp(1779026113619664588 / 1000.0), 29.5, 45, 10.7, '{"created_at":1779026113619664588,"message_id":"collector:south_india-1779026113619659154-36","message_type":"weather.packet","payload":{"city":"Bangalore","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":29.5,"timestamp":1779026113528,"wind_speed":10.7},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Asia', 'India', 'south_india', 'Bangalore', 1, 29.5, 29.5, 29.5, 45, 10.7);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026113630717197
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026113627079501-37', 'collector:americas', 'Americas', 'USA', 'americas', 'Los Angeles', to_timestamp(1779026113528 / 1000.0), to_timestamp(1779026113627084545 / 1000.0), 16.2, 78, 5.9, '{"created_at":1779026113627084545,"message_id":"collector:americas-1779026113627079501-37","message_type":"weather.packet","payload":{"city":"Los Angeles","continent":"Americas","country":"USA","humidity":78.0,"region":"americas","temperature":16.2,"timestamp":1779026113528,"wind_speed":5.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Americas', 'USA', 'americas', 'Los Angeles', 1, 16.2, 16.2, 16.2, 78, 5.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026114264174501
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026114258055359-37', 'collector:europe', 'Europe', 'Europe', 'europe', 'Paris', to_timestamp(1779026114196 / 1000.0), to_timestamp(1779026114258064853 / 1000.0), 14.3, 76, 9.3, '{"created_at":1779026114258064853,"message_id":"collector:europe-1779026114258055359-37","message_type":"weather.packet","payload":{"city":"Paris","continent":"Europe","country":"Europe","humidity":76.0,"region":"europe","temperature":14.3,"timestamp":1779026114196,"wind_speed":9.3},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Europe', 'Europe', 'europe', 'Paris', 1, 14.3, 14.3, 14.3, 76, 9.3);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026116352915540
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026116345433862-37', 'collector:south_india', 'Asia', 'India', 'south_india', 'Hyderabad', to_timestamp(1779026116326 / 1000.0), to_timestamp(1779026116345441504 / 1000.0), 33.2, 45, 6.2, '{"created_at":1779026116345441504,"message_id":"collector:south_india-1779026116345433862-37","message_type":"weather.packet","payload":{"city":"Hyderabad","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":33.2,"timestamp":1779026116326,"wind_speed":6.2},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Asia', 'India', 'south_india', 'Hyderabad', 1, 33.2, 33.2, 33.2, 45, 6.2);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026118535682034
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026118527348306-38', 'collector:north_india', 'Asia', 'India', 'north_india', 'Mumbai', to_timestamp(1779026118526 / 1000.0), to_timestamp(1779026118527354827 / 1000.0), 30.4, 76, 9, '{"created_at":1779026118527354827,"message_id":"collector:north_india-1779026118527348306-38","message_type":"weather.packet","payload":{"city":"Mumbai","continent":"Asia","country":"India","humidity":76.0,"region":"north_india","temperature":30.4,"timestamp":1779026118526,"wind_speed":9.0},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Asia', 'India', 'north_india', 'Mumbai', 1, 30.4, 30.4, 30.4, 76, 9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026118733527386
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026118729900727-38', 'collector:americas', 'Americas', 'USA', 'americas', 'Los Angeles', to_timestamp(1779026118729 / 1000.0), to_timestamp(1779026118729906020 / 1000.0), 16.2, 78, 5.9, '{"created_at":1779026118729906020,"message_id":"collector:americas-1779026118729900727-38","message_type":"weather.packet","payload":{"city":"Los Angeles","continent":"Americas","country":"USA","humidity":78.0,"region":"americas","temperature":16.2,"timestamp":1779026118729,"wind_speed":5.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Americas', 'USA', 'americas', 'Los Angeles', 1, 16.2, 16.2, 16.2, 78, 5.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026118735694247
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026118732002251-39', 'collector:north_india', 'Asia', 'India', 'north_india', 'Delhi', to_timestamp(1779026118716 / 1000.0), to_timestamp(1779026118732006693 / 1000.0), 37, 26, 13.6, '{"created_at":1779026118732006693,"message_id":"collector:north_india-1779026118732002251-39","message_type":"weather.packet","payload":{"city":"Delhi","continent":"Asia","country":"India","humidity":26.0,"region":"north_india","temperature":37.0,"timestamp":1779026118716,"wind_speed":13.6},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Asia', 'India', 'north_india', 'Delhi', 1, 37, 37, 37, 26, 13.6);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026118774008285
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026118770109681-38', 'collector:south_india', 'Asia', 'India', 'south_india', 'Bangalore', to_timestamp(1779026118728 / 1000.0), to_timestamp(1779026118770117245 / 1000.0), 29.5, 45, 10.7, '{"created_at":1779026118770117245,"message_id":"collector:south_india-1779026118770109681-38","message_type":"weather.packet","payload":{"city":"Bangalore","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":29.5,"timestamp":1779026118728,"wind_speed":10.7},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Asia', 'India', 'south_india', 'Bangalore', 1, 29.5, 29.5, 29.5, 45, 10.7);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026118788597618
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026118784846360-38', 'collector:europe', 'Europe', 'Europe', 'europe', 'London', to_timestamp(1779026118778 / 1000.0), to_timestamp(1779026118784851186 / 1000.0), 16.1, 39, 13, '{"created_at":1779026118784851186,"message_id":"collector:europe-1779026118784846360-38","message_type":"weather.packet","payload":{"city":"London","continent":"Europe","country":"Europe","humidity":39.0,"region":"europe","temperature":16.1,"timestamp":1779026118778,"wind_speed":13.0},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Europe', 'Europe', 'europe', 'London', 1, 16.1, 16.1, 16.1, 39, 13);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026118834430569
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026118830737739-39', 'collector:americas', 'Americas', 'USA', 'americas', 'New York', to_timestamp(1779026118737 / 1000.0), to_timestamp(1779026118830742963 / 1000.0), 25.4, 54, 7.9, '{"created_at":1779026118830742963,"message_id":"collector:americas-1779026118830737739-39","message_type":"weather.packet","payload":{"city":"New York","continent":"Americas","country":"USA","humidity":54.0,"region":"americas","temperature":25.4,"timestamp":1779026118737,"wind_speed":7.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Americas', 'USA', 'americas', 'New York', 1, 25.4, 25.4, 25.4, 54, 7.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026119424286709
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026119412215285-39', 'collector:europe', 'Europe', 'Europe', 'europe', 'Paris', to_timestamp(1779026119411 / 1000.0), to_timestamp(1779026119412222917 / 1000.0), 14.3, 76, 9.3, '{"created_at":1779026119412222917,"message_id":"collector:europe-1779026119412215285-39","message_type":"weather.packet","payload":{"city":"Paris","continent":"Europe","country":"Europe","humidity":76.0,"region":"europe","temperature":14.3,"timestamp":1779026119411,"wind_speed":9.3},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Europe', 'Europe', 'europe', 'Paris', 1, 14.3, 14.3, 14.3, 76, 9.3);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026121701522191
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026121696150897-39', 'collector:south_india', 'Asia', 'India', 'south_india', 'Hyderabad', to_timestamp(1779026121673 / 1000.0), to_timestamp(1779026121696158105 / 1000.0), 33.2, 45, 6.2, '{"created_at":1779026121696158105,"message_id":"collector:south_india-1779026121696150897-39","message_type":"weather.packet","payload":{"city":"Hyderabad","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":33.2,"timestamp":1779026121673,"wind_speed":6.2},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Asia', 'India', 'south_india', 'Hyderabad', 1, 33.2, 33.2, 33.2, 45, 6.2);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026123738569930
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026123729800559-40', 'collector:north_india', 'Asia', 'India', 'north_india', 'Mumbai', to_timestamp(1779026123729 / 1000.0), to_timestamp(1779026123729806515 / 1000.0), 30.4, 76, 9, '{"created_at":1779026123729806515,"message_id":"collector:north_india-1779026123729800559-40","message_type":"weather.packet","payload":{"city":"Mumbai","continent":"Asia","country":"India","humidity":76.0,"region":"north_india","temperature":30.4,"timestamp":1779026123729,"wind_speed":9.0},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Asia', 'India', 'north_india', 'Mumbai', 1, 30.4, 30.4, 30.4, 76, 9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026123936159689
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026123932544798-41', 'collector:north_india', 'Asia', 'India', 'north_india', 'Delhi', to_timestamp(1779026123910 / 1000.0), to_timestamp(1779026123932550364 / 1000.0), 37, 26, 13.6, '{"created_at":1779026123932550364,"message_id":"collector:north_india-1779026123932544798-41","message_type":"weather.packet","payload":{"city":"Delhi","continent":"Asia","country":"India","humidity":26.0,"region":"north_india","temperature":37.0,"timestamp":1779026123910,"wind_speed":13.6},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Asia', 'India', 'north_india', 'Delhi', 1, 37, 37, 37, 26, 13.6);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026123937691579
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026123934352638-40', 'collector:americas', 'Americas', 'USA', 'americas', 'Los Angeles', to_timestamp(1779026123934 / 1000.0), to_timestamp(1779026123934358008 / 1000.0), 16.2, 78, 5.9, '{"created_at":1779026123934358008,"message_id":"collector:americas-1779026123934352638-40","message_type":"weather.packet","payload":{"city":"Los Angeles","continent":"Americas","country":"USA","humidity":78.0,"region":"americas","temperature":16.2,"timestamp":1779026123934,"wind_speed":5.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Americas', 'USA', 'americas', 'Los Angeles', 1, 16.2, 16.2, 16.2, 78, 5.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026123997927538
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026123994289713-40', 'collector:europe', 'Europe', 'Europe', 'europe', 'London', to_timestamp(1779026123972 / 1000.0), to_timestamp(1779026123994294719 / 1000.0), 16.1, 39, 13, '{"created_at":1779026123994294719,"message_id":"collector:europe-1779026123994289713-40","message_type":"weather.packet","payload":{"city":"London","continent":"Europe","country":"Europe","humidity":39.0,"region":"europe","temperature":16.1,"timestamp":1779026123972,"wind_speed":13.0},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Europe', 'Europe', 'europe', 'London', 1, 16.1, 16.1, 16.1, 39, 13);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026124010039515
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026124006524762-40', 'collector:south_india', 'Asia', 'India', 'south_india', 'Bangalore', to_timestamp(1779026123946 / 1000.0), to_timestamp(1779026124006529706 / 1000.0), 29.5, 45, 10.7, '{"created_at":1779026124006529706,"message_id":"collector:south_india-1779026124006524762-40","message_type":"weather.packet","payload":{"city":"Bangalore","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":29.5,"timestamp":1779026123946,"wind_speed":10.7},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Asia', 'India', 'south_india', 'Bangalore', 1, 29.5, 29.5, 29.5, 45, 10.7);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026124038566459
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026124034822700-41', 'collector:americas', 'Americas', 'USA', 'americas', 'New York', to_timestamp(1779026123999 / 1000.0), to_timestamp(1779026124034827818 / 1000.0), 25.4, 54, 7.9, '{"created_at":1779026124034827818,"message_id":"collector:americas-1779026124034822700-41","message_type":"weather.packet","payload":{"city":"New York","continent":"Americas","country":"USA","humidity":54.0,"region":"americas","temperature":25.4,"timestamp":1779026123999,"wind_speed":7.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Americas', 'USA', 'americas', 'New York', 1, 25.4, 25.4, 25.4, 54, 7.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026124730650864
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026124723834871-41', 'collector:europe', 'Europe', 'Europe', 'europe', 'Paris', to_timestamp(1779026124671 / 1000.0), to_timestamp(1779026124723843685 / 1000.0), 14.3, 76, 9.3, '{"created_at":1779026124723843685,"message_id":"collector:europe-1779026124723834871-41","message_type":"weather.packet","payload":{"city":"Paris","continent":"Europe","country":"Europe","humidity":76.0,"region":"europe","temperature":14.3,"timestamp":1779026124671,"wind_speed":9.3},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Europe', 'Europe', 'europe', 'Paris', 1, 14.3, 14.3, 14.3, 76, 9.3);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026126947846330
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026126941120600-41', 'collector:south_india', 'Asia', 'India', 'south_india', 'Hyderabad', to_timestamp(1779026126890 / 1000.0), to_timestamp(1779026126941128879 / 1000.0), 33.2, 45, 6.2, '{"created_at":1779026126941128879,"message_id":"collector:south_india-1779026126941120600-41","message_type":"weather.packet","payload":{"city":"Hyderabad","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":33.2,"timestamp":1779026126890,"wind_speed":6.2},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Asia', 'India', 'south_india', 'Hyderabad', 1, 33.2, 33.2, 33.2, 45, 6.2);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026128921092869
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026128915079777-42', 'collector:north_india', 'Asia', 'India', 'north_india', 'Mumbai', to_timestamp(1779026128914 / 1000.0), to_timestamp(1779026128915086015 / 1000.0), 30.4, 76, 9, '{"created_at":1779026128915086015,"message_id":"collector:north_india-1779026128915079777-42","message_type":"weather.packet","payload":{"city":"Mumbai","continent":"Asia","country":"India","humidity":76.0,"region":"north_india","temperature":30.4,"timestamp":1779026128914,"wind_speed":9.0},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Asia', 'India', 'north_india', 'Mumbai', 1, 30.4, 30.4, 30.4, 76, 9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026129121433904
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026129115829188-43', 'collector:north_india', 'Asia', 'India', 'north_india', 'Delhi', to_timestamp(1779026129088 / 1000.0), to_timestamp(1779026129115836024 / 1000.0), 37, 26, 13.6, '{"created_at":1779026129115836024,"message_id":"collector:north_india-1779026129115829188-43","message_type":"weather.packet","payload":{"city":"Delhi","continent":"Asia","country":"India","humidity":26.0,"region":"north_india","temperature":37.0,"timestamp":1779026129088,"wind_speed":13.6},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Asia', 'India', 'north_india', 'Delhi', 1, 37, 37, 37, 26, 13.6);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026129122485673
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026129116540861-42', 'collector:americas', 'Americas', 'USA', 'americas', 'Los Angeles', to_timestamp(1779026129116 / 1000.0), to_timestamp(1779026129116547149 / 1000.0), 16.2, 78, 5.9, '{"created_at":1779026129116547149,"message_id":"collector:americas-1779026129116540861-42","message_type":"weather.packet","payload":{"city":"Los Angeles","continent":"Americas","country":"USA","humidity":78.0,"region":"americas","temperature":16.2,"timestamp":1779026129116,"wind_speed":5.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Americas', 'USA', 'americas', 'Los Angeles', 1, 16.2, 16.2, 16.2, 78, 5.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026129199328496
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026129195458305-42', 'collector:south_india', 'Asia', 'India', 'south_india', 'Bangalore', to_timestamp(1779026129125 / 1000.0), to_timestamp(1779026129195463252 / 1000.0), 29.5, 45, 10.7, '{"created_at":1779026129195463252,"message_id":"collector:south_india-1779026129195458305-42","message_type":"weather.packet","payload":{"city":"Bangalore","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":29.5,"timestamp":1779026129125,"wind_speed":10.7},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Asia', 'India', 'south_india', 'Bangalore', 1, 29.5, 29.5, 29.5, 45, 10.7);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026129215310357
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026129211789884-42', 'collector:europe', 'Europe', 'Europe', 'europe', 'London', to_timestamp(1779026129151 / 1000.0), to_timestamp(1779026129211794826 / 1000.0), 16.1, 39, 13, '{"created_at":1779026129211794826,"message_id":"collector:europe-1779026129211789884-42","message_type":"weather.packet","payload":{"city":"London","continent":"Europe","country":"Europe","humidity":39.0,"region":"europe","temperature":16.1,"timestamp":1779026129151,"wind_speed":13.0},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Europe', 'Europe', 'europe', 'London', 1, 16.1, 16.1, 16.1, 39, 13);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026129220739957
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026129217285915-43', 'collector:americas', 'Americas', 'USA', 'americas', 'New York', to_timestamp(1779026129190 / 1000.0), to_timestamp(1779026129217290571 / 1000.0), 25.4, 54, 7.9, '{"created_at":1779026129217290571,"message_id":"collector:americas-1779026129217285915-43","message_type":"weather.packet","payload":{"city":"New York","continent":"Americas","country":"USA","humidity":54.0,"region":"americas","temperature":25.4,"timestamp":1779026129190,"wind_speed":7.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Americas', 'USA', 'americas', 'New York', 1, 25.4, 25.4, 25.4, 54, 7.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026129962853809
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026129957127930-43', 'collector:europe', 'Europe', 'Europe', 'europe', 'Paris', to_timestamp(1779026129920 / 1000.0), to_timestamp(1779026129957134609 / 1000.0), 14.3, 76, 9.3, '{"created_at":1779026129957134609,"message_id":"collector:europe-1779026129957127930-43","message_type":"weather.packet","payload":{"city":"Paris","continent":"Europe","country":"Europe","humidity":76.0,"region":"europe","temperature":14.3,"timestamp":1779026129920,"wind_speed":9.3},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Europe', 'Europe', 'europe', 'Paris', 1, 14.3, 14.3, 14.3, 76, 9.3);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026132216587553
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026132211209667-43', 'collector:south_india', 'Asia', 'India', 'south_india', 'Hyderabad', to_timestamp(1779026132139 / 1000.0), to_timestamp(1779026132211217913 / 1000.0), 33.2, 45, 6.2, '{"created_at":1779026132211217913,"message_id":"collector:south_india-1779026132211209667-43","message_type":"weather.packet","payload":{"city":"Hyderabad","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":33.2,"timestamp":1779026132139,"wind_speed":6.2},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Asia', 'India', 'south_india', 'Hyderabad', 1, 33.2, 33.2, 33.2, 45, 6.2);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026134139103632
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026134133162817-44', 'collector:north_india', 'Asia', 'India', 'north_india', 'Mumbai', to_timestamp(1779026134132 / 1000.0), to_timestamp(1779026134133169494 / 1000.0), 30.4, 76, 9, '{"created_at":1779026134133169494,"message_id":"collector:north_india-1779026134133162817-44","message_type":"weather.packet","payload":{"city":"Mumbai","continent":"Asia","country":"India","humidity":76.0,"region":"north_india","temperature":30.4,"timestamp":1779026134132,"wind_speed":9.0},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Asia', 'India', 'north_india', 'Mumbai', 1, 30.4, 30.4, 30.4, 76, 9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026134321364167
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026134316625750-44', 'collector:americas', 'Americas', 'USA', 'americas', 'Los Angeles', to_timestamp(1779026134316 / 1000.0), to_timestamp(1779026134316631482 / 1000.0), 16.2, 78, 5.9, '{"created_at":1779026134316631482,"message_id":"collector:americas-1779026134316625750-44","message_type":"weather.packet","payload":{"city":"Los Angeles","continent":"Americas","country":"USA","humidity":78.0,"region":"americas","temperature":16.2,"timestamp":1779026134316,"wind_speed":5.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Americas', 'USA', 'americas', 'Los Angeles', 1, 16.2, 16.2, 16.2, 78, 5.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026134338090084
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026134334542402-45', 'collector:north_india', 'Asia', 'India', 'north_india', 'Delhi', to_timestamp(1779026134281 / 1000.0), to_timestamp(1779026134334546970 / 1000.0), 37, 26, 13.6, '{"created_at":1779026134334546970,"message_id":"collector:north_india-1779026134334542402-45","message_type":"weather.packet","payload":{"city":"Delhi","continent":"Asia","country":"India","humidity":26.0,"region":"north_india","temperature":37.0,"timestamp":1779026134281,"wind_speed":13.6},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Asia', 'India', 'north_india', 'Delhi', 1, 37, 37, 37, 26, 13.6);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026134359061306
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026134355174299-44', 'collector:europe', 'Europe', 'Europe', 'europe', 'London', to_timestamp(1779026134343 / 1000.0), to_timestamp(1779026134355179203 / 1000.0), 16.1, 39, 13, '{"created_at":1779026134355179203,"message_id":"collector:europe-1779026134355174299-44","message_type":"weather.packet","payload":{"city":"London","continent":"Europe","country":"Europe","humidity":39.0,"region":"europe","temperature":16.1,"timestamp":1779026134343,"wind_speed":13.0},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Europe', 'Europe', 'europe', 'London', 1, 16.1, 16.1, 16.1, 39, 13);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026134392768518
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026134388812523-44', 'collector:south_india', 'Asia', 'India', 'south_india', 'Bangalore', to_timestamp(1779026134324 / 1000.0), to_timestamp(1779026134388817922 / 1000.0), 29.5, 45, 10.7, '{"created_at":1779026134388817922,"message_id":"collector:south_india-1779026134388812523-44","message_type":"weather.packet","payload":{"city":"Bangalore","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":29.5,"timestamp":1779026134324,"wind_speed":10.7},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Asia', 'India', 'south_india', 'Bangalore', 1, 29.5, 29.5, 29.5, 45, 10.7);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026134429445597
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026134425563044-45', 'collector:americas', 'Americas', 'USA', 'americas', 'New York', to_timestamp(1779026134392 / 1000.0), to_timestamp(1779026134425569439 / 1000.0), 25.4, 54, 7.9, '{"created_at":1779026134425569439,"message_id":"collector:americas-1779026134425563044-45","message_type":"weather.packet","payload":{"city":"New York","continent":"Americas","country":"USA","humidity":54.0,"region":"americas","temperature":25.4,"timestamp":1779026134392,"wind_speed":7.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Americas', 'USA', 'americas', 'New York', 1, 25.4, 25.4, 25.4, 54, 7.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026135181976741
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026135174835884-45', 'collector:europe', 'Europe', 'Europe', 'europe', 'Paris', to_timestamp(1779026135163 / 1000.0), to_timestamp(1779026135174843393 / 1000.0), 14.3, 76, 9.3, '{"created_at":1779026135174843393,"message_id":"collector:europe-1779026135174835884-45","message_type":"weather.packet","payload":{"city":"Paris","continent":"Europe","country":"Europe","humidity":76.0,"region":"europe","temperature":14.3,"timestamp":1779026135163,"wind_speed":9.3},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Europe', 'Europe', 'europe', 'Paris', 1, 14.3, 14.3, 14.3, 76, 9.3);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026137387646083
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026137380969575-45', 'collector:south_india', 'Asia', 'India', 'south_india', 'Hyderabad', to_timestamp(1779026137375 / 1000.0), to_timestamp(1779026137380977304 / 1000.0), 33.2, 45, 6.2, '{"created_at":1779026137380977304,"message_id":"collector:south_india-1779026137380969575-45","message_type":"weather.packet","payload":{"city":"Hyderabad","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":33.2,"timestamp":1779026137375,"wind_speed":6.2},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Asia', 'India', 'south_india', 'Hyderabad', 1, 33.2, 33.2, 33.2, 45, 6.2);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026139334678340
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026139325536606-46', 'collector:north_india', 'Asia', 'India', 'north_india', 'Mumbai', to_timestamp(1779026139324 / 1000.0), to_timestamp(1779026139325544217 / 1000.0), 30.4, 76, 9, '{"created_at":1779026139325544217,"message_id":"collector:north_india-1779026139325536606-46","message_type":"weather.packet","payload":{"city":"Mumbai","continent":"Asia","country":"India","humidity":76.0,"region":"north_india","temperature":30.4,"timestamp":1779026139324,"wind_speed":9.0},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Asia', 'India', 'north_india', 'Mumbai', 1, 30.4, 30.4, 30.4, 76, 9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026139533709408
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026139527202209-47', 'collector:north_india', 'Asia', 'India', 'north_india', 'Delhi', to_timestamp(1779026139478 / 1000.0), to_timestamp(1779026139527209165 / 1000.0), 37, 26, 13.6, '{"created_at":1779026139527209165,"message_id":"collector:north_india-1779026139527202209-47","message_type":"weather.packet","payload":{"city":"Delhi","continent":"Asia","country":"India","humidity":26.0,"region":"north_india","temperature":37.0,"timestamp":1779026139478,"wind_speed":13.6},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Asia', 'India', 'north_india', 'Delhi', 1, 37, 37, 37, 26, 13.6);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026139533921753
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026139527712218-46', 'collector:americas', 'Americas', 'USA', 'americas', 'Los Angeles', to_timestamp(1779026139527 / 1000.0), to_timestamp(1779026139527718792 / 1000.0), 16.2, 78, 5.9, '{"created_at":1779026139527718792,"message_id":"collector:americas-1779026139527712218-46","message_type":"weather.packet","payload":{"city":"Los Angeles","continent":"Americas","country":"USA","humidity":78.0,"region":"americas","temperature":16.2,"timestamp":1779026139527,"wind_speed":5.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Americas', 'USA', 'americas', 'Los Angeles', 1, 16.2, 16.2, 16.2, 78, 5.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026139551720484
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026139548245685-46', 'collector:europe', 'Europe', 'Europe', 'europe', 'London', to_timestamp(1779026139536 / 1000.0), to_timestamp(1779026139548251562 / 1000.0), 16.1, 39, 13, '{"created_at":1779026139548251562,"message_id":"collector:europe-1779026139548245685-46","message_type":"weather.packet","payload":{"city":"London","continent":"Europe","country":"Europe","humidity":39.0,"region":"europe","temperature":16.1,"timestamp":1779026139536,"wind_speed":13.0},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Europe', 'Europe', 'europe', 'London', 1, 16.1, 16.1, 16.1, 39, 13);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026139555791358
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026139552333270-46', 'collector:south_india', 'Asia', 'India', 'south_india', 'Bangalore', to_timestamp(1779026139519 / 1000.0), to_timestamp(1779026139552338494 / 1000.0), 29.5, 45, 10.7, '{"created_at":1779026139552338494,"message_id":"collector:south_india-1779026139552333270-46","message_type":"weather.packet","payload":{"city":"Bangalore","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":29.5,"timestamp":1779026139519,"wind_speed":10.7},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Asia', 'India', 'south_india', 'Bangalore', 1, 29.5, 29.5, 29.5, 45, 10.7);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026139593557433
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026139589682404-47', 'collector:americas', 'Americas', 'USA', 'americas', 'New York', to_timestamp(1779026139589 / 1000.0), to_timestamp(1779026139589686909 / 1000.0), 25.4, 54, 7.9, '{"created_at":1779026139589686909,"message_id":"collector:americas-1779026139589682404-47","message_type":"weather.packet","payload":{"city":"New York","continent":"Americas","country":"USA","humidity":54.0,"region":"americas","temperature":25.4,"timestamp":1779026139589,"wind_speed":7.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Americas', 'USA', 'americas', 'New York', 1, 25.4, 25.4, 25.4, 54, 7.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026140575942719
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026140569180761-47', 'collector:europe', 'Europe', 'Europe', 'europe', 'Paris', to_timestamp(1779026140481 / 1000.0), to_timestamp(1779026140569190089 / 1000.0), 14.3, 76, 9.3, '{"created_at":1779026140569190089,"message_id":"collector:europe-1779026140569180761-47","message_type":"weather.packet","payload":{"city":"Paris","continent":"Europe","country":"Europe","humidity":76.0,"region":"europe","temperature":14.3,"timestamp":1779026140481,"wind_speed":9.3},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Europe', 'Europe', 'europe', 'Paris', 1, 14.3, 14.3, 14.3, 76, 9.3);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026140495118790
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026140489001367-47', 'collector:south_india', 'Asia', 'India', 'south_india', 'Hyderabad', to_timestamp(1779026140477 / 1000.0), to_timestamp(1779026140489008927 / 1000.0), 33.2, 45, 6.2, '{"created_at":1779026140489008927,"message_id":"collector:south_india-1779026140489001367-47","message_type":"weather.packet","payload":{"city":"Hyderabad","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":33.2,"timestamp":1779026140477,"wind_speed":6.2},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Asia', 'India', 'south_india', 'Hyderabad', 1, 33.2, 33.2, 33.2, 45, 6.2);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026142304143280
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026142295293251-48', 'collector:north_india', 'Asia', 'India', 'north_india', 'Mumbai', to_timestamp(1779026142294 / 1000.0), to_timestamp(1779026142295300601 / 1000.0), 30.4, 76, 9, '{"created_at":1779026142295300601,"message_id":"collector:north_india-1779026142295293251-48","message_type":"weather.packet","payload":{"city":"Mumbai","continent":"Asia","country":"India","humidity":76.0,"region":"north_india","temperature":30.4,"timestamp":1779026142294,"wind_speed":9.0},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Asia', 'India', 'north_india', 'Mumbai', 1, 30.4, 30.4, 30.4, 76, 9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026142507123549
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026142500712090-49', 'collector:north_india', 'Asia', 'India', 'north_india', 'Delhi', to_timestamp(1779026142460 / 1000.0), to_timestamp(1779026142500719027 / 1000.0), 37, 26, 13.6, '{"created_at":1779026142500719027,"message_id":"collector:north_india-1779026142500712090-49","message_type":"weather.packet","payload":{"city":"Delhi","continent":"Asia","country":"India","humidity":26.0,"region":"north_india","temperature":37.0,"timestamp":1779026142460,"wind_speed":13.6},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Asia', 'India', 'north_india', 'Delhi', 1, 37, 37, 37, 26, 13.6);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026142511433684
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026142505300048-48', 'collector:americas', 'Americas', 'USA', 'americas', 'Los Angeles', to_timestamp(1779026142505 / 1000.0), to_timestamp(1779026142505307705 / 1000.0), 16.2, 78, 5.9, '{"created_at":1779026142505307705,"message_id":"collector:americas-1779026142505300048-48","message_type":"weather.packet","payload":{"city":"Los Angeles","continent":"Americas","country":"USA","humidity":78.0,"region":"americas","temperature":16.2,"timestamp":1779026142505,"wind_speed":5.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Americas', 'USA', 'americas', 'Los Angeles', 1, 16.2, 16.2, 16.2, 78, 5.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026142562837357
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026142559169711-48', 'collector:south_india', 'Asia', 'India', 'south_india', 'Bangalore', to_timestamp(1779026142496 / 1000.0), to_timestamp(1779026142559176137 / 1000.0), 29.5, 45, 10.7, '{"created_at":1779026142559176137,"message_id":"collector:south_india-1779026142559169711-48","message_type":"weather.packet","payload":{"city":"Bangalore","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":29.5,"timestamp":1779026142496,"wind_speed":10.7},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Asia', 'India', 'south_india', 'Bangalore', 1, 29.5, 29.5, 29.5, 45, 10.7);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026142586583772
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026142582977452-48', 'collector:europe', 'Europe', 'Europe', 'europe', 'London', to_timestamp(1779026142506 / 1000.0), to_timestamp(1779026142582983709 / 1000.0), 16.1, 39, 13, '{"created_at":1779026142582983709,"message_id":"collector:europe-1779026142582977452-48","message_type":"weather.packet","payload":{"city":"London","continent":"Europe","country":"Europe","humidity":39.0,"region":"europe","temperature":16.1,"timestamp":1779026142506,"wind_speed":13.0},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Europe', 'Europe', 'europe', 'London', 1, 16.1, 16.1, 16.1, 39, 13);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026142609909941
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026142605958494-49', 'collector:americas', 'Americas', 'USA', 'americas', 'New York', to_timestamp(1779026142564 / 1000.0), to_timestamp(1779026142605964628 / 1000.0), 25.4, 54, 7.9, '{"created_at":1779026142605964628,"message_id":"collector:americas-1779026142605958494-49","message_type":"weather.packet","payload":{"city":"New York","continent":"Americas","country":"USA","humidity":54.0,"region":"americas","temperature":25.4,"timestamp":1779026142564,"wind_speed":7.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Americas', 'USA', 'americas', 'New York', 1, 25.4, 25.4, 25.4, 54, 7.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026143513987431
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026143508780384-49', 'collector:europe', 'Europe', 'Europe', 'europe', 'Paris', to_timestamp(1779026143472 / 1000.0), to_timestamp(1779026143508786546 / 1000.0), 14.3, 76, 9.3, '{"created_at":1779026143508786546,"message_id":"collector:europe-1779026143508780384-49","message_type":"weather.packet","payload":{"city":"Paris","continent":"Europe","country":"Europe","humidity":76.0,"region":"europe","temperature":14.3,"timestamp":1779026143472,"wind_speed":9.3},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Europe', 'Europe', 'europe', 'Paris', 1, 14.3, 14.3, 14.3, 76, 9.3);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026145775423986
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026145771709662-49', 'collector:south_india', 'Asia', 'India', 'south_india', 'Hyderabad', to_timestamp(1779026145719 / 1000.0), to_timestamp(1779026145771715372 / 1000.0), 33.2, 45, 6.2, '{"created_at":1779026145771715372,"message_id":"collector:south_india-1779026145771709662-49","message_type":"weather.packet","payload":{"city":"Hyderabad","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":33.2,"timestamp":1779026145719,"wind_speed":6.2},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Asia', 'India', 'south_india', 'Hyderabad', 1, 33.2, 33.2, 33.2, 45, 6.2);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026147515051066
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026147509240060-50', 'collector:north_india', 'Asia', 'India', 'north_india', 'Mumbai', to_timestamp(1779026147508 / 1000.0), to_timestamp(1779026147509246575 / 1000.0), 30.4, 76, 9, '{"created_at":1779026147509246575,"message_id":"collector:north_india-1779026147509240060-50","message_type":"weather.packet","payload":{"city":"Mumbai","continent":"Asia","country":"India","humidity":76.0,"region":"north_india","temperature":30.4,"timestamp":1779026147508,"wind_speed":9.0},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Asia', 'India', 'north_india', 'Mumbai', 1, 30.4, 30.4, 30.4, 76, 9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026147719114131
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026147713657066-50', 'collector:americas', 'Americas', 'USA', 'americas', 'Los Angeles', to_timestamp(1779026147713 / 1000.0), to_timestamp(1779026147713663526 / 1000.0), 16.2, 78, 5.9, '{"created_at":1779026147713663526,"message_id":"collector:americas-1779026147713657066-50","message_type":"weather.packet","payload":{"city":"Los Angeles","continent":"Americas","country":"USA","humidity":78.0,"region":"americas","temperature":16.2,"timestamp":1779026147713,"wind_speed":5.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Americas', 'USA', 'americas', 'Los Angeles', 1, 16.2, 16.2, 16.2, 78, 5.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026147720300101
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026147713410164-51', 'collector:north_india', 'Asia', 'India', 'north_india', 'Delhi', to_timestamp(1779026147660 / 1000.0), to_timestamp(1779026147713417797 / 1000.0), 37, 26, 13.6, '{"created_at":1779026147713417797,"message_id":"collector:north_india-1779026147713410164-51","message_type":"weather.packet","payload":{"city":"Delhi","continent":"Asia","country":"India","humidity":26.0,"region":"north_india","temperature":37.0,"timestamp":1779026147660,"wind_speed":13.6},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Asia', 'India', 'north_india', 'Delhi', 1, 37, 37, 37, 26, 13.6);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026147754878094
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026147751038624-50', 'collector:south_india', 'Asia', 'India', 'south_india', 'Bangalore', to_timestamp(1779026147703 / 1000.0), to_timestamp(1779026147751043861 / 1000.0), 29.5, 45, 10.7, '{"created_at":1779026147751043861,"message_id":"collector:south_india-1779026147751038624-50","message_type":"weather.packet","payload":{"city":"Bangalore","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":29.5,"timestamp":1779026147703,"wind_speed":10.7},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Asia', 'India', 'south_india', 'Bangalore', 1, 29.5, 29.5, 29.5, 45, 10.7);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026147756658112
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026147753337227-50', 'collector:europe', 'Europe', 'Europe', 'europe', 'London', to_timestamp(1779026147707 / 1000.0), to_timestamp(1779026147753341289 / 1000.0), 16.1, 39, 13, '{"created_at":1779026147753341289,"message_id":"collector:europe-1779026147753337227-50","message_type":"weather.packet","payload":{"city":"London","continent":"Europe","country":"Europe","humidity":39.0,"region":"europe","temperature":16.1,"timestamp":1779026147707,"wind_speed":13.0},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Europe', 'Europe', 'europe', 'London', 1, 16.1, 16.1, 16.1, 39, 13);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026147819539472
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026147815813417-51', 'collector:americas', 'Americas', 'USA', 'americas', 'New York', to_timestamp(1779026147765 / 1000.0), to_timestamp(1779026147815818600 / 1000.0), 25.4, 54, 7.9, '{"created_at":1779026147815818600,"message_id":"collector:americas-1779026147815813417-51","message_type":"weather.packet","payload":{"city":"New York","continent":"Americas","country":"USA","humidity":54.0,"region":"americas","temperature":25.4,"timestamp":1779026147765,"wind_speed":7.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Americas', 'USA', 'americas', 'New York', 1, 25.4, 25.4, 25.4, 54, 7.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026148793730338
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026148787836667-51', 'collector:europe', 'Europe', 'Europe', 'europe', 'Paris', to_timestamp(1779026148712 / 1000.0), to_timestamp(1779026148787844020 / 1000.0), 14.3, 76, 9.3, '{"created_at":1779026148787844020,"message_id":"collector:europe-1779026148787836667-51","message_type":"weather.packet","payload":{"city":"Paris","continent":"Europe","country":"Europe","humidity":76.0,"region":"europe","temperature":14.3,"timestamp":1779026148712,"wind_speed":9.3},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Europe', 'Europe', 'europe', 'Paris', 1, 14.3, 14.3, 14.3, 76, 9.3);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026150977638480
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026150972401016-51', 'collector:south_india', 'Asia', 'India', 'south_india', 'Hyderabad', to_timestamp(1779026150936 / 1000.0), to_timestamp(1779026150972408098 / 1000.0), 33.2, 45, 6.2, '{"created_at":1779026150972408098,"message_id":"collector:south_india-1779026150972401016-51","message_type":"weather.packet","payload":{"city":"Hyderabad","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":33.2,"timestamp":1779026150936,"wind_speed":6.2},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Asia', 'India', 'south_india', 'Hyderabad', 1, 33.2, 33.2, 33.2, 45, 6.2);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026152704829787
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026152698444414-52', 'collector:north_india', 'Asia', 'India', 'north_india', 'Mumbai', to_timestamp(1779026152698 / 1000.0), to_timestamp(1779026152698453207 / 1000.0), 30.4, 76, 9, '{"created_at":1779026152698453207,"message_id":"collector:north_india-1779026152698444414-52","message_type":"weather.packet","payload":{"city":"Mumbai","continent":"Asia","country":"India","humidity":76.0,"region":"north_india","temperature":30.4,"timestamp":1779026152698,"wind_speed":9.0},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Asia', 'India', 'north_india', 'Mumbai', 1, 30.4, 30.4, 30.4, 76, 9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026152903931102
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026152898016129-52', 'collector:americas', 'Americas', 'USA', 'americas', 'Los Angeles', to_timestamp(1779026152897 / 1000.0), to_timestamp(1779026152898022684 / 1000.0), 16.2, 78, 5.9, '{"created_at":1779026152898022684,"message_id":"collector:americas-1779026152898016129-52","message_type":"weather.packet","payload":{"city":"Los Angeles","continent":"Americas","country":"USA","humidity":78.0,"region":"americas","temperature":16.2,"timestamp":1779026152897,"wind_speed":5.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Americas', 'USA', 'americas', 'Los Angeles', 1, 16.2, 16.2, 16.2, 78, 5.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026152905040079
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026152899174315-53', 'collector:north_india', 'Asia', 'India', 'north_india', 'Delhi', to_timestamp(1779026152839 / 1000.0), to_timestamp(1779026152899181185 / 1000.0), 37, 26, 13.6, '{"created_at":1779026152899181185,"message_id":"collector:north_india-1779026152899174315-53","message_type":"weather.packet","payload":{"city":"Delhi","continent":"Asia","country":"India","humidity":26.0,"region":"north_india","temperature":37.0,"timestamp":1779026152839,"wind_speed":13.6},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Asia', 'India', 'north_india', 'Delhi', 1, 37, 37, 37, 26, 13.6);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026152957542722
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026152953640651-52', 'collector:south_india', 'Asia', 'India', 'south_india', 'Bangalore', to_timestamp(1779026152887 / 1000.0), to_timestamp(1779026152953646726 / 1000.0), 29.5, 45, 10.7, '{"created_at":1779026152953646726,"message_id":"collector:south_india-1779026152953640651-52","message_type":"weather.packet","payload":{"city":"Bangalore","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":29.5,"timestamp":1779026152887,"wind_speed":10.7},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Asia', 'India', 'south_india', 'Bangalore', 1, 29.5, 29.5, 29.5, 45, 10.7);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026152958097231
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026152954416106-52', 'collector:europe', 'Europe', 'Europe', 'europe', 'London', to_timestamp(1779026152917 / 1000.0), to_timestamp(1779026152954420604 / 1000.0), 16.1, 39, 13, '{"created_at":1779026152954420604,"message_id":"collector:europe-1779026152954416106-52","message_type":"weather.packet","payload":{"city":"London","continent":"Europe","country":"Europe","humidity":39.0,"region":"europe","temperature":16.1,"timestamp":1779026152917,"wind_speed":13.0},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Europe', 'Europe', 'europe', 'London', 1, 16.1, 16.1, 16.1, 39, 13);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026153002103088
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026152998649137-53', 'collector:americas', 'Americas', 'USA', 'americas', 'New York', to_timestamp(1779026152958 / 1000.0), to_timestamp(1779026152998654274 / 1000.0), 25.4, 54, 7.9, '{"created_at":1779026152998654274,"message_id":"collector:americas-1779026152998649137-53","message_type":"weather.packet","payload":{"city":"New York","continent":"Americas","country":"USA","humidity":54.0,"region":"americas","temperature":25.4,"timestamp":1779026152958,"wind_speed":7.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Americas', 'USA', 'americas', 'New York', 1, 25.4, 25.4, 25.4, 54, 7.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026153966858305
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026153958404730-53', 'collector:europe', 'Europe', 'Europe', 'europe', 'Paris', to_timestamp(1779026153951 / 1000.0), to_timestamp(1779026153958411381 / 1000.0), 14.3, 76, 9.3, '{"created_at":1779026153958411381,"message_id":"collector:europe-1779026153958404730-53","message_type":"weather.packet","payload":{"city":"Paris","continent":"Europe","country":"Europe","humidity":76.0,"region":"europe","temperature":14.3,"timestamp":1779026153951,"wind_speed":9.3},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Europe', 'Europe', 'europe', 'Paris', 1, 14.3, 14.3, 14.3, 76, 9.3);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026156176196491
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026156170825064-53', 'collector:south_india', 'Asia', 'India', 'south_india', 'Hyderabad', to_timestamp(1779026156151 / 1000.0), to_timestamp(1779026156170831293 / 1000.0), 33.2, 45, 6.2, '{"created_at":1779026156170831293,"message_id":"collector:south_india-1779026156170825064-53","message_type":"weather.packet","payload":{"city":"Hyderabad","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":33.2,"timestamp":1779026156151,"wind_speed":6.2},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Asia', 'India', 'south_india', 'Hyderabad', 1, 33.2, 33.2, 33.2, 45, 6.2);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026157903864807
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026157894817514-54', 'collector:north_india', 'Asia', 'India', 'north_india', 'Mumbai', to_timestamp(1779026157894 / 1000.0), to_timestamp(1779026157894824448 / 1000.0), 30.4, 76, 9, '{"created_at":1779026157894824448,"message_id":"collector:north_india-1779026157894817514-54","message_type":"weather.packet","payload":{"city":"Mumbai","continent":"Asia","country":"India","humidity":76.0,"region":"north_india","temperature":30.4,"timestamp":1779026157894,"wind_speed":9.0},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Asia', 'India', 'north_india', 'Mumbai', 1, 30.4, 30.4, 30.4, 76, 9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026158103104289
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026158096999038-55', 'collector:north_india', 'Asia', 'India', 'north_india', 'Delhi', to_timestamp(1779026158042 / 1000.0), to_timestamp(1779026158097007100 / 1000.0), 37, 26, 13.6, '{"created_at":1779026158097007100,"message_id":"collector:north_india-1779026158096999038-55","message_type":"weather.packet","payload":{"city":"Delhi","continent":"Asia","country":"India","humidity":26.0,"region":"north_india","temperature":37.0,"timestamp":1779026158042,"wind_speed":13.6},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Asia', 'India', 'north_india', 'Delhi', 1, 37, 37, 37, 26, 13.6);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026158104484535
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026158097249529-54', 'collector:americas', 'Americas', 'USA', 'americas', 'Los Angeles', to_timestamp(1779026158097 / 1000.0), to_timestamp(1779026158097257566 / 1000.0), 16.2, 78, 5.9, '{"created_at":1779026158097257566,"message_id":"collector:americas-1779026158097249529-54","message_type":"weather.packet","payload":{"city":"Los Angeles","continent":"Americas","country":"USA","humidity":78.0,"region":"americas","temperature":16.2,"timestamp":1779026158097,"wind_speed":5.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Americas', 'USA', 'americas', 'Los Angeles', 1, 16.2, 16.2, 16.2, 78, 5.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026158166798720
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026158163126607-54', 'collector:south_india', 'Asia', 'India', 'south_india', 'Bangalore', to_timestamp(1779026158084 / 1000.0), to_timestamp(1779026158163131234 / 1000.0), 29.5, 45, 10.7, '{"created_at":1779026158163131234,"message_id":"collector:south_india-1779026158163126607-54","message_type":"weather.packet","payload":{"city":"Bangalore","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":29.5,"timestamp":1779026158084,"wind_speed":10.7},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Asia', 'India', 'south_india', 'Bangalore', 1, 29.5, 29.5, 29.5, 45, 10.7);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026158202903730
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026158198931431-55', 'collector:americas', 'Americas', 'USA', 'americas', 'New York', to_timestamp(1779026158156 / 1000.0), to_timestamp(1779026158198937581 / 1000.0), 25.4, 54, 7.9, '{"created_at":1779026158198937581,"message_id":"collector:americas-1779026158198931431-55","message_type":"weather.packet","payload":{"city":"New York","continent":"Americas","country":"USA","humidity":54.0,"region":"americas","temperature":25.4,"timestamp":1779026158156,"wind_speed":7.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Americas', 'USA', 'americas', 'New York', 1, 25.4, 25.4, 25.4, 54, 7.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026158222565270
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026158218999980-54', 'collector:europe', 'Europe', 'Europe', 'europe', 'London', to_timestamp(1779026158154 / 1000.0), to_timestamp(1779026158219005595 / 1000.0), 16.1, 39, 13, '{"created_at":1779026158219005595,"message_id":"collector:europe-1779026158218999980-54","message_type":"weather.packet","payload":{"city":"London","continent":"Europe","country":"Europe","humidity":39.0,"region":"europe","temperature":16.1,"timestamp":1779026158154,"wind_speed":13.0},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Europe', 'Europe', 'europe', 'London', 1, 16.1, 16.1, 16.1, 39, 13);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026159242703484
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026159238929164-55', 'collector:europe', 'Europe', 'Europe', 'europe', 'Paris', to_timestamp(1779026159164 / 1000.0), to_timestamp(1779026159238935040 / 1000.0), 14.3, 76, 9.3, '{"created_at":1779026159238935040,"message_id":"collector:europe-1779026159238929164-55","message_type":"weather.packet","payload":{"city":"Paris","continent":"Europe","country":"Europe","humidity":76.0,"region":"europe","temperature":14.3,"timestamp":1779026159164,"wind_speed":9.3},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026100000 / 1000.0), 'Europe', 'Europe', 'europe', 'Paris', 1, 14.3, 14.3, 14.3, 76, 9.3);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026161470343877
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026161467005986-55', 'collector:south_india', 'Asia', 'India', 'south_india', 'Hyderabad', to_timestamp(1779026161448 / 1000.0), to_timestamp(1779026161467011267 / 1000.0), 33.2, 45, 6.2, '{"created_at":1779026161467011267,"message_id":"collector:south_india-1779026161467005986-55","message_type":"weather.packet","payload":{"city":"Hyderabad","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":33.2,"timestamp":1779026161448,"wind_speed":6.2},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026160000 / 1000.0), 'Asia', 'India', 'south_india', 'Hyderabad', 1, 33.2, 33.2, 33.2, 45, 6.2);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026163097057640
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026163093268918-56', 'collector:north_india', 'Asia', 'India', 'north_india', 'Mumbai', to_timestamp(1779026163093 / 1000.0), to_timestamp(1779026163093273150 / 1000.0), 30.4, 76, 9, '{"created_at":1779026163093273150,"message_id":"collector:north_india-1779026163093268918-56","message_type":"weather.packet","payload":{"city":"Mumbai","continent":"Asia","country":"India","humidity":76.0,"region":"north_india","temperature":30.4,"timestamp":1779026163093,"wind_speed":9.0},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026160000 / 1000.0), 'Asia', 'India', 'north_india', 'Mumbai', 1, 30.4, 30.4, 30.4, 76, 9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026163298965752
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026163295198503-57', 'collector:north_india', 'Asia', 'India', 'north_india', 'Delhi', to_timestamp(1779026163246 / 1000.0), to_timestamp(1779026163295204111 / 1000.0), 37, 26, 13.6, '{"created_at":1779026163295204111,"message_id":"collector:north_india-1779026163295198503-57","message_type":"weather.packet","payload":{"city":"Delhi","continent":"Asia","country":"India","humidity":26.0,"region":"north_india","temperature":37.0,"timestamp":1779026163246,"wind_speed":13.6},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026160000 / 1000.0), 'Asia', 'India', 'north_india', 'Delhi', 1, 37, 37, 37, 26, 13.6);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026163299436888
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026163295671032-56', 'collector:americas', 'Americas', 'USA', 'americas', 'Los Angeles', to_timestamp(1779026163295 / 1000.0), to_timestamp(1779026163295675365 / 1000.0), 16.2, 78, 5.9, '{"created_at":1779026163295675365,"message_id":"collector:americas-1779026163295671032-56","message_type":"weather.packet","payload":{"city":"Los Angeles","continent":"Americas","country":"USA","humidity":78.0,"region":"americas","temperature":16.2,"timestamp":1779026163295,"wind_speed":5.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026160000 / 1000.0), 'Americas', 'USA', 'americas', 'Los Angeles', 1, 16.2, 16.2, 16.2, 78, 5.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026163345708247
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026163342039167-56', 'collector:south_india', 'Asia', 'India', 'south_india', 'Bangalore', to_timestamp(1779026163278 / 1000.0), to_timestamp(1779026163342043891 / 1000.0), 29.5, 45, 10.7, '{"created_at":1779026163342043891,"message_id":"collector:south_india-1779026163342039167-56","message_type":"weather.packet","payload":{"city":"Bangalore","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":29.5,"timestamp":1779026163278,"wind_speed":10.7},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026160000 / 1000.0), 'Asia', 'India', 'south_india', 'Bangalore', 1, 29.5, 29.5, 29.5, 45, 10.7);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026163372957580
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026163369395054-56', 'collector:europe', 'Europe', 'Europe', 'europe', 'London', to_timestamp(1779026163348 / 1000.0), to_timestamp(1779026163369400261 / 1000.0), 16.1, 39, 13, '{"created_at":1779026163369400261,"message_id":"collector:europe-1779026163369395054-56","message_type":"weather.packet","payload":{"city":"London","continent":"Europe","country":"Europe","humidity":39.0,"region":"europe","temperature":16.1,"timestamp":1779026163348,"wind_speed":13.0},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026160000 / 1000.0), 'Europe', 'Europe', 'europe', 'London', 1, 16.1, 16.1, 16.1, 39, 13);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026163400287723
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026163396049969-57', 'collector:americas', 'Americas', 'USA', 'americas', 'New York', to_timestamp(1779026163357 / 1000.0), to_timestamp(1779026163396056006 / 1000.0), 25.4, 54, 7.9, '{"created_at":1779026163396056006,"message_id":"collector:americas-1779026163396049969-57","message_type":"weather.packet","payload":{"city":"New York","continent":"Americas","country":"USA","humidity":54.0,"region":"americas","temperature":25.4,"timestamp":1779026163357,"wind_speed":7.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026160000 / 1000.0), 'Americas', 'USA', 'americas', 'New York', 1, 25.4, 25.4, 25.4, 54, 7.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026164514229542
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026164508983596-57', 'collector:europe', 'Europe', 'Europe', 'europe', 'Paris', to_timestamp(1779026164409 / 1000.0), to_timestamp(1779026164508989045 / 1000.0), 14.3, 76, 9.3, '{"created_at":1779026164508989045,"message_id":"collector:europe-1779026164508983596-57","message_type":"weather.packet","payload":{"city":"Paris","continent":"Europe","country":"Europe","humidity":76.0,"region":"europe","temperature":14.3,"timestamp":1779026164409,"wind_speed":9.3},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026160000 / 1000.0), 'Europe', 'Europe', 'europe', 'Paris', 1, 14.3, 14.3, 14.3, 76, 9.3);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026166751612085
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026166747825607-57', 'collector:south_india', 'Asia', 'India', 'south_india', 'Hyderabad', to_timestamp(1779026166660 / 1000.0), to_timestamp(1779026166747831258 / 1000.0), 33.2, 45, 6.2, '{"created_at":1779026166747831258,"message_id":"collector:south_india-1779026166747825607-57","message_type":"weather.packet","payload":{"city":"Hyderabad","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":33.2,"timestamp":1779026166660,"wind_speed":6.2},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026160000 / 1000.0), 'Asia', 'India', 'south_india', 'Hyderabad', 1, 33.2, 33.2, 33.2, 45, 6.2);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026168316887927
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026168309950081-58', 'collector:north_india', 'Asia', 'India', 'north_india', 'Mumbai', to_timestamp(1779026168309 / 1000.0), to_timestamp(1779026168309958650 / 1000.0), 30.4, 76, 9, '{"created_at":1779026168309958650,"message_id":"collector:north_india-1779026168309950081-58","message_type":"weather.packet","payload":{"city":"Mumbai","continent":"Asia","country":"India","humidity":76.0,"region":"north_india","temperature":30.4,"timestamp":1779026168309,"wind_speed":9.0},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026160000 / 1000.0), 'Asia', 'India', 'north_india', 'Mumbai', 1, 30.4, 30.4, 30.4, 76, 9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026168492664289
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026168487673208-58', 'collector:south_india', 'Asia', 'India', 'south_india', 'Bangalore', to_timestamp(1779026168476 / 1000.0), to_timestamp(1779026168487678708 / 1000.0), 29.5, 45, 10.7, '{"created_at":1779026168487678708,"message_id":"collector:south_india-1779026168487673208-58","message_type":"weather.packet","payload":{"city":"Bangalore","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":29.5,"timestamp":1779026168476,"wind_speed":10.7},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026160000 / 1000.0), 'Asia', 'India', 'south_india', 'Bangalore', 1, 29.5, 29.5, 29.5, 45, 10.7);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026168502633748
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026168497684163-58', 'collector:americas', 'Americas', 'USA', 'americas', 'Los Angeles', to_timestamp(1779026168497 / 1000.0), to_timestamp(1779026168497690113 / 1000.0), 16.2, 78, 5.9, '{"created_at":1779026168497690113,"message_id":"collector:americas-1779026168497684163-58","message_type":"weather.packet","payload":{"city":"Los Angeles","continent":"Americas","country":"USA","humidity":78.0,"region":"americas","temperature":16.2,"timestamp":1779026168497,"wind_speed":5.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026160000 / 1000.0), 'Americas', 'USA', 'americas', 'Los Angeles', 1, 16.2, 16.2, 16.2, 78, 5.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026168515978418
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026168511208461-59', 'collector:north_india', 'Asia', 'India', 'north_india', 'Delhi', to_timestamp(1779026168436 / 1000.0), to_timestamp(1779026168511243985 / 1000.0), 37, 26, 13.6, '{"created_at":1779026168511243985,"message_id":"collector:north_india-1779026168511208461-59","message_type":"weather.packet","payload":{"city":"Delhi","continent":"Asia","country":"India","humidity":26.0,"region":"north_india","temperature":37.0,"timestamp":1779026168436,"wind_speed":13.6},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026160000 / 1000.0), 'Asia', 'India', 'north_india', 'Delhi', 1, 37, 37, 37, 26, 13.6);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026168602345041
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026168598700249-59', 'collector:americas', 'Americas', 'USA', 'americas', 'New York', to_timestamp(1779026168558 / 1000.0), to_timestamp(1779026168598705530 / 1000.0), 25.4, 54, 7.9, '{"created_at":1779026168598705530,"message_id":"collector:americas-1779026168598700249-59","message_type":"weather.packet","payload":{"city":"New York","continent":"Americas","country":"USA","humidity":54.0,"region":"americas","temperature":25.4,"timestamp":1779026168558,"wind_speed":7.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026160000 / 1000.0), 'Americas', 'USA', 'americas', 'New York', 1, 25.4, 25.4, 25.4, 54, 7.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026168645453840
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026168641754591-58', 'collector:europe', 'Europe', 'Europe', 'europe', 'London', to_timestamp(1779026168568 / 1000.0), to_timestamp(1779026168641760425 / 1000.0), 16.1, 39, 13, '{"created_at":1779026168641760425,"message_id":"collector:europe-1779026168641754591-58","message_type":"weather.packet","payload":{"city":"London","continent":"Europe","country":"Europe","humidity":39.0,"region":"europe","temperature":16.1,"timestamp":1779026168568,"wind_speed":13.0},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026160000 / 1000.0), 'Europe', 'Europe', 'europe', 'London', 1, 16.1, 16.1, 16.1, 39, 13);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026169655578432
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026169651260373-59', 'collector:europe', 'Europe', 'Europe', 'europe', 'Paris', to_timestamp(1779026169592 / 1000.0), to_timestamp(1779026169651266589 / 1000.0), 14.3, 76, 9.3, '{"created_at":1779026169651266589,"message_id":"collector:europe-1779026169651260373-59","message_type":"weather.packet","payload":{"city":"Paris","continent":"Europe","country":"Europe","humidity":76.0,"region":"europe","temperature":14.3,"timestamp":1779026169592,"wind_speed":9.3},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026160000 / 1000.0), 'Europe', 'Europe', 'europe', 'Paris', 1, 14.3, 14.3, 14.3, 76, 9.3);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026169742956156
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026169739034621-59', 'collector:south_india', 'Asia', 'India', 'south_india', 'Hyderabad', to_timestamp(1779026169686 / 1000.0), to_timestamp(1779026169739040064 / 1000.0), 33.2, 45, 6.2, '{"created_at":1779026169739040064,"message_id":"collector:south_india-1779026169739034621-59","message_type":"weather.packet","payload":{"city":"Hyderabad","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":33.2,"timestamp":1779026169686,"wind_speed":6.2},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026160000 / 1000.0), 'Asia', 'India', 'south_india', 'Hyderabad', 1, 33.2, 33.2, 33.2, 45, 6.2);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026171311869026
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026171306016538-60', 'collector:north_india', 'Asia', 'India', 'north_india', 'Mumbai', to_timestamp(1779026171305 / 1000.0), to_timestamp(1779026171306026180 / 1000.0), 30.4, 76, 9, '{"created_at":1779026171306026180,"message_id":"collector:north_india-1779026171306016538-60","message_type":"weather.packet","payload":{"city":"Mumbai","continent":"Asia","country":"India","humidity":76.0,"region":"north_india","temperature":30.4,"timestamp":1779026171305,"wind_speed":9.0},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026160000 / 1000.0), 'Asia', 'India', 'north_india', 'Mumbai', 1, 30.4, 30.4, 30.4, 76, 9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026171509908044
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026171506195681-60', 'collector:americas', 'Americas', 'USA', 'americas', 'Los Angeles', to_timestamp(1779026171505 / 1000.0), to_timestamp(1779026171506199681 / 1000.0), 16.2, 78, 5.9, '{"created_at":1779026171506199681,"message_id":"collector:americas-1779026171506195681-60","message_type":"weather.packet","payload":{"city":"Los Angeles","continent":"Americas","country":"USA","humidity":78.0,"region":"americas","temperature":16.2,"timestamp":1779026171505,"wind_speed":5.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026160000 / 1000.0), 'Americas', 'USA', 'americas', 'Los Angeles', 1, 16.2, 16.2, 16.2, 78, 5.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026171514882571
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026171511222995-61', 'collector:north_india', 'Asia', 'India', 'north_india', 'Delhi', to_timestamp(1779026171432 / 1000.0), to_timestamp(1779026171511228384 / 1000.0), 37, 26, 13.6, '{"created_at":1779026171511228384,"message_id":"collector:north_india-1779026171511222995-61","message_type":"weather.packet","payload":{"city":"Delhi","continent":"Asia","country":"India","humidity":26.0,"region":"north_india","temperature":37.0,"timestamp":1779026171432,"wind_speed":13.6},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026160000 / 1000.0), 'Asia', 'India', 'north_india', 'Delhi', 1, 37, 37, 37, 26, 13.6);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026171573587757
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026171569979508-60', 'collector:south_india', 'Asia', 'India', 'south_india', 'Bangalore', to_timestamp(1779026171497 / 1000.0), to_timestamp(1779026171569985054 / 1000.0), 29.5, 45, 10.7, '{"created_at":1779026171569985054,"message_id":"collector:south_india-1779026171569979508-60","message_type":"weather.packet","payload":{"city":"Bangalore","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":29.5,"timestamp":1779026171497,"wind_speed":10.7},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026160000 / 1000.0), 'Asia', 'India', 'south_india', 'Bangalore', 1, 29.5, 29.5, 29.5, 45, 10.7);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026171611383626
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026171607607313-61', 'collector:americas', 'Americas', 'USA', 'americas', 'New York', to_timestamp(1779026171560 / 1000.0), to_timestamp(1779026171607613858 / 1000.0), 25.4, 54, 7.9, '{"created_at":1779026171607613858,"message_id":"collector:americas-1779026171607607313-61","message_type":"weather.packet","payload":{"city":"New York","continent":"Americas","country":"USA","humidity":54.0,"region":"americas","temperature":25.4,"timestamp":1779026171560,"wind_speed":7.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026160000 / 1000.0), 'Americas', 'USA', 'americas', 'New York', 1, 25.4, 25.4, 25.4, 54, 7.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026171638123200
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026171634375204-60', 'collector:europe', 'Europe', 'Europe', 'europe', 'London', to_timestamp(1779026171623 / 1000.0), to_timestamp(1779026171634381342 / 1000.0), 16.1, 39, 13, '{"created_at":1779026171634381342,"message_id":"collector:europe-1779026171634375204-60","message_type":"weather.packet","payload":{"city":"London","continent":"Europe","country":"Europe","humidity":39.0,"region":"europe","temperature":16.1,"timestamp":1779026171623,"wind_speed":13.0},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026160000 / 1000.0), 'Europe', 'Europe', 'europe', 'London', 1, 16.1, 16.1, 16.1, 39, 13);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026172775935381
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026172772341278-61', 'collector:europe', 'Europe', 'Europe', 'europe', 'Paris', to_timestamp(1779026172675 / 1000.0), to_timestamp(1779026172772346386 / 1000.0), 14.3, 76, 9.3, '{"created_at":1779026172772346386,"message_id":"collector:europe-1779026172772341278-61","message_type":"weather.packet","payload":{"city":"Paris","continent":"Europe","country":"Europe","humidity":76.0,"region":"europe","temperature":14.3,"timestamp":1779026172675,"wind_speed":9.3},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026160000 / 1000.0), 'Europe', 'Europe', 'europe', 'Paris', 1, 14.3, 14.3, 14.3, 76, 9.3);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026175011657526
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026175007882414-61', 'collector:south_india', 'Asia', 'India', 'south_india', 'Hyderabad', to_timestamp(1779026174909 / 1000.0), to_timestamp(1779026175007888654 / 1000.0), 33.2, 45, 6.2, '{"created_at":1779026175007888654,"message_id":"collector:south_india-1779026175007882414-61","message_type":"weather.packet","payload":{"city":"Hyderabad","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":33.2,"timestamp":1779026174909,"wind_speed":6.2},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026160000 / 1000.0), 'Asia', 'India', 'south_india', 'Hyderabad', 1, 33.2, 33.2, 33.2, 45, 6.2);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026176502737592
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026176497477114-62', 'collector:north_india', 'Asia', 'India', 'north_india', 'Mumbai', to_timestamp(1779026176497 / 1000.0), to_timestamp(1779026176497484150 / 1000.0), 30.4, 76, 9, '{"created_at":1779026176497484150,"message_id":"collector:north_india-1779026176497477114-62","message_type":"weather.packet","payload":{"city":"Mumbai","continent":"Asia","country":"India","humidity":76.0,"region":"north_india","temperature":30.4,"timestamp":1779026176497,"wind_speed":9.0},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026160000 / 1000.0), 'Asia', 'India', 'north_india', 'Mumbai', 1, 30.4, 30.4, 30.4, 76, 9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026176705179231
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026176701166457-63', 'collector:north_india', 'Asia', 'India', 'north_india', 'Delhi', to_timestamp(1779026176655 / 1000.0), to_timestamp(1779026176701171682 / 1000.0), 37, 26, 13.6, '{"created_at":1779026176701171682,"message_id":"collector:north_india-1779026176701166457-63","message_type":"weather.packet","payload":{"city":"Delhi","continent":"Asia","country":"India","humidity":26.0,"region":"north_india","temperature":37.0,"timestamp":1779026176655,"wind_speed":13.6},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026160000 / 1000.0), 'Asia', 'India', 'north_india', 'Delhi', 1, 37, 37, 37, 26, 13.6);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026176708038317
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026176704482977-62', 'collector:americas', 'Americas', 'USA', 'americas', 'Los Angeles', to_timestamp(1779026176704 / 1000.0), to_timestamp(1779026176704486997 / 1000.0), 16.2, 78, 5.9, '{"created_at":1779026176704486997,"message_id":"collector:americas-1779026176704482977-62","message_type":"weather.packet","payload":{"city":"Los Angeles","continent":"Americas","country":"USA","humidity":78.0,"region":"americas","temperature":16.2,"timestamp":1779026176704,"wind_speed":5.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026160000 / 1000.0), 'Americas', 'USA', 'americas', 'Los Angeles', 1, 16.2, 16.2, 16.2, 78, 5.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026176720183902
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026176715212269-62', 'collector:south_india', 'Asia', 'India', 'south_india', 'Bangalore', to_timestamp(1779026176686 / 1000.0), to_timestamp(1779026176715216933 / 1000.0), 29.5, 45, 10.7, '{"created_at":1779026176715216933,"message_id":"collector:south_india-1779026176715212269-62","message_type":"weather.packet","payload":{"city":"Bangalore","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":29.5,"timestamp":1779026176686,"wind_speed":10.7},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026160000 / 1000.0), 'Asia', 'India', 'south_india', 'Bangalore', 1, 29.5, 29.5, 29.5, 45, 10.7);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026176808781973
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026176804987473-63', 'collector:americas', 'Americas', 'USA', 'americas', 'New York', to_timestamp(1779026176763 / 1000.0), to_timestamp(1779026176804993004 / 1000.0), 25.4, 54, 7.9, '{"created_at":1779026176804993004,"message_id":"collector:americas-1779026176804987473-63","message_type":"weather.packet","payload":{"city":"New York","continent":"Americas","country":"USA","humidity":54.0,"region":"americas","temperature":25.4,"timestamp":1779026176763,"wind_speed":7.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026160000 / 1000.0), 'Americas', 'USA', 'americas', 'New York', 1, 25.4, 25.4, 25.4, 54, 7.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026176900632444
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026176896871622-62', 'collector:europe', 'Europe', 'Europe', 'europe', 'London', to_timestamp(1779026176817 / 1000.0), to_timestamp(1779026176896877345 / 1000.0), 16.1, 39, 13, '{"created_at":1779026176896877345,"message_id":"collector:europe-1779026176896871622-62","message_type":"weather.packet","payload":{"city":"London","continent":"Europe","country":"Europe","humidity":39.0,"region":"europe","temperature":16.1,"timestamp":1779026176817,"wind_speed":13.0},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026160000 / 1000.0), 'Europe', 'Europe', 'europe', 'London', 1, 16.1, 16.1, 16.1, 39, 13);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026178004376512
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026178000427391-63', 'collector:europe', 'Europe', 'Europe', 'europe', 'Paris', to_timestamp(1779026177926 / 1000.0), to_timestamp(1779026178000433764 / 1000.0), 14.3, 76, 9.3, '{"created_at":1779026178000433764,"message_id":"collector:europe-1779026178000427391-63","message_type":"weather.packet","payload":{"city":"Paris","continent":"Europe","country":"Europe","humidity":76.0,"region":"europe","temperature":14.3,"timestamp":1779026177926,"wind_speed":9.3},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026160000 / 1000.0), 'Europe', 'Europe', 'europe', 'Paris', 1, 14.3, 14.3, 14.3, 76, 9.3);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026180278377720
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026180274031686-63', 'collector:south_india', 'Asia', 'India', 'south_india', 'Hyderabad', to_timestamp(1779026180236 / 1000.0), to_timestamp(1779026180274038286 / 1000.0), 33.2, 45, 6.2, '{"created_at":1779026180274038286,"message_id":"collector:south_india-1779026180274031686-63","message_type":"weather.packet","payload":{"city":"Hyderabad","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":33.2,"timestamp":1779026180236,"wind_speed":6.2},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026160000 / 1000.0), 'Asia', 'India', 'south_india', 'Hyderabad', 1, 33.2, 33.2, 33.2, 45, 6.2);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026181692090948
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026181685687086-64', 'collector:north_india', 'Asia', 'India', 'north_india', 'Mumbai', to_timestamp(1779026181685 / 1000.0), to_timestamp(1779026181685695855 / 1000.0), 30.4, 76, 9, '{"created_at":1779026181685695855,"message_id":"collector:north_india-1779026181685687086-64","message_type":"weather.packet","payload":{"city":"Mumbai","continent":"Asia","country":"India","humidity":76.0,"region":"north_india","temperature":30.4,"timestamp":1779026181685,"wind_speed":9.0},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026160000 / 1000.0), 'Asia', 'India', 'north_india', 'Mumbai', 1, 30.4, 30.4, 30.4, 76, 9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026181892049325
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:north_india-1779026181887064976-65', 'collector:north_india', 'Asia', 'India', 'north_india', 'Delhi', to_timestamp(1779026181870 / 1000.0), to_timestamp(1779026181887070063 / 1000.0), 37, 26, 13.6, '{"created_at":1779026181887070063,"message_id":"collector:north_india-1779026181887064976-65","message_type":"weather.packet","payload":{"city":"Delhi","continent":"Asia","country":"India","humidity":26.0,"region":"north_india","temperature":37.0,"timestamp":1779026181870,"wind_speed":13.6},"route":"north_india_aggregator","schema_version":1,"source":"collector:north_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026160000 / 1000.0), 'Asia', 'India', 'north_india', 'Delhi', 1, 37, 37, 37, 26, 13.6);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026181905359833
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026181901770552-64', 'collector:americas', 'Americas', 'USA', 'americas', 'Los Angeles', to_timestamp(1779026181901 / 1000.0), to_timestamp(1779026181901775273 / 1000.0), 16.2, 78, 5.9, '{"created_at":1779026181901775273,"message_id":"collector:americas-1779026181901770552-64","message_type":"weather.packet","payload":{"city":"Los Angeles","continent":"Americas","country":"USA","humidity":78.0,"region":"americas","temperature":16.2,"timestamp":1779026181901,"wind_speed":5.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026160000 / 1000.0), 'Americas', 'USA', 'americas', 'Los Angeles', 1, 16.2, 16.2, 16.2, 78, 5.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026181974861090
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026181970868355-64', 'collector:south_india', 'Asia', 'India', 'south_india', 'Bangalore', to_timestamp(1779026181910 / 1000.0), to_timestamp(1779026181970874174 / 1000.0), 29.5, 45, 10.7, '{"created_at":1779026181970874174,"message_id":"collector:south_india-1779026181970868355-64","message_type":"weather.packet","payload":{"city":"Bangalore","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":29.5,"timestamp":1779026181910,"wind_speed":10.7},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026160000 / 1000.0), 'Asia', 'India', 'south_india', 'Bangalore', 1, 29.5, 29.5, 29.5, 45, 10.7);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026182006267325
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:americas-1779026182002462831-65', 'collector:americas', 'Americas', 'USA', 'americas', 'New York', to_timestamp(1779026181965 / 1000.0), to_timestamp(1779026182002468276 / 1000.0), 25.4, 54, 7.9, '{"created_at":1779026182002468276,"message_id":"collector:americas-1779026182002462831-65","message_type":"weather.packet","payload":{"city":"New York","continent":"Americas","country":"USA","humidity":54.0,"region":"americas","temperature":25.4,"timestamp":1779026181965,"wind_speed":7.9},"route":"americas_aggregator","schema_version":1,"source":"collector:americas"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026160000 / 1000.0), 'Americas', 'USA', 'americas', 'New York', 1, 25.4, 25.4, 25.4, 54, 7.9);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026182142265045
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026182138103869-64', 'collector:europe', 'Europe', 'Europe', 'europe', 'London', to_timestamp(1779026182036 / 1000.0), to_timestamp(1779026182138110343 / 1000.0), 16.1, 39, 13, '{"created_at":1779026182138110343,"message_id":"collector:europe-1779026182138103869-64","message_type":"weather.packet","payload":{"city":"London","continent":"Europe","country":"Europe","humidity":39.0,"region":"europe","temperature":16.1,"timestamp":1779026182036,"wind_speed":13.0},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026160000 / 1000.0), 'Europe', 'Europe', 'europe', 'London', 1, 16.1, 16.1, 16.1, 39, 13);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026183263076569
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:europe-1779026183259226715-65', 'collector:europe', 'Europe', 'Europe', 'europe', 'Paris', to_timestamp(1779026183230 / 1000.0), to_timestamp(1779026183259232442 / 1000.0), 14.3, 76, 9.3, '{"created_at":1779026183259232442,"message_id":"collector:europe-1779026183259226715-65","message_type":"weather.packet","payload":{"city":"Paris","continent":"Europe","country":"Europe","humidity":76.0,"region":"europe","temperature":14.3,"timestamp":1779026183230,"wind_speed":9.3},"route":"europe_aggregator","schema_version":1,"source":"collector:europe"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026160000 / 1000.0), 'Europe', 'Europe', 'europe', 'Paris', 1, 14.3, 14.3, 14.3, 76, 9.3);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

-- batch 1779026185635635359
BEGIN;
INSERT INTO weather_observations_raw (message_id, source, continent, country, region, city, event_time, created_at, temperature, humidity, wind_speed, payload_json) VALUES
  ('collector:south_india-1779026185631783170-65', 'collector:south_india', 'Asia', 'India', 'south_india', 'Hyderabad', to_timestamp(1779026185555 / 1000.0), to_timestamp(1779026185631787702 / 1000.0), 33.2, 45, 6.2, '{"created_at":1779026185631787702,"message_id":"collector:south_india-1779026185631783170-65","message_type":"weather.packet","payload":{"city":"Hyderabad","continent":"Asia","country":"India","humidity":45.0,"region":"south_india","temperature":33.2,"timestamp":1779026185555,"wind_speed":6.2},"route":"south_india_aggregator","schema_version":1,"source":"collector:south_india"}') ON CONFLICT (message_id) DO NOTHING;
INSERT INTO weather_city_minute_aggregates (bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES
  (to_timestamp(1779026160000 / 1000.0), 'Asia', 'India', 'south_india', 'Hyderabad', 1, 33.2, 33.2, 33.2, 45, 6.2);
ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET observation_count = EXCLUDED.observation_count, min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), avg_temperature = EXCLUDED.avg_temperature, avg_humidity = EXCLUDED.avg_humidity, avg_wind_speed = EXCLUDED.avg_wind_speed;
COMMIT;

