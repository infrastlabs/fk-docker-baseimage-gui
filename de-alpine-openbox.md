

- pango
- libxrandr
- fontconfig #split@Dockerfile
- 
- **openbox**

```bash
 107 cd ../fk-docker-baseimage-gui/src/openbox/
 108 ls
 109 bash build.sh 
 110 ls -lh

#  115 ls
 116 cd /tmp/openbox
 117 ls
 118 cd -
 119 cd /tmp/openbox-install/
 120 ls
 121 find
 123 ./usr/bin/openbox --help
 126 xx-verify --static      /tmp/openbox-install/usr/bin/openbox #OK
 127 echo $? #0
```


- **fluxbox** @C++
  - blackbox> fluxbox; github资料不如openbox
  - 相比openbox: 配置项简洁; 自带panel;

```bash
# how build?

```

