
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

- try2

```bash
# ref try2.log
root@bbe0437aff19:/# dpkg -l |grep libgnutls
ii  libgnutls-dane0:amd64          3.6.13-2ubuntu1.8                 amd64        GNU TLS library - DANE security support
ii  libgnutls-openssl27:amd64      3.6.13-2ubuntu1.8                 amd64        GNU TLS library - OpenSSL wrapper
ii  libgnutls28-dev:amd64          3.6.13-2ubuntu1.8                 amd64        GNU TLS library - development files
ii  libgnutls30:amd64              3.6.13-2ubuntu1.8                 amd64        GNU TLS library - main runtime library
ii  libgnutlsxx28:amd64            3.6.13-2ubuntu1.8                 amd64        GNU TLS library - C++ runtime library
```