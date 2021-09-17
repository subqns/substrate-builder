FROM ubuntu
# FROM debian:buster
ENV DEBIAN_FRONTEND=noninteractive 
ENV LANG=en_US.UTF-8
RUN apt update
RUN apt install -y locales && locale-gen --purge en_US.UTF-8

# https://getsubstrate.io/
RUN apt install -y cmake pkg-config libssl-dev git gcc build-essential git clang libclang-dev vim tmux
RUN apt install -y sudo
RUN apt install -y curl wget axel

RUN curl https://sh.rustup.rs -sSf | sh -s -- --no-modify-path --default-toolchain nightly-2021-09-01 --target wasm32-unknown-unknown -y -q
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/root/.cargo/bin
