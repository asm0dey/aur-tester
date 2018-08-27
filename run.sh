#!/bin/bash -x
function cleanup {
    cp -vf /tmp/pkg/*.tar.xz /pkg
}
trap cleanup EXIT
# Make a copy so we never alter the original
mkdir -p /tmp/pkg
cp -rv /pkg/* /tmp/pkg

# Make sure we can RW the copy
chown -Rv notroot /tmp/pkg
chmod -Rv u+rw /tmp/pkg
find /tmp/pkg -type d -exec chmod u+x {} \;

# Do the actual building
cd /tmp/pkg
(
    pwd
    ls -lah
    . ./PKGBUILD
    sudo -u notroot yay -Syu --noconfirm && sudo -u notroot yay -S --noconfirm --needed "${depends[@]}" "${makedepends[@]}"
)
sudo -u notroot makepkg -fsi --noconfirm
