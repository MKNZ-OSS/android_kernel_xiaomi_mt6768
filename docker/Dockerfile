FROM docker.io/library/debian:13

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV KBUILD_BUILD_HOST=akb
ENV KBUILD_BUILD_USER=builder

RUN apt update && apt install -y make bc libssl-dev ccache python3-pip git curl
RUN pip3 install --no-cache-dir --break-system-packages compiledb

WORKDIR /workspace
COPY dockerbuild.sh .
RUN ccache -o max_size=50G -o cache_dir=/workspace/ccache

WORKDIR /workspace/kernel

ENTRYPOINT ["/workspace/dockerbuild.sh"]
