FROM archlinux/base
LABEL maintainer="pavel.finkelshtein@gmail.com" \
      org.label-schema.name="aur-tester" \
      org.label-schema.description="Image for testing packages, intended to be published in AUR" \
      org.label-schema.vcs-url="https://github.com/asm0dey/aur-tester" \
      org.label-schema.schema-version="1.0"

RUN useradd -m notroot && \
    # Enable multilib
    echo '[multilib]' >> /etc/pacman.conf && \ 
    echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf && \
    # Install development tools and git (for futher yay installation)
    pacman -Sy --noconfirm --needed base-devel git && \ 
    # Allow running pacman without entering password to non-root user
    echo "notroot ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/notroot && \ 
    sudo -u notroot mkdir /home/notroot/.gnupg && \
    sudo -u notroot touch /home/notroot/.gnupg/gpg.conf && \
    sudo -u notroot echo "keyserver-options auto-key-retrieve" > /home/notroot/.gnupg/gpg.conf && \
    cd ~notroot && \
    sudo -u notroot git clone https://aur.archlinux.org/yay.git && \
    cd yay && \
    sudo -u notroot makepkg -si --noconfirm && \
    cd .. && \
    sudo -u notroot rm -rf yay && \
    pacman -S --noconfirm reflector && \
    reflector --country Russia --sort rate --save /etc/pacman.d/mirrorlist

WORKDIR /pkg
CMD /bin/sh /run.sh
COPY run.sh /run.sh
