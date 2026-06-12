#pragma once

#include <atomic>
#include <vector>
#include <optional>
#include <stdexcept>

/**
 * RT-Safe Lockless Ring Buffer (Single-Producer, Single-Consumer)
 * 
 * Optimized for low-latency IPC and RTOS requirements.
 * Uses atomic head/tail pointers with acquire/release semantics.
 */
template <typename T>
class LocklessRingBuffer {
public:
    explicit LocklessRingBuffer(size_t capacity)
        : capacity_(capacity), mask_(capacity - 1), buffer_(capacity) {
        // Capacity must be a power of 2 for the mask trick
        if ((capacity & (capacity - 1)) != 0) {
            throw std::invalid_argument("Capacity must be a power of 2");
        }
        head_.store(0, std::memory_order_relaxed);
        tail_.store(0, std::memory_order_relaxed);
    }

    /**
     * Push an item into the buffer.
     * Non-blocking, returns false if full.
     */
    bool push(const T& item) {
        const size_t current_tail = tail_.load(std::memory_order_relaxed);
        const size_t next_tail = (current_tail + 1) & mask_;

        if (next_tail == head_.load(std::memory_order_acquire)) {
            return false; // Buffer full
        }

        buffer_[current_tail] = item;
        tail_.store(next_tail, std::memory_order_release);
        return true;
    }

    /**
     * Pop an item from the buffer.
     * Non-blocking, returns std::nullopt if empty.
     */
    std::optional<T> pop() {
        const size_t current_head = head_.load(std::memory_order_relaxed);

        if (current_head == tail_.load(std::memory_order_acquire)) {
            return std::nullopt; // Buffer empty
        }

        T item = buffer_[current_head];
        head_.store((current_head + 1) & mask_, std::memory_order_release);
        return item;
    }

    size_t size() const {
        size_t h = head_.load(std::memory_order_acquire);
        size_t t = tail_.load(std::memory_order_acquire);
        if (t >= h) return t - h;
        return (capacity_ - h) + t;
    }

    bool empty() const {
        return head_.load(std::memory_order_acquire) == tail_.load(std::memory_order_acquire);
    }

private:
    const size_t capacity_;
    const size_t mask_;
    std::vector<T> buffer_;

    alignas(64) std::atomic<size_t> head_;
    alignas(64) std::atomic<size_t> tail_;
};
