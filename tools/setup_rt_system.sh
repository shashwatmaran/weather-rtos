#!/bin/bash
# setup_rt_system.sh - Configure Linux for RTOS behavior

set -e

# 1. Memory Optimization: Hugepages
echo "Configuring Hugepages (2MB)..."
echo 1024 > /proc/sys/vm/nr_hugepages
mkdir -p /mnt/huge
mount -t hugetlbfs nodev /mnt/huge

# 2. CPU Isolation (assuming 4 cores, isolate 2-3 for RT)
# Note: This usually requires reboot with isolcpus, but we can use csets/cpusets at runtime
echo "Configuring CPU sets for isolation..."
if [ -d /sys/fs/cgroup/cpuset ]; then
    mkdir -p /sys/fs/cgroup/cpuset/rt_tasks
    echo "2-3" > /sys/fs/cgroup/cpuset/rt_tasks/cpus
    echo "0" > /sys/fs/cgroup/cpuset/rt_tasks/mems
fi

# 3. I/O and Network optimizations
sysctl -w net.core.rmem_max=16777216
sysctl -w net.core.wmem_max=16777216
sysctl -w vm.dirty_ratio=10
sysctl -w vm.dirty_background_ratio=5

# 4. IRQ Affinity (Move IRQs away from isolated cores)
for irq in /proc/irq/*; do
    if [ -d "$irq" ]; then
        echo "1" > "$irq/smp_affinity" 2>/dev/null || true
    fi
done

echo "RT System Setup Complete."
echo "Isolated Cores: 2-3"
echo "Hugepages: $(cat /proc/sys/vm/nr_hugepages)"
