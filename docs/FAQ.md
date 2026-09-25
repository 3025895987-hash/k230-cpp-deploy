# FAQ / 踩坑记录

## 工具链

**`riscv64-unknown-linux-gnu-g++: not found`**

工具链默认在 SDK 目录：

```text
~/k230_sdk/toolchain/Xuantie-900-gcc-linux-5.10.4-glibc-x86_64-V2.6.0/bin/
```

找不到时：

```bash
find ~/k230_sdk/toolchain -type f -name '*g++'
```

也可以用环境变量覆盖：

```bash
export TOOLCHAIN=/path/to/Xuantie-900-gcc-...
./scripts/build_hello.sh
```

## 编译出来跑不了

```bash
file hello
```

- 不是 `ELF 64-bit ... RISC-V` → 用错编译器了。
- `not found` / `No such file` → 多半是动态链接，改成 `-static`。
- `Permission denied` → `chmod +x hello`。

## USB 插上没有串口

1. 镜像是否打过 `patches/0001-usb-cdc-acm-console.patch`。
2. 板子上执行：

```bash
/etc/init.d/S99usb-cdc restart
ls /sys/kernel/config/usb_gadget/k230-cdc
ls /dev/ttyGS0
```

3. `UDC_NAME` 是否匹配你的板子（在 `/sys/class/udc/` 里看）。
4. Windows 驱动：设备管理器里应出现 USB 串行设备。

## 登录

- 用户：`root`
- 密码：默认为空（直接回车）

## 磁盘空间

完整 SDK 编译输出约 15GB+，TF 卡镜像约 512MB。给 WSL 预留足够空间。

## 其他板型

换 `make CONF=...` 时，同步检查：

- `UDC_NAME`（`S99usb-cdc`）
- 内核 defconfig 是否已有 USB gadget / ACM
- 应用分区挂载点（是否也是 `/sharefs`）
