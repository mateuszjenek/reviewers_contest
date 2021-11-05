FROM golang:1.16-buster AS build

COPY . /app/
WORKDIR /app/
RUN go mod download
RUN go build -o reviewers_contest_sso

FROM gcr.io/distroless/base-debian10

COPY --from=build /app/reviewers_contest_sso /app/reviewers_contest_sso
EXPOSE 8090
USER nonroot:nonroot
ENTRYPOINT ["/app/reviewers_contest_sso"]
