# libX11 libXft libfontconfig libfreetype

ver_x11=1.8.4 #1.4.3
ver_xft=2.3.6 #2.2.0
ver_fontconf=2.14.1 #2.8.0
ver_freetype=2.12.1 #2.4.4
# 
ver_xcb=1.15 #1.7

dest=/mnt2/deps1; mkdir -p $dest
function down_catfile(){
  url=$1
  file=${url##*/}
  #curl -# -L -f 
  test -f $dest/$file || curl -# -k -fSL $url > $dest/$file
  #cat $dest/$file
  tar -zxf $dest/$file -C $dest/
}

function tarxf(){
  echo $@
  down_catfile $1$2$3
}

# https://github.com/pikhq/sabotage/blob/d6e5dd7a4b1bbed6c0871897b94c9628e3d58cb6/xorg/libx11
# tarxf ftp://ftp.x.org/pub/individual/lib/ libX11-$ver_x11 .tar.gz #.tar.bz2
tarxf https://www.x.org/archive/individual/lib/ libX11-$ver_x11 .tar.gz
# ./configure --prefix=/ --disable-shared --disable-loadable-xcursor
# make DESTDIR=$R install

# https://github.com/pikhq/sabotage/blob/d6e5dd7a4b1bbed6c0871897b94c9628e3d58cb6/xorg/libxft#L3
tarxf http://xorg.freedesktop.org/releases/individual/lib/ libXft-$ver_xft .tar.gz #.tar.bz2
# ./configure --prefix=/ --disable-shared
# make
# make DESTDIR=$R install


# https://github.com/pikhq/sabotage/blob/d6e5dd7a4b1bbed6c0871897b94c9628e3d58cb6/xorg/fontconfig
tarxf http://www.freedesktop.org/software/fontconfig/release/ fontconfig-$ver_fontconf .tar.gz
# ./configure --prefix=/ --disable-shared
# make
# make DESTDIR=$R install


# https://github.com/pikhq/sabotage/blob/d6e5dd7a4b1bbed6c0871897b94c9628e3d58cb6/xorg/freetype
tarxf http://download.savannah.gnu.org/releases/freetype/ freetype-$ver_freetype .tar.gz #.tar.bz2
# ./configure --prefix=/ --disable-shared 
# make DESTDIR=$R install




# https://github.com/pikhq/sabotage/blob/d6e5dd7a4b1bbed6c0871897b94c9628e3d58cb6/xorg/libxcb
tarxf http://xcb.freedesktop.org/dist/ libxcb-$ver_xcb .tar.gz #.tar.bz2
# mkdir hack
# cp /bin/cat hack/xsltproc
# PATH=hack:$PATH ./configure --prefix=/ --disable-shared --disable-build-docs
# make
# make DESTDIR=$R install