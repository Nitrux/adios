# adios-tools
Userspace tools for ADIOS (Adaptive Deadline I/O Scheduler) ADIOS is a block layer I/O scheduler designed for modern multi-queue block devices.

This package provides:

* adiosctl: A utility to monitor and tune scheduler parameters.
* udev rules: Automatically configures the scheduler for supported devices.

Note: This package assumes the ADIOS scheduler is compiled directly into the kernel (CONFIG_MQ_IOSCHED_ADIOS=y).

# Issues
If you find problems with the contents of this repository please create an issue.

©2025 Nitrux Latinoamericana S.C.
