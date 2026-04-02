#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf5 install -y tmux gnome-shell-extension-dash-to-dock

# enable dash to dock
cat > /usr/share/glib-2.0/schemas/99-moonrock.gschema.override << 'EOF'
[org.gnome.shell]
enabled-extensions=['dash-to-dock@micxgx.gmail.com']
EOF
glib-compile-schemas /usr/share/glib-2.0/schemas/

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket
