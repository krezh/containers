ARG CRUNCHYDATA_VERSION
ARG PG_VERSION
ARG VERSION

FROM docker.io/library/alpine:3.22.2 AS builder

RUN apk add --no-cache curl alien rpm binutils xz

WORKDIR /tmp

ARG PG_VERSION
ARG TARGETARCH
ARG VCHORD_VERSION

RUN curl --fail -o vchord.deb -sSL https://github.com/tensorchord/VectorChord/releases/download/${VCHORD_VERSION}/postgresql-${PG_VERSION}-vchord_${VCHORD_VERSION}-1_${TARGETARCH}.deb \
    && alien -r vchord.deb \
    && rm -f vchord.deb
RUN rpm2cpio /tmp/*.rpm | cpio -idmv && ls /tmp

ARG CRUNCHYDATA_VERSION
FROM registry.developers.crunchydata.com/crunchydata/crunchy-postgres:${CRUNCHYDATA_VERSION}

ARG PG_VERSION

COPY --chown=root:root --chmod=755 --from=builder /tmp/usr/lib/postgresql/${PG_VERSION}/lib/vchord.so /usr/pgsql-${PG_VERSION}/lib/
COPY --chown=root:root --chmod=755 --from=builder /tmp/usr/share/postgresql/${PG_VERSION}/extension/vchord* /usr/pgsql-${PG_VERSION}/share/extension/

# Numeric User ID for Default Postgres User
USER 26

COPY pgvectors.sql /docker-entrypoint-initdb.d/