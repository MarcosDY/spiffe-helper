FROM golang:latest as builder
WORKDIR /helper
COPY . .
RUN go mod download
RUN go build -o spiffe-helper ./cmd/spiffe-helper

FROM alpine AS spiffe-helper
RUN mkdir -p /opt/helper
COPY --from=builder /helper/spiffe-helper /opt/helper/spiffe-helper

WORKDIR /opt/helper/

