
# Get Dockerfile cross-compilation helpers.
# --platform=$BUILDPLATFORM 
FROM tonistiigi/xx AS xx

# Build UPX.
FROM alpine:3.15 AS upx
RUN export domain="mirrors.ustc.edu.cn"; \
  echo "http://$domain/alpine/v3.15/main" > /etc/apk/repositories; \
  echo "http://$domain/alpine/v3.15/community" >> /etc/apk/repositories
#RUN ping -c 2 qq.com; apt update;
RUN apt update; apt.sh build-base curl make cmake git;
RUN mkdir /tmp/upx && \
    curl -# -L https://ghproxy.com/https://github.com/upx/upx/releases/download/v4.0.1/upx-4.0.1-src.tar.xz | tar xJ --strip 1 -C /tmp/upx && \
    make -C /tmp/upx build/release-gcc -j$(nproc) && \
    cp -v /tmp/upx/build/release-gcc/upx /usr/bin/upx


FROM alpine:3.15 AS builder
ARG TARGETPLATFORM
# https://www.jakehu.me/2021/alpine-mirrors/
# domain="mirrors.ustc.edu.cn"
# domain="mirrors.aliyun.com";
# mirrors.tuna.tsinghua.edu.cn
RUN export domain="mirrors.ustc.edu.cn"; \
  echo "http://$domain/alpine/v3.15/main" > /etc/apk/repositories; \
  echo "http://$domain/alpine/v3.15/community" >> /etc/apk/repositories
#
COPY --from=xx / /
COPY --from=upx /usr/bin/upx /usr/bin/upx
RUN apt update; apt.sh make clang
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
RUN apt.sh \
    g++ 
    # glib-dev \
    # freetype-dev \
    # expat-dev 

