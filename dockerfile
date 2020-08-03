FROM golang:alpine AS buildStage
RUN apk --no-cache add ca-certificates
WORKDIR /cicd-lab
COPY go.mod go.sum ./
RUN  go mod download
COPY . .
RUN CGO_ENABLED=0 go build

FROM scratch
WORKDIR /app
COPY --from=buildStage /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=buildStage /cicd-lab/cicd-lab .
EXPOSE 8088
ENTRYPOINT ["/app/cicd-lab"]