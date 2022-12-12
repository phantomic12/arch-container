FROM archlinux:base-devel

# create build user
RUN useradd --create-home build
RUN echo "build ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# configure default gpg key server to a more reliable one
COPY gpg.conf /home/build/.gnupg/gpg.conf
RUN chown -R build:build /home/build/.gnupg
RUN chmod 700 /home/build/.gnupg
RUN chmod 600 /home/build/.gnupg/gpg.conf

# update keyring first
RUN yes | pacman -Sy archlinux-keyring

# update and install packages
RUN yes | pacman -Syu git wget python-jinja python-srcinfo

USER build
WORKDIR /home/build

# switch back to root for regular usage
USER root
WORKDIR /

# slim image
RUN yes | pacman -Scc
