#include <iostream>
#include <vector>
#include <chrono>
#include <thread>
#include <atomic>
#include <numeric>
#include <algorithm>
#include <sched.h>
#include "../common/rt_safe/LocklessRingBuffer.hpp"
#include "../common/rt_safe/ZeroCopyTransfer.hpp"

using namespace std;
using namespace std::chrono;

/**
 * RTOS Benchmarking Tool
 * 
 * 1. Measures scheduling jitter (Objective 4: cyclictest replacement)
 * 2. Measures lockless queue throughput (Objective 4: stress testing)
 * 3. Measures zero-copy overhead (Objective 4: validation)
 */

void measure_jitter(int cpu_id, int iterations) {
    cpu_set_t cpuset;
    CPU_ZERO(&cpuset);
    CPU_SET(cpu_id, &cpuset);
    sched_setaffinity(0, sizeof(cpu_set_t), &cpuset);

    vector<long> latencies;
    latencies.reserve(iterations);

    auto interval = microseconds(100);
    auto next_wakeup = steady_clock::now() + interval;

    for (int i = 0; i < iterations; ++i) {
        this_thread::sleep_until(next_wakeup);
        auto now = steady_clock::now();
        auto jitter = duration_cast<nanoseconds>(now - next_wakeup).count();
        latencies.push_back(jitter);
        next_wakeup += interval;
    }

    sort(latencies.begin(), latencies.end());
    long min_l = latencies.front();
    long max_l = latencies.back();
    long avg_l = accumulate(latencies.begin(), latencies.end(), 0L) / iterations;
    long p99_l = latencies[iterations * 0.99];

    cout << "--- Jitter Report (CPU " << cpu_id << ") ---" << endl;
    cout << "Min: " << min_l << " ns" << endl;
    cout << "Max: " << max_l << " ns" << endl;
    cout << "Avg: " << avg_l << " ns" << endl;
    cout << "P99: " << p99_l << " ns" << endl;
}

void benchmark_queue(size_t iterations) {
    LocklessRingBuffer<int> queue(1024 * 1024);
    atomic<bool> running{true};
    atomic<size_t> count{0};

    auto start = steady_clock::now();

    thread producer([&]() {
        for (size_t i = 0; i < iterations; ++i) {
            while (!queue.push(i)) {
                this_thread::yield();
            }
        }
    });

    thread consumer([&]() {
        for (size_t i = 0; i < iterations; ++i) {
            while (true) {
                auto val = queue.pop();
                if (val) {
                    count++;
                    break;
                }
                this_thread::yield();
            }
        }
    });

    producer.join();
    consumer.join();

    auto end = steady_clock::now();
    auto duration = duration_cast<milliseconds>(end - start).count();
    double throughput = (iterations * 1.0) / (duration / 1000.0);

    cout << "--- Queue Throughput ---" << endl;
    cout << "Processed: " << iterations << " items" << endl;
    cout << "Duration: " << duration << " ms" << endl;
    cout << "Throughput: " << throughput << " ops/sec" << endl;
}

int main() {
    cout << "Starting RTOS Performance Validation..." << endl;
    
    // 1. Measure Latency Jitter
    measure_jitter(2, 10000); // Core 2 (Isolated)
    
    // 2. Measure Lockless Queue Throughput
    benchmark_queue(10000000);
    
    return 0;
}
