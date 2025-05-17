FROM steamcmd/steamcmd:latest

# Update and install needed tools
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install coreutils rename nano adduser -y && \
    apt-get clean && \
    rm -rf /var/lib/opt/lists/*

RUN mkdir /data
RUN addgroup --gid 777 arma
RUN adduser --system --shell /bin/false --uid 777 --ingroup arma --home /data arma

RUN steamcmd +exit

EXPOSE 2302-2306/udp
EXPOSE 2344/udp
EXPOSE 2344-2345/tcp

VOLUME [ "/data" ]
WORKDIR /data

COPY --chmod=755 ./scripts/start.sh /
COPY --chmod=755 ./scripts/install_server.sh /
COPY --chmod=755 ./scripts/start_server.sh /

ENTRYPOINT [ "/start.sh" ]
