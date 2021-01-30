# == start with this image ==
FROM golang:1.15-alpine AS gobase

ENV SOPS_VERSION 3.6.1

# I need make to compile stuff later on
RUN apk add --update --no-cache make

# Download the release; untar it; make it
ADD https://github.com/mozilla/sops/archive/v3.6.1.tar.gz /go/src/app/
RUN tar xzf /go/src/app/v${SOPS_VERSION}.tar.gz -C /go/src/app/
WORKDIR /go/src/app/sops-${SOPS_VERSION}
RUN make install

# == new base for the final image ==
FROM golang:1.15-alpine AS gofinal

LABEL maintainer="Rakhesh Sasidharan"
LABEL org.opencontainers.image.source=https://github.com/rakheshster/docker-sops

# Copy the binary we created above
COPY --from=gobase /go/bin/sops /bin/sops

# sops needs gnupg & I need nano
RUN apk add --update --no-cache gnupg nano

ENV EDITOR nano

# The GPG_TTY env variable needs to be set for gpg to show the passphrase screen. 
# There's no way to pass that in the Dockerfile so I create an entrypoint script for that. 
# Thanks to https://stackoverflow.com/a/49889134
COPY ./entrypoint.sh /bin/entrypoint.sh

# Set a working directory (We can mount the user's $(pwd) here later on)
WORKDIR /home

# Set this as the entry point for the image
ENTRYPOINT ["/bin/entrypoint.sh"]