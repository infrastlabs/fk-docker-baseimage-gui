FROM infrastlabs/x11-base:rootfs as bin
FROM infrastlabs/x11-base:deb12-rootfs as bin2
FROM ubuntu:20.04 as files1
  COPY --from=bin /rootfs /rootfs/
  COPY --from=bin2 /rootfs /rootfs/

FROM ubuntu:20.04 as files2
  ARG TARGETPLATFORM
  RUN export DOMAIN="mirrors.ustc.edu.cn"; \
  test -z "$(echo $TARGETPLATFORM |grep arm)" && target=ubuntu || target=ubuntu-ports; \
  echo "deb http://${DOMAIN}/$target focal main restricted universe multiverse" > /etc/apt/sources.list \
  && echo "deb http://${DOMAIN}/$target focal-updates main restricted universe multiverse">> /etc/apt/sources.list; \
  apt update && apt -y install curl
  # 
  COPY src/*.sh /rootfs/
  ADD src/dot /rootfs/etc/skel
  ADD src/bin /rootfs/usr/bin
  ADD src/etc /rootfs/etc
  ADD src/svd.conf /rootfs/etc/supervisor/supervisord.conf
  ADD src/sv.conf /rootfs/etc/supervisor/conf.d/sv.conf

FROM ubuntu:20.04
ENV \
  DEBIAN_FRONTEND=noninteractive \
  LOCALE_INCLUDE="en"
  # LOCALE_INCLUDE="zh_CN zh_HK zh_TW en en_AU fr fr_CA pt pt_BR es ar cs de it ru nl tr is sv uk ja ko th vi"
ARG TARGETPLATFORM
RUN export DOMAIN="mirrors.ustc.edu.cn"; \
  test -z "$(echo $TARGETPLATFORM |grep arm)" && target=ubuntu || target=ubuntu-ports; \
  echo "deb http://${DOMAIN}/$target focal main restricted universe multiverse" > /etc/apt/sources.list \
  && echo "deb http://${DOMAIN}/$target focal-updates main restricted universe multiverse">> /etc/apt/sources.list; \
    \
  # default:echo -e;
  echo "path-exclude /usr/share/doc/*\n\
path-exclude /usr/share/man/*\n\
path-exclude /usr/share/locale/*\n\
path-exclude /usr/share/info/*\n\
path-exclude /usr/share/help/*\n\
path-exclude /usr/share/lintian/*\n\
#path-exclude /usr/share/zoneinfo/*\n\
#path-exclude /usr/share/i18n/*\n\
# XKB: Failed to compile keymap
# path-exclude /usr/share/X11/*\n\
# path-include /usr/share/locale/zh_CN/*\n\
" > /etc/dpkg/dpkg.cfg.d/excludes; \
  echo $LOCALE_INCLUDE |sed "s/ /\n/g" |while read one; do echo "path-include /usr/share/locale/$one/*" >> /etc/dpkg/dpkg.cfg.d/excludes; done; \
  cat /etc/dpkg/dpkg.cfg.d/excludes; \
  rm -rf /usr/share/locale/* ; \
  \
  echo 'apt update -qq && apt install -yq --no-install-recommends $@ && apt clean && rm -rf /var/lib/apt/lists/*; ' > /usr/local/bin/apt.sh \
    && chmod +x /usr/local/bin/apt.sh; \
  \
# MISC 15.1 MB
#  lame sox libsox-fmt-mp3 
# RUN \
  apt.sh wget ca-certificates \
  curl \
  htop rsync tree tmux lrzsz psmisc fuse net-tools netcat iputils-ping \
  procps sudo iproute2 iptables zip unzip xz-utils vim-tiny \
  dropbear-bin dropbear-run openssh-sftp-server lftp jq;

# libicu66: 
#  adwaita-icon-theme clipit dunst humanity-icon-theme
#  libxml2 pnmixer shared-mime-info ubuntu-mono
RUN apt.sh \
    # plank \ #compton-plank遮盖去域不可用
    # compton \
    xcompmgr \
    hsetroot \
    # dunst pnmixer clipit \
    fluxbox 

# 拆分包体与配置项两块，免频繁变动基础包
# HEADLESS
COPY --from=files1 /rootfs /rootfs/bin
COPY --from=files2 /rootfs /rootfs/conf

ENV \
  TERM=xterm \
  SHELL=/bin/bash \
  # 默认约定
  # DISPLAY=":10" \ #取VNC_OFFSET
  L="zh_CN" \
  TZ="Asia/Shanghai"

RUN \
  echo "cp -a /rootfs/bin/* /; \n\
cp -a /rootfs/conf/* /; \n\
bash /etc/skel/.fluxbox/fluxbox.sh; \n\
bash /xconf.sh;\n\
touch /rootfs/.core-init-lock\n\
" > /rootfs/.core-init
CMD ["bash", "-c", "test -f /rootfs/.core-init-lock || bash /rootfs/.core-init;  exec /entry.sh"]
