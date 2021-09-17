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
