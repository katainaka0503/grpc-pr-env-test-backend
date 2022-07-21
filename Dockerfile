FROM golang:1.18-buster AS build

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY . .

RUN go build -o grpc-pr-env-test-backend

FROM gcr.io/distroless/base-debian10

WORKDIR /

COPY --from=build /app/grpc-pr-env-test-backend /grpc-pr-env-test-backend

EXPOSE 50051

USER nonroot:nonroot

CMD ["/grpc-pr-env-test-backend"]