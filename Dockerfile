FROM python:3.12.4-bookworm as py
FROM golang:1.22.5-bookworm

COPY --from=py /usr/local /usr/local

RUN <<EOF
apt-get update
apt-get install -y --no-install-recommends entr
rm -rf /var/lib/apt/lists/*
EOF
