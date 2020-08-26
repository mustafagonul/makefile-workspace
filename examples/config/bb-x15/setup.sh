#!/bin/bash

### Raspberry Pi

### Beagleboard X15

## Version
# TI_SDK_VERSION=ti-processor-sdk-linux-rt-am57xx-evm-06.00.00.07
# TI_SDK_VERSION=ti-processor-sdk-linux-rt-am57xx-evm-06.01.00.08
TI_SDK_VERSION=ti-processor-sdk-linux-rt-am57xx-evm-06.02.00.81

## Directories
TI_SDK_ROOT_DIR=$HOME/TI/SDK
TI_SDK_DIR=$TI_SDK_ROOT_DIR/$TI_SDK_VERSION

## Exports
export TARGET_ROOTDIR=$TI_SDK_DIR/linux-devkit/sysroots/armv7at2hf-neon-linux-gnueabi/
export TI_OCL_CGT_INSTALL=$TI_SDK_DIR/linux-devkit/sysroots/x86_64-arago-linux/usr/share/ti/cgt-c6x

## Environment Setup
. $TI_SDK_DIR/linux-devkit/environment-setup
