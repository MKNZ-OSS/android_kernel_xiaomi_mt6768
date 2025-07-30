FROM ubuntu:18.04

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

RUN apt update && apt install -y make bc libssl-dev gcc ccache python3-pip
RUN pip3 install compiledb
RUN mkdir /nonexistent && chown nobody:nogroup /nonexistent

USER nobody

WORKDIR /workspace/kernel
COPY dockerbuild.sh /workspace
RUN ccache -o max_size=50G -o cache_dir=/workspace/out/.cache

ENTRYPOINT ["/workspace/dockerbuild.sh"]
