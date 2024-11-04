#!/bin/bash
# Set OpenSSL environment variables for the Podman container
export OPENSSL_DIR=/openssl
export OPENSSL_LIB_DIR=/openssl
export OPENSSL_INCLUDE_DIR=/openssl/include

source /root/.cargo/env
cargo build --release --target x86_64-unknown-linux-musl
