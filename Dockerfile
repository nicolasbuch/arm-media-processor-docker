FROM debian

# Allow installing non-free packages
RUN mv /etc/apt/sources.list /etc/apt/sources.list.original && sed 's/main/main contrib non-free/g' /etc/apt/sources.list.original > /etc/apt/sources.list
RUN apt-get update && apt-get install -y curl xz-utils snap ffmpeg unrar php jq php-sqlite3 supervisor

COPY config/supervisor/* /etc/supervisor/conf.d/

# Install Oracle Java 8 (arm)
COPY packages/oracle-java/jdk-8u231-linux-arm32-vfp-hflt.tar.gz jdk.tar.gz
RUN mkdir -p /usr/java && \
    cd /usr/java && \
    mv /jdk.tar.gz /usr/java/jdk.tar.gz && \
    tar -zxvf jdk.tar.gz && \
    ln -s -f /usr/java/jdk1.8.0_231/bin/java /usr/local/bin/java && \
    rm /usr/java/jdk.tar.gz

RUN mkdir -p /usr/filebot && \
    cd /usr/filebot && \
    curl https://raw.githubusercontent.com/filebot/plugins/master/installer/tar.sh -O && chmod a+x tar.sh && \
    sed 's/sudo//g' tar.sh > tar2.sh && \
    sed 's/--check/-c/g' tar2.sh > tar.sh && \
    ./tar.sh

ADD start.sh root/start.sh

CMD ["/bin/bash", "/root/start.sh"]