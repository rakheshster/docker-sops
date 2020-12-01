FROM golang:1.15 AS gobase

WORKDIR /go/src/app

RUN go get -u go.mozilla.org/sops/v3/cmd/sops
WORKDIR /go/src/app/src/go.mozilla.org/sops/
RUN git checkout develop
RUN make install