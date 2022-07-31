FROM drinternet/rsync:v1.4.0

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

LABEL org.opencontainers.image.source = "https://github.com/virbyte/postgresql-proxy-action/"

EXPOSE 5432

ENTRYPOINT ["/entrypoint.sh"]
