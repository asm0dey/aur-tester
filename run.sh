#!/bin/bash
function cleanup {
    cp -vf /tmp/pkg/*.tar.* /pkg
}
trap cleanup EXIT
# Make a copy so we never alter the original
cp -r /pkg /tmp/pkg

# Make sure we can RW the copy
chown -R notroot /tmp/pkg
chmod -R u+rw /tmp/pkg
find /tmp/pkg -type d -exec chmod u+x {} \;

# Do the actual building
cd /tmp/pkg
(
    set -x
    cd /tmp/pkg
    . ./PKGBUILD
    sudo -u notroot yay -Syu --noconfirm && sudo -u notroot yay -S --noconfirm --needed "${depends[@]}" "${makedepends[@]}"
    set +x
)
sudo -u notroot makepkg -fsi --noconfirm
