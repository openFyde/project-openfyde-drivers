# project-openfyde-drivers
## About this repository
This repository stores the drivers for openFyde, it's part of the openFyde open-source project.

This repository contains the following packages:

| Packages                   | Description        | Reference |
|----------------------------|--------------------|-----------|
| app-crypt/swtpm            | Libtpms-based TPM emulator with socket, character device, and Linux CUSE interface. |           |
| app-crypt/tpm-emulator     | TPM Emulator with small google-local changes |           |
| chromeos-base/apple-touchpad-bcm5974|      apple touchpad with bcm5974 chip.     |           |
| chromeos-base/common-usb-camera-config|Configuration to support most of the usb-cameras.||
| chromeos-base/fydeos-gestures-config| Script to configure gestures for FydeOS.||
| chromeos-base/fydeos-input-util|Script to configure input devices for FydeOS.||
| chromeos-base/fydeos-power-daemon-go|Power daemon for FydeOS, written in Golang.||
| chromeos-base/gslx680-acpi|ACPI/x86 compatible driver for Silead GSLx680 touchscreens.|https://github.com/onitake/gslx680-acpi|
| chromeos-base/gslx680-firmware|Firmware for silead/mssl1680.||
| chromeos-base/intel-lpe-audio-config|All chromebook sound ucm config files.||
| chromeos-base/touchpad-acer-tap-fix|Bug fix for touchpad of ACER laptop.|| 
| chromeos-base/vga-switcher|Driver for VGA Switcher.||
| eclass/fydeos-kernel-module.eclass|provide the functionality to install modules against the kernel source tree.||
| media-libs/apl-hotword-support|Apollo Lake hotword DSP firmware and language models.||
| media-libs/arc-camera3-hal-intel-ipu3|Intel IPU3 (Image Processing Unit) ARC++ camera HAL v3.||
| media-libs/cros-camera-hal-intel-ipu3|Intel IPU3 (Image Processing Unit) Chrome OS camera HAL.||
| media-libs/display-link-bin|Binary files for display link driver.||
| media-libs/intel-3a-libs-bin|Intel 3A library binaries required by the Intel camera HAL.||
| media-libs/intel-pvl-libs-bin|Intel Photography Vision Library binaries required by the Intel camera HAL.||
| media-libs/kbl-tuning-support|kbl tuning DSM DSP firmware and library models.||
| media-libs/lpe-support-topology|Topology binary files used to support/configure LPE Audio.||
| net-wireless/b43-fwcutter|Firmware Tool for Broadcom 43xx based wireless network devices using the mac80211 wireless stack.||
| net-wireless/rfkill|Tool to read and control rfkill status through /dev/rfkill.||
| net-wireless/rtl8723bs|rtl8723bs SDIO driver.||
| net-wireless/rtl8723bs_bt|rt8192bs bluetooth suppport.||
| net-wireless/rtl8821ce-driver|ReatlTek 8821ce wifi driver.||
| sys-apps/haveged|A simple entropy daemon using the HAVEGE algorithm.||
| sys-apps/iucode_tool|Tool to manipulate Intel X86 and X86-64 processor microcode update collections.||
| sys-apps/rng-tools|Daemon to use hardware random number generators.||
| sys-firmware/intel-glk-guc-huc-firmware|Firmware for Intel GLK, GuC and HuC.||
| sys-firmware/intel-microcode|Intel IA32/IA64 microcode update data.||
| sys-firmware/mssl1680-firmware|Firmware for silead mmsl1680 touchscreen.||
| sys-firmware/nvidia-firmware|Kernel and mesa firmware for nouveau (video accel and pgraph).||

###### Copyright (c) 2022 Fyde Innovations and the openFyde Authors. Distributed under the license specified in the root directory of this repository.