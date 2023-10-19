
# # Get Dockerfile cross-compilation helpers.
# --platform=$BUILDPLATFORM 
FROM tonistiigi/xx AS xx
# # Build UPX.
# FROM alpine:3.15 AS upx
# RUN export domain="mirrors.ustc.edu.cn"; \
#   echo "http://$domain/alpine/v3.15/main" > /etc/apk/repositories; \
#   echo "http://$domain/alpine/v3.15/community" >> /etc/apk/repositories
# #RUN ping -c 2 qq.com; apt update;
# RUN apt.sh build-base curl make cmake git;
# RUN mkdir /tmp/upx && \
#     curl -# -L https://ghproxy.com/https://github.com/upx/upx/releases/download/v4.0.1/upx-4.0.1-src.tar.xz | tar xJ --strip 1 -C /tmp/upx && \
#     make -C /tmp/upx build/release-gcc -j$(nproc) && \
#     cp -v /tmp/upx/build/release-gcc/upx /usr/bin/upx


# FROM alpine:3.15 AS builder
# ARG TARGETPLATFORM
# # https://www.jakehu.me/2021/alpine-mirrors/
# RUN export domain="mirrors.ustc.edu.cn"; \
#   echo "http://$domain/alpine/v3.15/main" > /etc/apk/repositories; \
#   echo "http://$domain/alpine/v3.15/community" >> /etc/apk/repositories

FROM ubuntu:20.04 as stage-base
ENV DEBIAN_FRONTEND noninteractive
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN export DOMAIN="mirrors.ustc.edu.cn"; \
  test -z "$(echo $TARGETPLATFORM |grep arm)" && target=ubuntu || target=ubuntu-ports; \
  echo "deb http://${DOMAIN}/$target focal main restricted universe multiverse" > /etc/apt/sources.list \
  && echo "deb http://${DOMAIN}/$target focal-updates main restricted universe multiverse">> /etc/apt/sources.list; \
  \
  # --no-install-recommends 
  echo 'apt update -qq && apt install -yq $@ && apt clean && rm -rf /var/lib/apt/lists/*; ' > /usr/local/bin/apt.sh \
    && chmod +x /usr/local/bin/apt.sh
#
COPY --from=xx / /
# COPY --from=upx /usr/bin/upx /usr/bin/upx

# BASE
RUN apt.sh \
  htop rsync tree tmux lrzsz wget psmisc openssl net-tools \
  curl sudo iputils-ping procps iproute2 iptables ca-certificates \
  zip unzip xz-utils
# BUILD_common 81M
    RUN apt.sh \
      git autoconf libtool pkg-config gcc g++ make \
      autoconf m4 intltool build-essential dpkg-dev \
      build-essential check
# BUILD_tiger ##########
    # INSTALL dev, dep and sources
    RUN apt update; \
      # 25.6M
      apt install -y --no-install-recommends ca-certificates fakeroot devscripts devscripts binutils wget;

RUN apt.sh make clang \
  upx gawk
# xx-apt
#  libx11-static libxcb-static
RUN apt.sh gcc musl-dev libx11-dev

###TIGERVNC
# log "Installing required Alpine packages..."
# ping -c 2 qq.com
RUN apt.sh \
    curl \
    clang \
    cmake \
    autoconf \
    automake \
    libtool \
    pkgconf \
    meson
    # build-base \
    # util-macros \
    # font-util-dev \
    # xtrans 
# ping -c 2 qq.com
# xx-apt
RUN apt.sh \
    g++ \
    # xcb-util-dev \
    # pixman-dev \
    # libgcrypt-static \
    # libgpg-error-static \
    # libxfont2-dev \
    # libjpeg-turbo-dev \
    libx11-dev \
    libgcrypt-dev \
    libxkbfile-dev \
    nettle-dev \
    libunistring-dev \
    gnutls-dev \
    libxrandr-dev \
    libxtst-dev \
    libfontenc-dev \
    # fltk-dev \
    # freetype-dev \
    # zlib-dev \
    # libx11-static \
    # libxcb-static \
    # zlib-static \
    # pixman-static \
    # libjpeg-turbo-static \
    # freetype-static \
    # libpng-static \
    # bzip2-static \
    # brotli-static \
    # libunistring-static \
    # nettle-static \
    # gettext-static \
    libunistring-dev \
    libbsd-dev 

