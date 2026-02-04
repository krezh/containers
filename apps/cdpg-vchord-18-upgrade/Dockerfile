ARG CRUNCHYDATA_VERSION
ARG PG_VERSION
ARG VERSION

FROM docker.io/library/alpine:3.22.3 AS builder

RUN apk add --no-cache curl alien rpm binutils xz

WORKDIR /tmp

ARG PG_VERSION
ARG TARGETARCH
ARG VCHORD_VERSION

# Download and extract PG16 version
RUN curl --fail -o vchord-16.deb -sSL https://github.com/tensorchord/VectorChord/releases/download/${VCHORD_VERSION}/postgresql-16-vchord_${VCHORD_VERSION}-1_${TARGETARCH}.deb \
    && alien -r vchord-16.deb \
    && rpm2cpio /tmp/*16*.rpm | cpio -idmv \
    && rm -f vchord-16.deb /tmp/*16*.rpm

# Download and extract PG17 version
RUN curl --fail -o vchord-17.deb -sSL https://github.com/tensorchord/VectorChord/releases/download/${VCHORD_VERSION}/postgresql-17-vchord_${VCHORD_VERSION}-1_${TARGETARCH}.deb \
    && alien -r vchord-17.deb \
    && rpm2cpio /tmp/*17*.rpm | cpio -idmv \
    && rm -f vchord-17.deb /tmp/*17*.rpm

# Download and extract target PG version
RUN curl --fail -o vchord.deb -sSL https://github.com/tensorchord/VectorChord/releases/download/${VCHORD_VERSION}/postgresql-${PG_VERSION}-vchord_${VCHORD_VERSION}-1_${TARGETARCH}.deb \
    && alien -r vchord.deb \
    && rpm2cpio /tmp/*.rpm | cpio -idmv \
    && rm -f vchord.deb /tmp/*.rpm

ARG CRUNCHYDATA_VERSION
FROM registry.developers.crunchydata.com/crunchydata/crunchy-upgrade:${CRUNCHYDATA_VERSION}

ARG PG_VERSION

# PG16
COPY --chown=root:root --chmod=755 --from=builder /tmp/usr/lib/postgresql/16/lib/vchord.so /usr/pgsql-16/lib/
COPY --chown=root:root --chmod=755 --from=builder /tmp/usr/share/postgresql/16/extension/vchord* /usr/pgsql-16/share/extension/

# PG17
COPY --chown=root:root --chmod=755 --from=builder /tmp/usr/lib/postgresql/17/lib/vchord.so /usr/pgsql-17/lib/
COPY --chown=root:root --chmod=755 --from=builder /tmp/usr/share/postgresql/17/extension/vchord* /usr/pgsql-17/share/extension/

# Target PG version
COPY --chown=root:root --chmod=755 --from=builder /tmp/usr/lib/postgresql/${PG_VERSION}/lib/vchord.so /usr/pgsql-${PG_VERSION}/lib/
COPY --chown=root:root --chmod=755 --from=builder /tmp/usr/share/postgresql/${PG_VERSION}/extension/vchord* /usr/pgsql-${PG_VERSION}/share/extension/

USER 26

COPY pgvectors.sql /docker-entrypoint-initdb.d/
