FROM btwiuse/arch:ufo AS ufo

FROM ubuntu
# FROM debian:bullseye
# FROM debian:buster
ENV DEBIAN_FRONTEND=noninteractive 
ENV LANG=en_US.UTF-8
RUN apt update
RUN apt install -y locales && locale-gen --purge en_US.UTF-8

# https://getsubstrate.io/
RUN apt install -y cmake pkg-config libssl-dev git gcc build-essential git protobuf-compiler clang libclang-dev
RUN apt install -y sudo
RUN apt install -y curl wget axel
RUN apt install -y lld
RUN apt install -y tmux
RUN apt install -y vim
RUN yes | unminimize

RUN curl https://sh.rustup.rs -sSf | sh -s -- --no-modify-path --default-toolchain nightly --target wasm32-unknown-unknown -y -q
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/root/.cargo/bin

COPY --from=ufo /usr/local/bin/ufo /bin/ufo
