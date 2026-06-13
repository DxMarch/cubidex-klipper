#!/bin/bash

set -e

: "${MANTA_UUID:?MANTA_UUID is not set}"
: "${MANTA_USB_DEVICE:?MANTA_USB_DEVICE is not set}"
: "${EBB0_UUID:?EBB0_UUID is not set}"
: "${EBB1_UUID:?EBB1_UUID is not set}"

echo "All required environment variables are set."

ip link show can0 >/dev/null 2>&1 || {
    echo "Error: can0 interface not found."
    exit 1
}

echo "Stopping Klipper"
sudo service klipper stop
cd ~/klipper
git pull

# Build Manta Klipper firmware
make clean KCONFIG_CONFIG=config.manta
make KCONFIG_CONFIG=config.manta 

# Reset and enter DFU mode
python3 ~/katapult/scripts/flashtool.py -u $MANTA_UUID -i can0 -r
# Flash with USB
python3 ~/katapult/scripts/flashtool.py -f ~/klipper/out/klipper.bin -d $MANTA_USB_DEVICE

# Build EBB Klipper firmware
make clean KCONFIG_CONFIG=config.ebb
make KCONFIG_CONFIG=config.ebb

# Reset and enter DFU mode
python3 ~/katapult/scripts/flashtool.py -u $EBB0_UUID -i can0 -r
# Flash over CAN
python3 ~/katapult/scripts/flashtool.py -u $EBB0_UUID -i can0 -f ~/klipper/out/klipper.bin

# Do the same for the second EBB
python3 ~/katapult/scripts/flashtool.py -u $EBB1_UUID -i can0 -r
python3 ~/katapult/scripts/flashtool.py -u $EBB1_UUID -i can0 -f ~/klipper/out/klipper.bin
echo "EBB firmware flashed to EBB1. Starting Klipper again"

sudo service klipper start