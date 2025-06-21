#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf install -y udica

# install latest rclone
dnf install -y https://downloads.rclone.org/rclone-current-linux-amd64.rpm

# https://rclone.org/commands/rclone_mount/#rclone-as-unix-mount-helper
ln -rs /usr/bin/rclone /sbin/mount.rclone
ln -rs /usr/bin/rclone /usr/bin/rclonefs

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket

# needed for nvidia gpu container useage

nvidia-ctk cdi generate
