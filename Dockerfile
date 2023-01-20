# wkhtmltopdf dependencies
FROM ghcr.io/surnet/alpine-wkhtmltopdf:3.17.0-0.12.6-small as wkhtmltopdf

FROM alpine:3.14

COPY --from=wkhtmltopdf /bin/wkhtmltopdf /bin/wkhtmltopdf

# Install dependencies for wkhtmltopdf
RUN apk add --no-cache \
    curl \
    wkhtmltopdf \
    libstdc++ \
    libx11 \
    libxrender \
    libxext \
    libssl1.1 \
    ca-certificates \
    fontconfig \
    freetype \
    ttf-dejavu \
    ttf-droid \
    ttf-freefont \
    ttf-liberation \
    # more fonts
  && apk add --no-cache --virtual .build-deps \
    msttcorefonts-installer \
  # Install microsoft fonts
  && update-ms-fonts \
  && fc-cache -f \
  # Clean up when done
  && rm -rf /tmp/* \
  && apk del .build-deps


# Our own dependencies
RUN apk add --no-cache \
    fetchmail \
    python3 \
    inotify-tools \
    openssh

WORKDIR /root/
COPY /src/ /root/

ENV MAIL_ACCOUNT=mail@example.com
ENV MAIL_PASSWORD=password
ENV PRINTER_URL=example.com
ENV PRINTER_TOKEN=token

RUN chmod 0700 /root/.fetchmailrc && \
    chmod +x /root/entrypoint.sh && \
    chmod +x /root/scripts/*.sh

CMD /root/entrypoint.sh
