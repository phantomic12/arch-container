FROM archlinux:base-devel

# create build user
RUN useradd --create-home build
RUN echo "build ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# update keyring first
RUN yes | pacman -Sy archlinux-keyring

# update and install packages
RUN yes | pacman -Syu git wget python-jinja python-srcinfo sshpass

USER build
WORKDIR /home/build

# switch back to root for regular usage
USER root
WORKDIR /

# slim image
RUN yes | pacman -Scc
