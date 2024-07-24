# wkhtmltopdf
FROM ghcr.io/surnet/alpine-wkhtmltopdf:3.20.1-0.12.6-small AS wkhtmltopdf

# Our image
FROM alpine:3.14


# Install dependencies for wkhtmltopdf
COPY --from=wkhtmltopdf /bin/wkhtmltopdf /bin/wkhtmltopdf
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
    python3 \
    py3-pip \
    inotify-tools \
    openssh

RUN pip3 install uploadserver

# Create a user
ARG USER=default
ENV HOME /home/$USER

# install sudo as root
RUN apk add --update sudo

# add new user
RUN adduser -D $USER \
        && echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER \
        && chmod 0440 /etc/sudoers.d/$USER

USER $USER
WORKDIR $HOME
COPY /src/ $HOME

ENV PRINTER_URL=example.com
ENV PRINTER_TOKEN=token

RUN sudo chown -R $USER:$USER $HOME

RUN sudo chmod +x $HOME/entrypoint.sh && \
    sudo chmod +x $HOME/scripts/*.sh

CMD $HOME/entrypoint.sh
EXPOSE 8000
