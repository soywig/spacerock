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
cat > /usr/share/glib-2.0/schemas/zz0-99-moonrock.gschema.override << 'EOF'
[org.gnome.shell]
enabled-extensions=['dash-to-dock@micxgx.gmail.com', 'logomenu@aryan_k', 'appindicatorsupport@rgcjonas.gmail.com', 'user-theme@gnome-shell-extensions.gcampax.github.com', 'gsconnect@andyholmes.github.io', 'blur-my-shell@aunetx', 'hotedge@jonathan.jdoda.ca', 'caffeine@patapon.info', 'add-to-steam@pupper.space', 'restartto@tiagoporsch.github.io', 'compiz-alike-magic-lamp-effect@hermes83.github.com', 'bazaar-integration@kolunmi.github.io']
EOF
glib-compile-schemas /usr/share/glib-2.0/schemas/

# block unwanted flatpaks from being installed on first boot 
cat >> /usr/share/ublue-os/flatpak-blocklist << 'EOF'
deny com.github.Matoking.protontricks/*
deny com.github.tchx84.Flatseal/*
deny com.ranfdev.DistroShelf/*
deny com.vysp3r.ProtonPlus/*
deny io.github.flattool.Warehouse/*
EOF

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket
