-- Schema for Personal Comparative Analytics & Actuation
-- Apply after timescale/schema.sql

CREATE TABLE IF NOT EXISTS personal_historical_baselines (
    profile_id TEXT NOT NULL,
    hour_of_day INT NOT NULL CHECK (hour_of_day >= 0 AND hour_of_day <= 23),
    baseline_value DOUBLE PRECISION NOT NULL,
    PRIMARY KEY (profile_id, hour_of_day)
);

CREATE TABLE IF NOT EXISTS personal_realtime_comparisons (
    event_time TIMESTAMPTZ NOT NULL,
    profile_id TEXT NOT NULL,
    live_value DOUBLE PRECISION NOT NULL,
    baseline_value DOUBLE PRECISION NOT NULL,
    variance DOUBLE PRECISION NOT NULL,
    actuation_active BOOLEAN NOT NULL,
    PRIMARY KEY (event_time, profile_id)
);

SELECT create_hypertable('personal_realtime_comparisons', 'event_time', if_not_exists => TRUE);

-- Create indexes for quick retrieval
CREATE INDEX IF NOT EXISTS idx_personal_comp_profile_time 
    ON personal_realtime_comparisons (profile_id, event_time DESC);

-- Seed Crop Soil Moisture optimal targets (hourly profile, % moisture)
INSERT INTO personal_historical_baselines (profile_id, hour_of_day, baseline_value) VALUES
('crop_moisture', 0, 45.0),
('crop_moisture', 1, 45.0),
('crop_moisture', 2, 45.0),
('crop_moisture', 3, 45.0),
('crop_moisture', 4, 46.0),
('crop_moisture', 5, 46.0),
('crop_moisture', 6, 48.0),
('crop_moisture', 7, 50.0),
('crop_moisture', 8, 52.0),
('crop_moisture', 9, 55.0),
('crop_moisture', 10, 58.0),
('crop_moisture', 11, 60.0),
('crop_moisture', 12, 60.0),
('crop_moisture', 13, 60.0),
('crop_moisture', 14, 58.0),
('crop_moisture', 15, 55.0),
('crop_moisture', 16, 52.0),
('crop_moisture', 17, 50.0),
('crop_moisture', 18, 48.0),
('crop_moisture', 19, 46.0),
('crop_moisture', 20, 46.0),
('crop_moisture', 21, 45.0),
('crop_moisture', 22, 45.0),
('crop_moisture', 23, 45.0)
ON CONFLICT (profile_id, hour_of_day) DO UPDATE SET baseline_value = EXCLUDED.baseline_value;

-- Seed Smart Grid Power Consumption target profile (hourly baseline, kW limit)
INSERT INTO personal_historical_baselines (profile_id, hour_of_day, baseline_value) VALUES
('power_consumption', 0, 1.2),
('power_consumption', 1, 1.0),
('power_consumption', 2, 0.9),
('power_consumption', 3, 0.9),
('power_consumption', 4, 1.0),
('power_consumption', 5, 1.5),
('power_consumption', 6, 2.2),
('power_consumption', 7, 3.5),
('power_consumption', 8, 4.2),
('power_consumption', 9, 3.8),
('power_consumption', 10, 3.0),
('power_consumption', 11, 2.8),
('power_consumption', 12, 3.2),
('power_consumption', 13, 3.5),
('power_consumption', 14, 3.0),
('power_consumption', 15, 2.8),
('power_consumption', 16, 3.2),
('power_consumption', 17, 4.5),
('power_consumption', 18, 5.5),
('power_consumption', 19, 5.8),
('power_consumption', 20, 5.0),
('power_consumption', 21, 3.8),
('power_consumption', 22, 2.5),
('power_consumption', 23, 1.8)
ON CONFLICT (profile_id, hour_of_day) DO UPDATE SET baseline_value = EXCLUDED.baseline_value;
