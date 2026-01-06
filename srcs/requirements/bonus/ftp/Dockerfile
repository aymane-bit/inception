FROM debian:bullseye

RUN apt-get update && apt-get install -y vsftpd && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Create empty directories for vsftpd secure chroot
RUN mkdir -p /var/run/vsftpd/empty && \
    mkdir -p /etc/vsftpd.userlist

COPY tools/ftp-entrypoint.sh /usr/local/bin/ftp-entrypoint.sh
RUN chmod +x /usr/local/bin/ftp-entrypoint.sh

# FTP Control
EXPOSE 21
# Passive Ports
EXPOSE 21100-21110

ENTRYPOINT ["/usr/local/bin/ftp-entrypoint.sh"]
