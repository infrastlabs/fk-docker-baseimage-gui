

```bash
# xrdp
ver="0.9.23" #0.9.16
file=xrdp-${ver}.tar.gz; test -s $file || curl -k -O -fSL https://github.com/neutrinolabs/xrdp/releases/download/v${ver}/$file

# tiger
file=xorg-server-1.20.7.tar.bz2; test -s $file || curl -k -O -fSL https://www.x.org/pub/individual/xserver/$file #6.1M
file=tigervnc-1.12.0.tar.gz; test -s $file || curl -k -O -fSL https://github.com/TigerVNC/tigervnc/archive/v1.12.0/$file #1.5M
# curl -O -fsSL https://www.linuxfromscratch.org/patches/blfs/svn/tigervnc-1.12.0-configuration_fixes-1.patch
```

```dockerfile
###xrdp, xorgxrdp###############################################
FROM stage-base as stage-xrdp
ARG COMPILE_XRDP="yes"
#0.9.5 > 0.9.16 > 0.9.19(thunar@gemmi-deb11卡死)
# 0.9.16 > 0.9.23 #0.9.16@deb12: cc1-openssl3-warn-as-err
ENV ver="0.9.23"
# https://hub.fastgit.org/neutrinolabs/xrdp/wiki/Building-on-Debian-8
# configure: error: please install libfdk-aac-dev or fdk-aac-devel
		# --enable-tjpeg \
# ./configure --prefix=/usr/local/xrdp --enable-fuse --enable-mp3lame --enable-pixman;\
ADD src/arm /src/arm
# RUN wget https://github.com/neutrinolabs/xrdp/releases/download/v${ver}/xrdp-${ver}.tar.gz; \
RUN mkdir -p /usr/local/xrdp
RUN test "yes" != "$COMPILE_XRDP" && exit 0 || echo doMake; \
tar -zxf /src/arm/xrdp-${ver}.tar.gz;\
cd xrdp-${ver};\
./bootstrap;\
./configure \
		--prefix=/usr/local/xrdp \
		--enable-vsock \
		--enable-fdkaac \
		--enable-opus \
		--enable-fuse \
		--enable-mp3lame \
		--enable-pixman \
		CFLAGS='-Wno-format';\
make;\
make install;

#####git clone; xorgxrdp with xrdp --prefix, testOK;
# # gitee.com/g-system/xorgxrdp
# RUN git clone --branch br-0214 https://gitee.com/g-system/xorgxrdp;\
# cd xorgxrdp;\
# ./bootstrap;\
# CPPFLAGS="-I/usr/local/xrdp/include"  LDFLAGS="-L/usr/local/xrdp/lib" ./configure;\
# make;\
# sudo make install;

###pulseaudio-module-xrdp###############################################
# pulse-xrdp: git-latest
FROM stage-base as stage-pulse
ARG COMPILE_PULSE="yes"
#### pulseaudio-module-xrdp >> pulseaudio ver: 10.0
# RUN git submodule update --init --recursive
RUN mkdir -p /var/lib/xrdp-pulseaudio-installer; \
  \
  test "yes" != "$COMPILE_PULSE" && exit 0 || echo doMake; \
  apt update && apt build-dep -q -y pulseaudio && \
  cd /opt && apt source pulseaudio && \
  pulseaudio=$(pulseaudio --version | awk '{print $2}') && \
  cd /opt/pulseaudio-${pulseaudio} && ./configure
# RUN pulseaudio=$(pulseaudio --version); echo "pulseaudio: $pulseaudio"
# hand copy: /opt/pulseaudio-1.11/config.h +src/pulsecore
# https://github.com/neutrinolabs/pulseaudio-module-xrdp.git
# https://gitee.com/g-system/pulseaudio-module-xrdp.git
RUN test "yes" != "$COMPILE_PULSE" && exit 0 || echo doMake; \
  cd /opt && git clone --branch v0.5 https://gitee.com/g-system/pulseaudio-module-xrdp.git && \
  cd /opt/pulseaudio-module-xrdp ;\
  pulseaudio=$(pulseaudio --version | awk '{print $2}') && echo "pulseaudio ver: $pulseaudio" && \
  ./bootstrap && ./configure PULSE_DIR="/opt/pulseaudio-${pulseaudio}"; \
  cp -a /opt/pulseaudio-${pulseaudio}/config.h . && cp -a /opt/pulseaudio-${pulseaudio}/src/pulsecore/ .; \
  make && \
  cd /opt/pulseaudio-module-xrdp/src/.libs && \
  install -t "/var/lib/xrdp-pulseaudio-installer" -D -m 644 *.so;

```