
## Debug

- try1

```bash
   58  ll /tmp/tigervnc/unix/xserver/hw/vnc/
   59  apt install libxfont2-dev
   60  apt install libxfont2
   61  bash /build/build.sh  tigervnc
   62  cat tigervnc.log
   63  apt install xfont2-dev
   64  apt install libxfont2
   65  apt install libxfont-dev
   66  vi /build/build.sh 
   67  bash /build/build.sh  tigervnc
   68  apt install xserver-xorg-dev
   69  bash /build/build.sh  tigervnc
   70  apt install util-macros
   71  apt.sh       git autoconf libtool pkg-config gcc g++ make  libssl-dev libpam0g-dev       libjpeg-dev libx11-dev libxfixes-dev libxrandr-dev  flex bison libxml2-dev       intltool xsltproc xutils-dev python-libxml2 g++ xutils libfuse-dev       libmp3lame-dev nasm libpixman-1-dev xserver-xorg-dev
   72  libfdk-aac-dev libopus-dev
   73  apt.sh libfdk-aac-dev libopus-dev
   74  bash /build/build.sh  tigervnc
   75  find ../tigervnc-install/
   76  apt update
   77  apt install libbz2
   78  apt install libbz2*
   79  apt install lib
   80  apt install libbrotlidec-dev
   81  apt install libbrotlidec*
   82  apt install brotlidec*
   83  apt install libmd*
   84  apt install libmd-dev
   85  apt install brotlicommon*
   86  apt install libbrotlicommon*
   87  bash /build/build.sh  tigervnc
   88  vi /build/build.sh 
   89  bash /build/build.sh  tigervnc
   90  vi /build/build.sh 
   91  apt install libbrotli-dev libbz2-dev libmd-dev
   92  bash /build/build.sh  tigervnc
```

- try2: 版本改一致后，依旧有错误

```bash
# ref try2.log
root@bbe0437aff19:/# dpkg -l |grep libgnutls
ii  libgnutls-dane0:amd64          3.6.13-2ubuntu1.8                 amd64        GNU TLS library - DANE security support
ii  libgnutls-openssl27:amd64      3.6.13-2ubuntu1.8                 amd64        GNU TLS library - OpenSSL wrapper
ii  libgnutls28-dev:amd64          3.6.13-2ubuntu1.8                 amd64        GNU TLS library - development files
ii  libgnutls30:amd64              3.6.13-2ubuntu1.8                 amd64        GNU TLS library - main runtime library
ii  libgnutlsxx28:amd64            3.6.13-2ubuntu1.8                 amd64        GNU TLS library - C++ runtime library


# bash /build/build.sh tigervnc
```

- try3: 细分析构建指令，注释sed操作

```bash
# tiger/build.sh
cd /tmp/tigervnc
log "Compiling TigerVNC common libraries and tools..."
make -C /tmp/tigervnc/common -j$(nproc)
make -C /tmp/tigervnc/unix/common -j$(nproc)
make -C /tmp/tigervnc/unix/vncpasswd -j$(nproc)

log "Configuring TigerVNC server..."
autoreconf -fiv /tmp/tigervnc/unix/xserver
(
    cd /tmp/tigervnc/unix/xserver && CFLAGS="$CFLAGS -Wno-implicit-function-declaration" ./configure \
        --build=$(TARGETPLATFORM= xx-clang --print-target-triple) \
        --host=$(xx-clang --print-target-triple) \
        --prefix=/usr \
        --sysconfdir=/etc/X11 \
        --localstatedir=/var \
        --with-xkb-path=${TARGETPATH}/share/X11/xkb \
        --with-xkb-output=/var/lib/xkb \
        --with-xkb-bin-directory=${TARGETPATH}/bin \
        --with-default-font-path=/usr/share/fonts/misc,/usr/share/fonts/100dpi:unscaled,/usr/share/fonts/75dpi:unscaled,/usr/share/fonts/TTF,/usr/share/fonts/Type1 \
        --disable-docs \
        --disable-unit-tests \
        --without-dtrace \
        \
        --with-pic \
        --disable-static \
        --disable-shared \
        \
        --disable-listen-tcp \
        --enable-listen-unix \
        --disable-listen-local \
        \
        --disable-dpms \
        \
        --disable-systemd-logind \
        --disable-config-hal \
        --disable-config-udev \
        --disable-xorg \
        --disable-dmx \
        --disable-libdrm \
        --disable-dri \
        --disable-dri2 \
        --disable-dri3 \
        --disable-present \
        --disable-xvfb \
        --disable-glx \
        --disable-xinerama \
        --disable-record \
        --disable-xf86vidmode \
        --disable-xnest \
        --disable-xquartz \
        --disable-xwayland \
        --disable-xwayland-eglstream \
        --disable-standalone-xpbproxy \
        --disable-xwin \
        --disable-glamor \
        --disable-kdrive \
        --disable-xephyr \
)

###Remove all automatic dependencies on libraries and manually define them to have the correct order.
# find /tmp/tigervnc -name "*.la" -exec sed 's/^dependency_libs/#dependency_libs/' -i {} ';'
# sed 's/^XSERVER_SYS_LIBS = .*/XSERVER_SYS_LIBS = -lXau -lXdmcp -lpixman-1 -ljpeg -lXfont2 -lfreetype -lfontenc -lpng16 -lbrotlidec -lbrotlicommon -lz -lbz2 -lgnutls -lhogweed -lgmp -lnettle -lunistring -ltasn1 -lbsd -lmd/' -i /tmp/tigervnc/unix/xserver/hw/vnc/Makefile

log "Compiling TigerVNC server..."
make -C /tmp/tigervnc/unix/xserver -j$(nproc)

# log "Installing TigerVNC server..."
# make DESTDIR=/tmp/tigervnc-install -C /tmp/tigervnc/unix/xserver install
# log "Installing TigerVNC vncpasswd tool..."
# make DESTDIR=/tmp/tigervnc-install -C /tmp/tigervnc/unix/vncpasswd install






# libz错误
# root@e0dd2368ee99:/tmp/tigervnc/unix/xserver# dpkg -l |grep libz
ii  libz3-4:amd64                  4.8.7-4build1                     amd64        theorem prover from Microsoft Research - runtime libraries
ii  libz3-dev:amd64                4.8.7-4build1                     amd64        theorem prover from Microsoft Research - development files
ii  libzstd1:amd64                 1.4.4+dfsg-3ubuntu0.1             amd64        fast lossless compression algorithm
ii  libzvbi-common                 0.2.35-17                         all          Vertical Blanking Interval decoder (VBI) - common files
ii  libzvbi0:amd64                 0.2.35-17                         amd64        Vertical Blanking Interval decoder (VBI) - runtime files
root@e0dd2368ee99:/tmp/tigervnc/unix/xserver# 
```