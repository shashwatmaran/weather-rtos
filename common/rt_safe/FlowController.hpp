#pragma once

#include <atomic>
#include <chrono>
#include <thread>

/**
 * RT-Safe Flow Controller
 * 
 * Implements token bucket algorithm for rate limiting and backpressure.
 * Prevents memory overflow during data spikes.
 */
class FlowController {
public:
    FlowController(size_t ratePerSecond, size_t burstSize)
        : rate_(ratePerSecond), burst_(burstSize), tokens_(burstSize) {
        lastUpdate_ = std::chrono::steady_clock::now();
    }

    /**
     * Check if processing is allowed.
     * Blocks if tokens are exhausted to enforce flow control.
     */
    void acquire(size_t tokens) {
        while (true) {
            updateTokens();
            size_t current = tokens_.load(std::memory_order_acquire);
            if (current >= tokens) {
                if (tokens_.compare_exchange_weak(current, current - tokens)) {
                    return;
                }
            } else {
                // Backpressure: wait for more tokens
                std::this_thread::yield();
            }
        }
    }

    bool tryAcquire(size_t tokens) {
        updateTokens();
        size_t current = tokens_.load(std::memory_order_acquire);
        if (current >= tokens) {
            return tokens_.compare_exchange_strong(current, current - tokens);
        }
        return false;
    }

private:
    void updateTokens() {
        auto now = std::chrono::steady_clock::now();
        auto duration = std::chrono::duration_cast<std::chrono::microseconds>(now - lastUpdate_).count();
        
        if (duration > 1000) { // Update every 1ms
            size_t newTokens = (duration * rate_) / 1000000;
            if (newTokens > 0) {
                size_t current = tokens_.load(std::memory_order_acquire);
                size_t next = std::min(burst_, current + newTokens);
                tokens_.store(next, std::memory_order_release);
                lastUpdate_ = now;
            }
        }
    }

    size_t rate_;
    size_t burst_;
    std::atomic<size_t> tokens_;
    std::chrono::steady_clock::time_point lastUpdate_;
};
