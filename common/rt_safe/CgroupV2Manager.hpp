#pragma once

#include <string>
#include <fstream>
#include <filesystem>
#include <iostream>
#include <unistd.h>

/**
 * Cgroup V2 Manager for Resource Isolation and QoS
 * 
 * Enforces CPU, Memory, and I/O bandwidth limits on RT tasks.
 */
class CgroupV2Manager {
public:
    explicit CgroupV2Manager(std::string groupName) 
        : basePath_("/sys/fs/cgroup/" + groupName) {
        std::filesystem::create_directories(basePath_);
    }

    /**
     * Set CPU weight (QoS priority)
     */
    void setCpuWeight(int weight) {
        writeValue("cpu.weight", std::to_string(weight));
    }

    /**
     * Set Memory hard limit
     */
    void setMemoryLimit(long bytes) {
        writeValue("memory.max", std::to_string(bytes));
    }

    /**
     * Set I/O Read/Write bandwidth limits (bps)
     */
    void setIoLimit(int major, int minor, long rbps, long wbps) {
        std::string limit = std::to_string(major) + ":" + std::to_string(minor) + 
                           " rbps=" + std::to_string(rbps) + 
                           " wbps=" + std::to_string(wbps);
        writeValue("io.max", limit);
    }

    /**
     * Add current process to the cgroup
     */
    void addCurrentProcess() {
        writeValue("cgroup.procs", std::to_string(getpid()));
    }

private:
    void writeValue(const std::string& filename, const std::string& value) {
        std::ofstream file(basePath_ + "/" + filename);
        if (file.is_open()) {
            file << value;
        } else {
            std::cerr << "Failed to write to cgroup: " << filename << std::endl;
        }
    }

    std::string basePath_;
};
