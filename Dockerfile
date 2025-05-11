FROM steamcmd/steamcmd:latest

# Update and install needed tools
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install coreutils rename nano -y && \
    apt-get clean && \
    rm -rf /var/lib/opt/lists/*

RUN /build/setup-user.sh

RUN mkdir /data

RUN chown -R arma:arma /data

RUN steamcmd +exit

EXPOSE 2302-2306/udp
EXPOSE 2344/udp
EXPOSE 2344-2345/tcp

VOLUME [ "/data" ]
WORKDIR /data

COPY --chmod=755 ./scripts/start.sh /
COPY ./scripts/install_server.sh /
COPY ./scripts/start_server.sh /

ENTRYPOINT [ "/start.sh" ]
