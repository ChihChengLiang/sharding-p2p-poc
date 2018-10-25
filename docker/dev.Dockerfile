FROM golang:1.11-alpine

RUN apk add git
RUN go get -u -v github.com/whyrusleeping/gx &&\
    go get -u -v github.com/whyrusleeping/gx-go

WORKDIR /sharding-p2p-poc

COPY go.mod .
COPY go.sum .
COPY package.json .

RUN go mod download
RUN gx install

COPY . .

RUN CGO_ENABLED=0 go build

CMD ["./sharding-p2p-poc"]
