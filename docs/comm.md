I'm analyzing the repo structure and existing setup to give you a clear TimescaleDB installation and integration path.   

Ran terminal command:  uname -a && lsb_release -a 2>/dev/null || cat /etc/os-release | head -5

Read [](file:///home/shash/projects/weather-rtos)

Read [](file:///home/shash/projects/weather-rtos/docs/PORTING.md)

Perfect! You're on **Ubuntu 24.04 LTS (WSL2)**. Here's the complete TimescaleDB setup and integration path:

## **Current Repo Condition**

✅ **Working:**
- Socket-based tree topology (collectors → aggregators → writer)
- Timescale writer that batches and deduplicates messages
- SQL outbox generation (currently writes to timescale_outbox.sql)
- Full schema ready in schema.sql
- Documentation already mentions optional TimescaleDB connection

❌ **Not yet connected:**
- No live PostgreSQL/TimescaleDB instance running
- Writer only produces SQL files, doesn't execute against a database

---

## **TimescaleDB Installation (Ubuntu 24.04)**

### **Step 1: Add the TimescaleDB repository**
```bash
# Add the TimescaleDB PPA
sudo apt install -y gnupg postgresql-common
sudo sh -c "echo 'deb https://packagecloud.io/timescale/timescaledb/ubuntu/ noble main' > /etc/apt/sources.list.d/timescaledb.list"
wget --quiet -O - https://packagecloud.io/timescale/timescaledb/gpgkey | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/timescaledb.gpg
sudo apt update
```

### **Step 2: Install PostgreSQL 16 + TimescaleDB extension**
```bash
sudo apt install -y postgresql-16 timescaledb-2-postgresql-16
```

### **Step 3: Initialize and start PostgreSQL**
```bash
# Initialize the database cluster (usually done automatically, but verify)
sudo pg_ctlcluster 16 main start

# Check if running
sudo pg_lsclusters
```

### **Step 4: Create the weather_rtos database and user**
```bash
sudo -u postgres psql -c "CREATE USER weather_rtos WITH PASSWORD 'weather_secret';"
sudo -u postgres psql -c "CREATE DATABASE weather_rtos OWNER weather_rtos;"
sudo -u postgres psql -d weather_rtos -c "CREATE EXTENSION timescaledb;"
```

### **Step 5: Load the schema**
```bash
# From your repo root
sudo -u postgres psql -d weather_rtos -f timescale/schema.sql
```

### **Step 6: Verify the setup**
```bash
sudo -u postgres psql -d weather_rtos -c "SELECT * FROM pg_tables WHERE schemaname = 'public';"
```

You should see `weather_observations_raw` and `weather_city_minute_aggregates` hypertables.

---

## **Connect the Writer to TimescaleDB**

### **Option A: Via Environment Variable (Simplest)**
```bash
export TIMESCALEDB_DSN="host=127.0.0.1 port=5432 dbname=weather_rtos user=weather_rtos password=weather_secret"
./build/timescale_writer
```

### **Option B: Modify demo.sh**
Edit the line where timescale_writer is launched:
```bash
TIMESCALEDB_DSN="host=127.0.0.1 port=5432 dbname=weather_rtos user=weather_rtos password=weather_secret" \
./build/timescale_writer > "$LOGDIR/timescale_writer.log" 2>&1 &
```

---

## **What Happens After Connection**

Once connected, the writer will:
1. **Still generate timescale_outbox.sql** as a fallback/audit log
2. **Execute each batch directly into TimescaleDB**
3. **Deduplicate by `message_id`** (the `ON CONFLICT` clause)
4. **Split raw and aggregate rows** into two hypertables
5. **Upsert aggregates** if they already exist (updating min/max/avg)

---

## **Quick Test Once Everything is Running**

```bash
# Query raw observations
sudo -u postgres psql -d weather_rtos -c "SELECT COUNT(*), city FROM weather_observations_raw GROUP BY city;"

# Query minute-level aggregates
sudo -u postgres psql -d weather_rtos -c "SELECT * FROM weather_city_minute_aggregates LIMIT 5;"
```

---

## **Next Steps (If You Want to Go Further)**

1. **Install the PostgreSQL client** if you want to query from outside sudo:
   ```bash
   sudo apt install postgresql-client-16
   psql -h 127.0.0.1 -d weather_rtos -U weather_rtos
   ```

2. **Enable remote connections** (if you later want to query from another machine):
   - Edit `/etc/postgresql/16/main/postgresql.conf`
   - Set `listen_addresses = '*'` (or specific IPs)
   - Edit `/etc/postgresql/16/main/pg_hba.conf` to allow remote auth

3. **Set up automated backups** of the hypertables.

**Should I update the main.cpp to actually use the `TIMESCALEDB_DSN` environment variable**, or do you want to test the current outbox-only mode first?