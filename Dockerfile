FROM base/archlinux

# makepkg cannot (and should not) be run as root:
RUN useradd -m notroot && \
    echo '[multilib]' >> /etc/pacman.conf && \
    echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf && \
    pacman -Sy --noconfirm --needed base-devel git && \
    echo "notroot ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/notroot && \
    sudo -u notroot mkdir /home/notroot/.gnupg && \
    sudo -u notroot touch /home/notroot/.gnupg/gpg.conf && \
    sudo -u notroot echo "keyserver-options auto-key-retrieve" > /home/notroot/.gnupg/gpg.conf && \
    cd ~notroot && \
    sudo -u notroot git clone https://aur.archlinux.org/yay.git && \
    cd yay && \
    sudo -u notroot makepkg -si --noconfirm && \
    cd .. && \
    sudo -u notroot rm -rf yay

WORKDIR /pkg
CMD /bin/sh /run.sh
COPY run.sh /run.sh