###XDPY
#  libx11-static libxcb-static
# xx-apt
RUN apt.sh gcc musl-dev libx11-dev


###FONTCONFIG
# log "Installing required Alpine packages..."
RUN apt.sh \
    curl \
    clang \
    gperf \
    python3
    # build-base \
    # pkgconfig \
    # font-croscore 
# xx-apt
RUN apt.sh \
    g++ 
    # glib-dev \
    # freetype-dev \
    # expat-dev 


RUN export DOMAIN="mirrors.ustc.edu.cn"; \
      test -z "$(echo $TARGETPLATFORM |grep arm)" && target=ubuntu || target=ubuntu-ports; \
      echo "deb-src http://$DOMAIN/$target focal main restricted universe multiverse" >> /etc/apt/sources.list; \
      echo "deb-src http://$DOMAIN/$target focal-updates main restricted universe multiverse">> /etc/apt/sources.list; \
      cat /etc/apt/sources.list;
# +DEPS
# pixman-1 libavcodec libavutil libswscale
# libxfont2-dev >> libxfont2 >> libxfont-dev
RUN apt.sh \
  libpixman-1-dev libavcodec-dev libavutil-dev libswscale-dev \
  libjpeg-dev libxfont-dev xserver-xorg-dev \
  libbz2-dev libmd-dev
# /usr/bin/ld: cannot find -lbrotlidec
# /usr/bin/ld: cannot find -lbrotlicommon
# /usr/bin/ld: cannot find -lbz2
# /usr/bin/ld: cannot find -lmd
# BUILD_xrdp ##########
    RUN apt.sh \
      git autoconf libtool pkg-config gcc g++ make  libssl-dev libpam0g-dev \
      libjpeg-dev libx11-dev libxfixes-dev libxrandr-dev  flex bison libxml2-dev \
      intltool xsltproc xutils-dev python-libxml2 g++ xutils libfuse-dev \
      libmp3lame-dev nasm libpixman-1-dev xserver-xorg-dev
    RUN apt.sh \
      libfdk-aac-dev libopus-dev


ENV TARGETPATH=/usr
# COPY --from=cache1 /mnt /mnt
# https://blog.csdn.net/sodaloveer/article/details/127727729 #batch_exec
COPY src/tigervnc/build.sh /build/build.sh
RUN bash /build/build.sh cache
RUN rm -f /bin/sh && ln -s /bin/bash /bin/sh;
# try avoid tiger's deps-err?
# RUN bash /build/build.sh b_deps
# brotli >> libbrotli-dev
RUN apt.sh libbrotli-dev vim-tiny
COPY src/tigervnc /build
# RUN bash /build/build.sh b_tiger
# RUN xx-verify --static /tmp/tigervnc-install/usr/bin/Xvnc; \
#   xx-verify --static /tmp/tigervnc-install/usr/bin/vncpasswd
# RUN upx /tmp/tigervnc-install/usr/bin/Xvnc; \
#   upx /tmp/tigervnc-install/usr/bin/vncpasswd

# RUN rm -rf /rootfs; mkdir -p /rootfs${TARGETPATH}/bin /rootfs${TARGETPATH}/share/X11; \
#   \cp -a /tmp/tigervnc-install/usr/bin/Xvnc /rootfs${TARGETPATH}/bin/; \
#   \cp -a /tmp/tigervnc-install/usr/bin/vncpasswd /rootfs${TARGETPATH}/bin/; \
#   \cp -a /tmp/xkb-install/usr/share/X11/xkb /rootfs${TARGETPATH}/share/X11/xkb; \
#   \cp -a /tmp/xkbcomp-install/usr/bin/xkbcomp /rootfs${TARGETPATH}/bin/; \
#   #\cp -a /tmp/xdpyprobe/xdpyprobe /rootfs${TARGETPATH}/bin/; \
#   \cp -a /tmp/logs /rootfs/

# # validate
# RUN du -sh /rootfs; \
#   /rootfs/usr/bin/Xvnc -version; \
#   find /rootfs -type f |sort