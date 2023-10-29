

- BusyBox 是 GNU Coreutils 的绝佳替代品; 最初是由 Bruce Perens 在 1996 年为Debian GNU/Linux安装盘编写, 目标是在一张软盘上创建一个可引导的 GNU/Linux 系统
- apt.deb/apk.apk
- glibc/musl
- gcc/clang
- 
- GNU Coreutils
- X11: freedesktop.org
- 

```bash
# alpine-musl: apk xx-static v1.10.6@2010-06-16
openbox> fluxbox/st #deb12_st缺依赖;  repos-ref:未找到 @baseon docker-baseimage-gui

# static: wallet/void独立运行开源程序ref

# buildroot_musl: sabotage@2011
```


## Alpine

`Compile> bins> conf`

- X11
  - ~~tigervnc/xorg-server~~  https://github.com/TigerVNC/tigervnc
  - ~~xrdp~~ https://github.com/neutrinolabs/xrdp
  - ~~dropbear~~ https://github.com/mkj/dropbear
- WM
  - ~~openbox~~ https://github.com/codic12/openbox
  - fluxbox https://github.com/fluxbox/fluxbox `base Blackbox 0.61.1`
- Misc
  - st https://github.com/siduck/st
  - thunar https://github.com/xfce-mirror/thunar #`thunar-4.16.11/thunar-1.8.14@ubt2004`
  - jgmenu https://github.com/jgmenu/jgmenu
  - 
  - go-terminal https://github.com/fyne-io/terminal
  - webhookd/noVNC

```bash
# docker run -it --rm -v /mnt:/mnt2 infrastlabs/x11-base:builder sh
# @tenvm2-x64: 构建feels还快
# @gitac-multi-x3: long-cost

```

