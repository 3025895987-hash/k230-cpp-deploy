# K230 Linux 小核 C++ 交叉编译
# 用法：
#   make            # 编译出静态链接的 hello
#   make clean

CROSS_COMPILE ?= riscv64-unknown-linux-gnu-
CXX := $(CROSS_COMPILE)g++

# 默认指向 SDK 内嵌工具链；也可用环境变量 TOOLCHAIN 覆盖
TOOLCHAIN ?= $(HOME)/k230_sdk/toolchain/Xuantie-900-gcc-linux-5.10.4-glibc-x86_64-V2.6.0
ifneq ($(wildcard $(TOOLCHAIN)/bin),)
CXX := $(TOOLCHAIN)/bin/$(CROSS_COMPILE)g++
endif

CXXFLAGS ?= -O2 -Wall -static
TARGET := hello
SRC := hello.cpp

.PHONY: all clean
all: $(TARGET)

$(TARGET): $(SRC)
	$(CXX) $(CXXFLAGS) $(SRC) -o $(TARGET)
	@file $(TARGET)

clean:
	rm -f $(TARGET)
