#pragma once

#include <fcntl.h>
#include <unistd.h>
#include <iostream>
#include <sys/stat.h>
#include <sys/sendfile.h>

/**
 * Zero-Copy Data Transfer Utility
 * 
 * Uses Linux splice() to move data between file descriptors (e.g., socket to file)
 * without copying data through user-space.
 */
class ZeroCopyTransfer {
public:
    /**
     * Splice data from an input FD to an output FD via a pipe.
     * This achieves zero-copy by moving kernel pages directly.
     */
    static ssize_t transfer(int fd_in, int fd_out, size_t size) {
        int pipe_fds[2];
        if (pipe(pipe_fds) < 0) {
            perror("pipe");
            return -1;
        }

        // Move from fd_in to pipe
        ssize_t spliced_in = splice(fd_in, nullptr, pipe_fds[1], nullptr, size, SPLICE_F_MOVE | SPLICE_F_MORE);
        if (spliced_in < 0) {
            perror("splice in");
            close(pipe_fds[0]);
            close(pipe_fds[1]);
            return -1;
        }

        // Move from pipe to fd_out
        ssize_t spliced_out = splice(pipe_fds[0], nullptr, fd_out, nullptr, spliced_in, SPLICE_F_MOVE | SPLICE_F_MORE);
        if (spliced_out < 0) {
            perror("splice out");
            close(pipe_fds[0]);
            close(pipe_fds[1]);
            return -1;
        }

        close(pipe_fds[0]);
        close(pipe_fds[1]);
        return spliced_out;
    }

    /**
     * Sendfile implementation for zero-copy file-to-socket transfers.
     */
    static ssize_t sendFile(int out_fd, int in_fd, off_t* offset, size_t count) {
        return sendfile(out_fd, in_fd, offset, count);
    }
};
