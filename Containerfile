FROM registry.access.redhat.com/ubi8/go-toolset:1.17.7 as builder

USER root
WORKDIR /workspace
COPY . .
RUN go build -o todo server.go

FROM registry.access.redhat.com/ubi8/ubi-minimal 

LABEL MAINTAINER "Praveen Kumar <prkumar@redhat.com>"

RUN mkdir /opt/todo
COPY --from=builder /workspace/todo /opt/todo/todo
COPY --from=builder /workspace/views /opt/todo/views

WORKDIR /opt/todo
ENTRYPOINT ["./todo"]
