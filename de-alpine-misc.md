
- **dropbear**

```bash
./configure
make
make install
# build ok;
/mnt2/dropbear # ls -lh dropbear
-rwxr-xr-x    1 root     root      367.0K Oct 31 12:26 dropbear


# static-build
./configure  --enable-static --prefix=/usr/local/static/dropbear
make

/mnt2/dropbear # echo $?
0
/mnt2/dropbear # ls -lh dropbear
-rwxr-xr-x    1 root     root      367.0K Oct 31 12:27 dropbear


# /mnt2/dropbear # make install
# validate01
/mnt2/dropbear # xx-verify --static /usr/local/static/dropbear/sbin/dropbear 
/mnt2/dropbear # echo $?
0
/mnt2/dropbear # ls -lh /usr/local/static/dropbear/sbin/dropbear 
-rwxr-xr-x    1 root     root      367.0K Oct 31 12:28 /usr/local/static/dropbear/sbin/dropbear


# validate02
root@VM-12-9-ubuntu:~# cd /mnt/xrdp-static-alpine/
root@VM-12-9-ubuntu:/mnt/xrdp-static-alpine# ls
bin  dropbear  etc  include  lib  sbin  share  xrdp-chansrv
root@VM-12-9-ubuntu:/mnt/xrdp-static-alpine# ./dropbear -h
Dropbear server v2022.83 https://matt.ucc.asn.au/dropbear/dropbear.html
Usage: ./dropbear [options]
```


- **thunar**

```bash
# relear tar
% tar xf thunar-<version>.tar.bz2
% cd thunar-<version>
% ./configure  --enable-static
% make
% make install


# from src
% cd thunar
% ./autogen.sh
% make
% make install



# 
 839 git clone --depth=1 --branch thunar-4.16.11 https://ghproxy.com/https://github.com/xfce-mirror/thunar thunar-4.16.11
 840 ls
 841 cd thunar-4.16.11/
 842 ls
 843 ./configure 
 844 cat autogen.sh 
 845 bash autogen.sh 
 846 apk add xfce4-dev-tools
 847 bash autogen.sh 
 848 apk add intltool
 849 bash autogen.sh 
 850 apk add gtk-doc
 851 bash autogen.sh 
 852 echo $?
 853 apk add exo-2
 854 apk add exo2
 855 apk add exo
 856 bash autogen.sh


# ERR01: exo-2
# /mnt2/thunar-4.16.11 # bash autogen.sh 
checking pkg-config is at least version 0.9.0... yes
checking for exo-2 >= 4.15.3... not found
*** The required package exo-2 was not found on your system.
*** Please install exo-2 (atleast version 4.15.3) or adjust
*** the PKG_CONFIG_PATH environment variable if you
*** installed the package in a nonstandard prefix so that
*** pkg-config is able to find it.


# https://github.com/clefebvre/thunar
# Thunar depends on the following packages:
 - perl 5.6 or above
 - GTK+ 2.24.0 or above
 - GLib 2.30.0 or above
 - exo 0.10.0 or above
 - intltool 0.30 or above
```


