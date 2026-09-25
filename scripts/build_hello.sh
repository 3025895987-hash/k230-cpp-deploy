#!/usr/bin/env bash
# 在 WSL / Ubuntu 里一键交叉编译 examples/hello
# 需要先按 README 装好 K230 SDK 与工具链
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TOOLCHAIN="${TOOLCHAIN:-$HOME/k230_sdk/toolchain/Xuantie-900-gcc-linux-5.10.4-glibc-x86_64-V2.6.0}"
GXX="${TOOLCHAIN}/bin/riscv64-unknown-linux-gnu-g++"

if [[ ! -x "$GXX" ]]; then
  echo "找不到交叉编译器: $GXX"
  echo "请确认已下载 K230 SDK 工具链，或设置 TOOLCHAIN 环境变量。"
  exit 1
fi

cd "$ROOT/examples/hello"
"$GXX" -O2 -Wall -static hello.cpp -o hello
file hello
echo "编译完成: $ROOT/examples/hello/hello"
echo "拷到板子后执行: chmod +x hello && ./hello"
