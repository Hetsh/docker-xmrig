FROM amd64/alpine:20220715
RUN apk add --no-cache \
        xmrig=6.18.0-r2

# App user
ARG APP_USER="xmrig"
ARG APP_UID=1378
RUN adduser --disabled-password --uid "$APP_UID" --no-create-home --gecos "$APP_USER" --shell /sbin/nologin "$APP_USER"

# Volumes
ARG CONF_DIR="/xmrig"
RUN mkdir "$CONF_DIR" && \
    chown "$APP_USER":"$APP_USER" "$CONF_DIR"
VOLUME ["$CONF_DIR"]

USER "$APP_USER"
WORKDIR "$CONF_DIR"
ENV PARAMETERS="--config=config.json"
ENTRYPOINT xmrig $PARAMETERS
