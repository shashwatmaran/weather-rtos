import json
import time
import socket
import threading
import random

# Load Test Config
TARGET_HOST = "localhost"
TARGET_PORT = 13101
NUM_THREADS = 10
MESSAGES_PER_THREAD = 10000

def generate_packet(city):
    return {
        "schema_version": 1,
        "message_id": f"load-test-{city}-{random.randint(0, 1000000)}",
        "source": "load-generator",
        "route": "test-corridor",
        "message_type": "weather.packet",
        "created_at": int(time.time() * 1000),
        "payload": {
            "continent": "Asia",
            "country": "India",
            "region": "south_india",
            "city": city,
            "temperature": random.uniform(20, 40),
            "humidity": random.uniform(40, 80),
            "wind_speed": random.uniform(0, 20),
            "timestamp": int(time.time() * 1000)
        }
    }

def worker(thread_id):
    print(f"Thread {thread_id} starting...")
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    try:
        sock.connect((TARGET_HOST, TARGET_PORT))
        for i in range(MESSAGES_PER_THREAD):
            packet = generate_packet(f"City-{thread_id}")
            msg = json.dumps(packet) + "\n"
            sock.sendall(msg.encode('utf-8'))
            if i % 1000 == 0:
                print(f"Thread {thread_id} sent {i} messages")
    except Exception as e:
        print(f"Thread {thread_id} error: {e}")
    finally:
        sock.close()

if __name__ == "__main__":
    print(f"Starting Load Test: {NUM_THREADS} threads, {MESSAGES_PER_THREAD} msgs each")
    start_time = time.time()
    
    threads = []
    for i in range(NUM_THREADS):
        t = threading.Thread(target=worker, args=(i,))
        t.start()
        threads.append(t)
    
    for t in threads:
        t.join()
        
    duration = time.time() - start_time
    total_msgs = NUM_THREADS * MESSAGES_PER_THREAD
    print(f"\nLoad Test Complete!")
    print(f"Total Messages: {total_msgs}")
    print(f"Total Duration: {duration:.2f} seconds")
    print(f"Throughput: {total_msgs/duration:.2f} msgs/sec")