```bash
# headless @ mac23-199 in ~ |20:34:54  
$ thunar -V
thunar: Failed to initialize Xfconf: Cannot autolaunch D-Bus without X11 $DISPLAY
thunar 1.8.14 (Xfce 4.14)
Copyright (c) 2004-2019
	The Thunar development team. All rights reserved.

# headless @ mac23-199 in ~ |20:33:55  
$ ldd /usr/bin/thunar |sort
	/lib64/ld-linux-x86-64.so.2 (0x00007f0dd36a0000)
	libICE.so.6 => /lib/x86_64-linux-gnu/libICE.so.6 (0x00007f0dd3529000)
	libSM.so.6 => /lib/x86_64-linux-gnu/libSM.so.6 (0x00007f0dd3547000)
	libX11-xcb.so.1 => /lib/x86_64-linux-gnu/libX11-xcb.so.1 (0x00007f0dd16d1000)
	libX11.so.6 => /lib/x86_64-linux-gnu/libX11.so.6 (0x00007f0dd21fd000)
	libXau.so.6 => /lib/x86_64-linux-gnu/libXau.so.6 (0x00007f0dd15e6000)
	libXcomposite.so.1 => /lib/x86_64-linux-gnu/libXcomposite.so.1 (0x00007f0dd1de6000)
	libXcursor.so.1 => /lib/x86_64-linux-gnu/libXcursor.so.1 (0x00007f0dd1deb000)
	libXdamage.so.1 => /lib/x86_64-linux-gnu/libXdamage.so.1 (0x00007f0dd1de1000)
	libXdmcp.so.6 => /lib/x86_64-linux-gnu/libXdmcp.so.6 (0x00007f0dd15de000)
	libXext.so.6 => /lib/x86_64-linux-gnu/libXext.so.6 (0x00007f0dd1d67000)
	libXfixes.so.3 => /lib/x86_64-linux-gnu/libXfixes.so.3 (0x00007f0dd21c4000)
	libXi.so.6 => /lib/x86_64-linux-gnu/libXi.so.6 (0x00007f0dd21ce000)
	libXinerama.so.1 => /lib/x86_64-linux-gnu/libXinerama.so.1 (0x00007f0dd1e07000)
	libXrandr.so.2 => /lib/x86_64-linux-gnu/libXrandr.so.2 (0x00007f0dd1dfa000)
	libXrender.so.1 => /lib/x86_64-linux-gnu/libXrender.so.1 (0x00007f0dd1a33000)
	libatk-1.0.so.0 => /lib/x86_64-linux-gnu/libatk-1.0.so.0 (0x00007f0dd2c2e000)
	libatk-bridge-2.0.so.0 => /lib/x86_64-linux-gnu/libatk-bridge-2.0.so.0 (0x00007f0dd2181000)
	libatspi.so.0 => /lib/x86_64-linux-gnu/libatspi.so.0 (0x00007f0dd1649000)
	libblkid.so.1 => /lib/x86_64-linux-gnu/libblkid.so.1 (0x00007f0dd157d000)
	libbsd.so.0 => /lib/x86_64-linux-gnu/libbsd.so.0 (0x00007f0dd233a000)
	libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f0dd2504000)
	libcairo-gobject.so.2 => /lib/x86_64-linux-gnu/libcairo-gobject.so.2 (0x00007f0dd21b8000)
	libcairo.so.2 => /lib/x86_64-linux-gnu/libcairo.so.2 (0x00007f0dd2b0b000)
	libdatrie.so.1 => /lib/x86_64-linux-gnu/libdatrie.so.1 (0x00007f0dd15d4000)
	libdbus-1.so.3 => /lib/x86_64-linux-gnu/libdbus-1.so.3 (0x00007f0dd1680000)
	libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007f0dd1a04000)
	libepoxy.so.0 => /lib/x86_64-linux-gnu/libepoxy.so.0 (0x00007f0dd204e000)
	libexo-2.so.0 => /lib/x86_64-linux-gnu/libexo-2.so.0 (0x00007f0dd356a000)
	libexpat.so.1 => /lib/x86_64-linux-gnu/libexpat.so.1 (0x00007f0dd15ec000)
	libffi.so.7 => /lib/x86_64-linux-gnu/libffi.so.7 (0x00007f0dd1951000)
	libfontconfig.so.1 => /lib/x86_64-linux-gnu/libfontconfig.so.1 (0x00007f0dd1ecb000)
	libfreetype.so.6 => /lib/x86_64-linux-gnu/libfreetype.so.6 (0x00007f0dd1e0c000)
	libfribidi.so.0 => /lib/x86_64-linux-gnu/libfribidi.so.0 (0x00007f0dd2031000)
	libgcrypt.so.20 => /lib/x86_64-linux-gnu/libgcrypt.so.20 (0x00007f0dd12d4000)
	libgdk-3.so.0 => /lib/x86_64-linux-gnu/libgdk-3.so.0 (0x00007f0dd2c58000)
	libgdk_pixbuf-2.0.so.0 => /lib/x86_64-linux-gnu/libgdk_pixbuf-2.0.so.0 (0x00007f0dd2ae3000)
	libgio-2.0.so.0 => /lib/x86_64-linux-gnu/libgio-2.0.so.0 (0x00007f0dd2881000)
	libglib-2.0.so.0 => /lib/x86_64-linux-gnu/libglib-2.0.so.0 (0x00007f0dd26f8000)
	libgmodule-2.0.so.0 => /lib/x86_64-linux-gnu/libgmodule-2.0.so.0 (0x00007f0dd24fe000)
	libgobject-2.0.so.0 => /lib/x86_64-linux-gnu/libgobject-2.0.so.0 (0x00007f0dd2821000)
	libgpg-error.so.0 => /lib/x86_64-linux-gnu/libgpg-error.so.0 (0x00007f0dd12af000)
	libgraphite2.so.3 => /lib/x86_64-linux-gnu/libgraphite2.so.3 (0x00007f0dd161c000)
	libgtk-3.so.0 => /lib/x86_64-linux-gnu/libgtk-3.so.0 (0x00007f0dd2d5d000)
	libgudev-1.0.so.0 => /lib/x86_64-linux-gnu/libgudev-1.0.so.0 (0x00007f0dd355d000)
	libharfbuzz.so.0 => /lib/x86_64-linux-gnu/libharfbuzz.so.0 (0x00007f0dd1f12000)
	liblz4.so.1 => /lib/x86_64-linux-gnu/liblz4.so.1 (0x00007f0dd13f2000)
	liblzma.so.5 => /lib/x86_64-linux-gnu/liblzma.so.5 (0x00007f0dd1413000)
	libm.so.6 => /lib/x86_64-linux-gnu/libm.so.6 (0x00007f0dd23af000)
	libmount.so.1 => /lib/x86_64-linux-gnu/libmount.so.1 (0x00007f0dd19a4000)
	libnotify.so.4 => /lib/x86_64-linux-gnu/libnotify.so.4 (0x00007f0dd3552000)
	libpango-1.0.so.0 => /lib/x86_64-linux-gnu/libpango-1.0.so.0 (0x00007f0dd2a62000)
	libpangocairo-1.0.so.0 => /lib/x86_64-linux-gnu/libpangocairo-1.0.so.0 (0x00007f0dd21e0000)
	libpangoft2-1.0.so.0 => /lib/x86_64-linux-gnu/libpangoft2-1.0.so.0 (0x00007f0dd2018000)
	libpcre.so.3 => /lib/x86_64-linux-gnu/libpcre.so.3 (0x00007f0dd18de000)
	libpcre2-8.so.0 => /lib/x86_64-linux-gnu/libpcre2-8.so.0 (0x00007f0dd14eb000)
	libpixman-1.so.0 => /lib/x86_64-linux-gnu/libpixman-1.so.0 (0x00007f0dd1cb5000)
	libpng16.so.16 => /lib/x86_64-linux-gnu/libpng16.so.16 (0x00007f0dd1c7d000)
	libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007f0dd238c000)
	libresolv.so.2 => /lib/x86_64-linux-gnu/libresolv.so.2 (0x00007f0dd195d000)
	librt.so.1 => /lib/x86_64-linux-gnu/librt.so.1 (0x00007f0dd1d5c000)
	libselinux.so.1 => /lib/x86_64-linux-gnu/libselinux.so.1 (0x00007f0dd1979000)
	libstartup-notification-1.so.0 => /lib/x86_64-linux-gnu/libstartup-notification-1.so.0 (0x00007f0dd21f2000)
	libsystemd.so.0 => /lib/x86_64-linux-gnu/libsystemd.so.0 (0x00007f0dd143c000)
	libthai.so.0 => /lib/x86_64-linux-gnu/libthai.so.0 (0x00007f0dd1a0c000)
	libthunarx-3.so.0 => /lib/x86_64-linux-gnu/libthunarx-3.so.0 (0x00007f0dd35a7000)
	libudev.so.1 => /lib/x86_64-linux-gnu/libudev.so.1 (0x00007f0dd235f000)
	libuuid.so.1 => /lib/x86_64-linux-gnu/libuuid.so.1 (0x00007f0dd2354000)
	libwayland-client.so.0 => /lib/x86_64-linux-gnu/libwayland-client.so.0 (0x00007f0dd1d7e000)
	libwayland-cursor.so.0 => /lib/x86_64-linux-gnu/libwayland-cursor.so.0 (0x00007f0dd1d94000)
	libwayland-egl.so.1 => /lib/x86_64-linux-gnu/libwayland-egl.so.1 (0x00007f0dd1d8f000)
	libxcb-render.so.0 => /lib/x86_64-linux-gnu/libxcb-render.so.0 (0x00007f0dd1c3d000)
	libxcb-shm.so.0 => /lib/x86_64-linux-gnu/libxcb-shm.so.0 (0x00007f0dd1c78000)
	libxcb-util.so.1 => /lib/x86_64-linux-gnu/libxcb-util.so.1 (0x00007f0dd16d6000)
	libxcb.so.1 => /lib/x86_64-linux-gnu/libxcb.so.1 (0x00007f0dd1c4c000)
	libxfce4ui-2.so.0 => /lib/x86_64-linux-gnu/libxfce4ui-2.so.0 (0x00007f0dd350e000)
	libxfce4util.so.7 => /lib/x86_64-linux-gnu/libxfce4util.so.7 (0x00007f0dd2acf000)
	libxfconf-0.so.3 => /lib/x86_64-linux-gnu/libxfconf-0.so.3 (0x00007f0dd2ab1000)
	libxkbcommon.so.0 => /lib/x86_64-linux-gnu/libxkbcommon.so.0 (0x00007f0dd1d9f000)
	libz.so.1 => /lib/x86_64-linux-gnu/libz.so.1 (0x00007f0dd1a17000)
	linux-vdso.so.1 (0x00007fff8b5ab000)
```