#!/usr/bin/env bash

# SPDX-License-Identifier: BSD-3-Clause
# Copyright 2025 <Nitrux Latinoamericana S.C. <hello@nxos.org>>


# -- Exit on errors.

set -e


# -- Download Source.

SRC_DIR="$(mktemp -d)"
git clone --depth 1 --branch "$ADIOS_BRANCH" https://github.com/firelzrd/adios.git "$SRC_DIR/adios-src"

cd "$SRC_DIR/adios-src"


# -- Configure packaging.

BIN_DIR="$SRC_DIR/package/usr/bin"
UDEV_DIR="$SRC_DIR/package/usr/lib/udev/rules.d"
DEBIAN_DIR="$SRC_DIR/package/DEBIAN"

mkdir -p "$BIN_DIR"
mkdir -p "$UDEV_DIR"
mkdir -p "$DEBIAN_DIR"


if [ -f "scripts/adiosctl" ]; then
    cp scripts/adiosctl "$BIN_DIR/"
    chmod 755 "$BIN_DIR/adiosctl"
else
    echo "Error: scripts/adiosctl not found in source!"
    exit 1
fi

cp udev-rules/*.rules "$UDEV_DIR/"

cat <<EOF > "$DEBIAN_DIR/control"
Package: adios-tools
Version: $PACKAGE_VERSION
Architecture: all
Maintainer: Nitrux Latinoamericana S.C. <hello@nxos.org>
Depends: ruby
Section: admin
Priority: optional
Description: Userspace tools for ADIOS (Adaptive Deadline I/O Scheduler)
 ADIOS is a block layer I/O scheduler designed for modern multi-queue
 block devices.
 .
 This package provides:
  * adiosctl: A utility to monitor and tune scheduler parameters.
  * udev rules: Automatically configures the scheduler for supported devices.
 .
 Note: This package assumes the ADIOS scheduler is compiled directly
 into the kernel (CONFIG_MQ_IOSCHED_ADIOS=y).
EOF


# -- Build the Package.

dpkg-deb --build "$SRC_DIR/package" "${PKG_NAME}_${VERSION}_${ARCH}.deb"
