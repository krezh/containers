ARG CRUNCHYDATA_VERSION
ARG PG_VERSION
ARG VERSION

FROM docker.io/library/alpine:3.22.3 AS builder

RUN apk add --no-cache curl alien rpm binutils xz

WORKDIR /tmp

ARG PG_VERSION
ARG TARGETARCH
ARG VCHORD_VERSION

RUN curl --fail -o vchord.deb -sSL https://github.com/tensorchord/VectorChord/releases/download/${VCHORD_VERSION}/postgresql-${PG_VERSION}-vchord_${VCHORD_VERSION}-1_${TARGETARCH}.deb \
    && alien -r vchord.deb \
    && rpm2cpio /tmp/*.rpm | cpio -idmv \
    && rm -f vchord.deb /tmp/*.rpm

ARG CRUNCHYDATA_VERSION
FROM registry.developers.crunchydata.com/crunchydata/crunchy-postgres:${CRUNCHYDATA_VERSION}

ARG PG_VERSION

COPY --chown=root:root --chmod=755 --from=builder /tmp/usr/lib/postgresql/${PG_VERSION}/lib/vchord.so /usr/pgsql-${PG_VERSION}/lib/
COPY --chown=root:root --chmod=755 --from=builder /tmp/usr/share/postgresql/${PG_VERSION}/extension/vchord* /usr/pgsql-${PG_VERSION}/share/extension/

USER root
RUN <<EOT
set -eux

cat <<EOF > /etc/yum.repos.d/timescaledb.repo
[timescale_timescaledb]
name=timescale_timescaledb
baseurl=https://packagecloud.io/timescale/timescaledb/el/9/\$basearch
repo_gpgcheck=1
gpgcheck=0
enabled=1
gpgkey=https://packagecloud.io/timescale/timescaledb/gpgkey
sslverify=1
sslcacert=/etc/pki/tls/certs/ca-bundle.crt
EOF

microdnf remove -y timescaledb_${PG_VERSION}
microdnf install -y --nodocs timescaledb-2-postgresql-${PG_VERSION}

rm -f /etc/yum.repos.d/timescaledb.repo
microdnf clean all
rm -rf /var/cache/yum /var/lib/dnf /var/lib/rpm/__db*
EOT

USER 26

COPY pgvectors.sql /docker-entrypoint-initdb.d/
