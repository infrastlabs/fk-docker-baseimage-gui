
- xdpyprobe
- tigervnc
  - tiger-static `-DENABLE_GNUTLS=OFF`@deb12/ubt2004
  - xkb
  - xkbcomp
- oth
  - fontconfig
  - openbox
  - yad
  - nginx/novnc
- fluxbox TODO
- xrdp TODO


deb12_glibc环境/clang编译, +pam/static.patch `-DENABLE_GNUTLS=OFF`

```bash
# env: alpine315> ubt2004(armv7_gcc_err)> deb12

# deb12-static: 
#  -DENABLE_GNUTLS=OFF
#  sed:deps/Makefile不变;
#  fix:abuild-mesion . build; > meson . build;

```



