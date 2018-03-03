FROM golang:1.8
RUN apt-get update && apt-get install -y zip
ENV PACKAGE test
ENV FUNCTION test
WORKDIR /workdir
COPY zip /zip
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["sh"]
CMD ["/entrypoint.sh"]
