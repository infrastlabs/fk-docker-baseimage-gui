
- xdpyprobe
- fluxbox TODO 
- xrdp TODO #https://github.com/neutrinolabs/xrdp
- tigervnc https://github.com/TigerVNC/tigervnc
  - xorg-server https://github.com/XQuartz/xorg-server #https://gitlab.freedesktop.org/xorg/xserver
  - tiger-static `-DENABLE_GNUTLS=OFF`@deb12/ubt2004
  - xkb
  - xkbcomp
- oth
  - fontconfig
  - openbox
  - yad
  - nginx/novnc


deb12_glibc环境/clang编译, +pam/static.patch `-DENABLE_GNUTLS=OFF`

```bash
# env: alpine315> ubt2004(armv7_gcc_err)> deb12

# deb12-static: 
#  -DENABLE_GNUTLS=OFF
#  sed:deps/Makefile不变;
#  fix:abuild-mesion . build; > meson . build;

```

- st simpleterminal

```bash
# ref g-dev1/fk-alpine-xfce4-xrdp/src/branch/sam-custom/gw/Dockerfile
    1  cd /mnt2/
    2  git clone https://ghproxy.com/https://github.com/LukeSmithxyz/st
    3  cd st/
    7  apt update
   10  apt install libharfbuzz-dev
   13  apt install libfontconfig-dev
   15  apt install libxft-dev
   16  make
   17  echo $?
   18  make install
```

