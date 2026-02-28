#!/bin/bash
# Script to build Debian package using git-buildpackage

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "=== Building Debian package with git-buildpackage ==="

# Check if we're in the right directory
if [ ! -f "debian/control" ]; then
    echo "Error: debian/control not found. Please run from the debian directory."
    exit 1
fi

# Check if gbp is available
if ! command -v gbp buildpackage &> /dev/null; then
    echo "Error: git-buildpackage (gbp) is not installed."
    echo "Install it with: apt-get install git-buildpackage"
    exit 1
fi

# Build the package
gbp buildpackage --git-builder="debuild -S -uc -us" --git-export-dir=/tmp/build-area

echo "=== Build complete ==="
echo "Package created in /tmp/build-area/"
