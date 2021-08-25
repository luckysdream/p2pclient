FROM frolvlad/alpine-glibc
WORKDIR /app
ADD https://updates.peer2profit.com/p2pclient /app/
RUN chmod +x p2pclient
ENTRYPOINT [ "/bin/sh", "-c", "/app/p2pclient -l $@" ]
# CMD ["sleep", "infinity"]
