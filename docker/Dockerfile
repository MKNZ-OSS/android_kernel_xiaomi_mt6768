FROM ubuntu:18.04

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

RUN apt update && apt install -y make bc libssl-dev gcc ccache python3-pip git curl
RUN pip3 install compiledb

WORKDIR /workspace
COPY dockerbuild.sh .
RUN ccache -o max_size=50G -o cache_dir=/workspace/out/.cache

WORKDIR /workspace/kernel

ENTRYPOINT ["/workspace/dockerbuild.sh"]
