FROM amd64/alpine:20210804
RUN apk --no-cache add \
        git \
        build-base \
        cmake \
        libuv-dev \
        util-linux-dev \
        libmicrohttpd-dev && \
    git clone https://github.com/xmrig/xmrig.git && \
    cd xmrig && \
    mkdir build && \
    cmake -DCMAKE_BUILD_TYPE=Release . && \
    make && \
    apk del \
        git \
        build-base \
        cmake

# App user
ARG APP_USER="xmrig"
ARG APP_UID=1378
RUN adduser --disabled-password --uid "$APP_UID" --no-create-home --gecos "$APP_USER" --shell /sbin/nologin "$APP_USER"

USER "$APP_USER"
WORKDIR "$DATA_DIR"
ENV APP_BIN="$APP_BIN" \
    JAVA_OPT="-Xms8M -Xmx1G"
ENTRYPOINT exec java $JAVA_OPT -jar "$APP_BIN" nogui
