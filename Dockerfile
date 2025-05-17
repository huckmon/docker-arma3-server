FROM steamcmd/steamcmd:latest

# Update and install needed tools
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install coreutils rename nano adduser -y && \
    apt-get clean && \
    rm -rf /var/lib/opt/lists/*

RUN mkdir /data
RUN deluser ubuntu
RUN addgroup --gid 1000 arma
RUN adduser --uid 1000 --ingroup arma --home /data arma

RUN steamcmd +exit

EXPOSE 2302-2306/udp
EXPOSE 2344/udp
EXPOSE 2344-2345/tcp

VOLUME [ "/data" ]
WORKDIR /data

COPY --chmod=755 scripts/* /

ENTRYPOINT [ "/start.sh" ]

