
# Get Dockerfile cross-compilation helpers.
FROM --platform=$BUILDPLATFORM tonistiigi/xx AS xx

# Build UPX.
FROM --platform=$BUILDPLATFORM alpine:3.15 AS upx
RUN export domain="mirrors.ustc.edu.cn"; \
  echo "http://$domain/alpine/v3.15/main" > /etc/apk/repositories; \
  echo "http://$domain/alpine/v3.15/community" >> /etc/apk/repositories
RUN apk --no-cache add build-base curl make cmake git && \
    mkdir /tmp/upx && \
    curl -# -L https://github.com/upx/upx/releases/download/v4.0.1/upx-4.0.1-src.tar.xz | tar xJ --strip 1 -C /tmp/upx && \
    make -C /tmp/upx build/release-gcc -j$(nproc) && \
    cp -v /tmp/upx/build/release-gcc/upx /usr/bin/upx


FROM --platform=$BUILDPLATFORM alpine:3.15 AS builder
# https://www.jakehu.me/2021/alpine-mirrors/
# domain="mirrors.ustc.edu.cn"
# domain="mirrors.aliyun.com";
# mirrors.tuna.tsinghua.edu.cn
RUN export domain="mirrors.ustc.edu.cn"; \
  echo "http://$domain/alpine/v3.15/main" > /etc/apk/repositories; \
  echo "http://$domain/alpine/v3.15/community" >> /etc/apk/repositories
COPY --from=xx / /
COPY --from=upx /usr/bin/upx /usr/bin/upx

RUN apk --no-cache add make clang
RUN xx-apk --no-cache add gcc musl-dev libx11-dev libx11-static libxcb-static
