ARG IMAGE_PY
ARG IMAGE_GO
FROM $IMAGE_PY as py
FROM $IMAGE_GO

COPY --from=py /usr/local /usr/local

RUN <<EOF
apt-get update
apt-get install -y --no-install-recommends entr
rm -rf /var/lib/apt/lists/*
EOF
