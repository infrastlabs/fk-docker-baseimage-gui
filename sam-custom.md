
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

# try st-static
export CFLAGS="-Os -fomit-frame-pointer"
export CXXFLAGS="$CFLAGS"
export CPPFLAGS="$CFLAGS"
export LDFLAGS="-Wl,--as-needed --static -static -Wl,--strip-all"

unset CFLAGS CXXFLAGS CPPFLAGS LDFLAGS

# root@b4efefabe635:/mnt2/st# rm -f st
# root@b4efefabe635:/mnt2/st# make
# st build options:
# CFLAGS  = -I/usr/X11R6/include  -I/usr/include/freetype2 -I/usr/include/libpng16   -I/usr/include/freetype2 -I/usr/include/libpng16   -I/usr/include/harfbuzz -I/usr/include/freetype2 -I/usr/include/libpng16 -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include  -DVERSION="0.8.5" -D_XOPEN_SOURCE=600 -Os -fomit-frame-pointer -Os -fomit-frame-pointer
# LDFLAGS = -L/usr/X11R6/lib -lm -lrt -lX11 -lutil -lXft -lXrender -lfontconfig -lfreetype   -lfreetype   -lharfbuzz  -Wl,--as-needed --static -static -Wl,--strip-all
# CC      = c99
c99 -o st st.o x.o boxdraw.o hb.o -L/usr/X11R6/lib -lm -lrt -lX11 -lutil -lXft -lXrender `pkg-config --libs fontconfig`  `pkg-config --libs freetype2`  `pkg-config --libs harfbuzz` -Wl,--as-needed --static -static -Wl,--strip-all
# /usr/bin/ld: cannot find -lharfbuzz: No such file or directory
/usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/12/../../../x86_64-linux-gnu/libX11.a(CrGlCur.o): in function `_XNoticeCreateBitmap':
(.text+0x119): warning: Using 'dlopen' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
/usr/bin/ld: st.o: in function `ttynew':
st.c:(.text+0x1fe7): warning: Using 'getpwuid' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
/usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/12/../../../x86_64-linux-gnu/libX11.a(xim_trans.o): in function `_XimXTransSocketINETConnect':
(.text+0xc92): warning: Using 'getaddrinfo' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
# collect2: error: ld returned 1 exit status
# make: *** [Makefile:29: st] Error 1
root@b4efefabe635:/mnt2/st# cat Makefile |grep lX11


# clang
cd /tmp/libxfont2 && ./configure \
        --build=$(TARGETPLATFORM= xx-clang --print-target-triple) \
        --host=$(xx-clang --print-target-triple) \
        --prefix=/usr
```

