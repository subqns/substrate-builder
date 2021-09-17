Standard build environment for substrate node

You can build the builder image by running

```
$ docker build -t substrate-builder .
```

The image itself does not include rustup toolchains, only the dependencies for them.

You are supposed to have rustup and related toolchains installed on your host.

In order to share the host toolchain with the builder container, you should first add the following snippet in you ~/.bashrc file

```
ub(){
  docker run --net=host -u "$(id -u):$(id -g)" -e HOME -e http_proxy -e https_proxy -e TZ=Asia/Shanghai -e UB=1 -it -v /etc/sudoers:/etc/sudoers -v /etc/group:/etc/group -v /etc/passwd:/etc/passwd -w "$PWD" -v "$PWD:$PWD" -v "$HOME:$HOME" substrate-builder
}

if [[ -n UB ]]; then
  export PATH="$PATH:$HOME/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/"
fi
```

and execute `ub` in your substrate project directory, assuming your rustup toolchains are located under `~/.rustup`

then proceed as if you were in your host environment

```
$ cargo build --release
```

When the compilation is done, copy the `nftmart-node` binary to [nftmart-node-docker](..) directory and follow the instructions there to build a node image
