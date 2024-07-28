# base pre-built cross image
ARG CROSS_BASE_IMAGE
FROM $CROSS_BASE_IMAGE

# add our foreign architecture and install our dependencies
ENV CROSS_DEB_ARCH="armhf"
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils
RUN dpkg --add-architecture $CROSS_DEB_ARCH
RUN apt-get update && apt-get --assume-yes install libgbm1:$CROSS_DEB_ARCH libxkbcommon-dev:$CROSS_DEB_ARCH libudev-dev:$CROSS_DEB_ARCH libc6:$CROSS_DEB_ARCH libinput-dev:$CROSS_DEB_ARCH

# add our linker search paths and link arguments
ENV CARGO_TARGET_ARMV7_UNKNOWN_LINUX_GNUEABIHF_RUSTFLAGS="-L /usr/lib/arm-linux-gnueabihf -C link-args=-Wl,-rpath-link,/usr/lib/arm-linux-gnueabihf $CARGO_TARGET_ARMV7_UNKNOWN_LINUX_GNUEABIHF_RUSTFLAGS"
