FROM debian:9

RUN \
  apt update && \
  apt install -y cpio isolinux libarchive-tools xorriso && \
  apt-get autoremove --purge -y && rm -rf /var/lib/apt/lists/*

COPY update-iso.sh /usr/bin/update-iso

VOLUME /work
WORKDIR /work

ENTRYPOINT ["/usr/bin/update-iso"]
