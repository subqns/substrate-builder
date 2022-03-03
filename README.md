Standard build environment for substrate node

You can build the builder image by running

```
$ docker build -t substrate-builder .
```

The image itself does not include rustup toolchains, only the dependencies for them.

You are supposed to have rustup and related toolchains installed on your host.

```
rustup install nightly-2021-12-13
rustup default nightly-2021-12-13
rustup target add wasm32-unknown-unknown
```

In order to share the host toolchain with the builder container, you should first add the following snippet in you ~/.bashrc file

```
cat <<'EOF' >> ~/.bashrc
ub(){ 
  ROOT="$(dirname $(cargo locate-project --workspace | jq -r .root))";
  mkdir -p "$ROOT/target";
  docker run --net=host -u "$(id -u):$(id -g)" -e HOME -e http_proxy -e https_proxy -e TZ=Asia/Shanghai -e UB=1 -it -v /etc/sudoers:/etc/sudoers -v /etc/group:/etc/group -v /etc/passwd:/etc/passwd -w "$PWD" -v "$PWD:$PWD" -v "$HOME:$HOME" -v "$HOME/target:$ROOT/target" substrate-builder
}

if [[ -n UB ]]; then
# export PATH="$PATH:$HOME/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/"
  export PATH="$PATH:$HOME/.rustup/toolchains/nightly-2021-12-13-x86_64-unknown-linux-gnu/bin/"
fi
EOF
```

and execute `ub` in your substrate project directory, assuming your rustup toolchains are located under `~/.rustup`

then proceed as if you were in your host environment

```
$ cargo build --release
```

<!--
When the compilation is done, copy the `nftmart-node` binary to [nftmart-node-docker](..) directory and follow the instructions there to build a node image
-->
