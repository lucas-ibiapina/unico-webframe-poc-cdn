# STAGE 1: building the executable
FROM golang:alpine AS build
RUN apk add --no-cache git
WORKDIR /go/src/app
COPY ./go.mod ./go.sum ./
RUN go mod download
COPY ./ ./
RUN CGO_ENABLED=0 go build \
    -installsuffix 'static' \
    -o /go/bin/app ./cmd/main.go
 
# STAGE 2: build the container to run
FROM gcr.io/distroless/static AS final
USER nonroot:nonroot
COPY --from=build --chown=nonroot:nonroot /go/bin/app /app
ENTRYPOINT ["/app"]
