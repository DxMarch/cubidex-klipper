# Cubidex Klipper (Standard Klipper IDEX)

This repository contains a standalone, modular **Klipper** configuration for a **V-Core 4 IDEX 300** printer running dual EBB toolboards and a BTT Manta M8P V1.1 mainboard.

It extracts and decouples the powerful RatOS IDEX macros (tool shifting, parking, copy/mirror modes, VAOC lighting) into standard Klipper configuration files without depending on the RatOS OS overlay.

---

## 📂 Configuration Structure (`config/`)

- **`printer.cfg`**: Root Klipper configuration file including all modules.
- **`hardware.cfg`**: All hardware definitions—MCUs (`mcu`, `toolboard_t0`, `toolboard_t1`), steppers (Motors 1–8), bed heater, extruders, fans, PT1000 chamber sensor, lights, and BTT Eddy probe (`btt_eddy`).
- **`idex.cfg`**: All IDEX routines—`T0`, `T1`, parking, toolhead offsets, printing modes (`IDEX_SINGLE`, `IDEX_COPY`, `IDEX_MIRROR`, `IDEX_PARK`), and VAOC light controls (`_LED_VAOC_ON`, `_LED_VAOC_OFF`).
- **`macros.cfg`**: General macros (BTT Eddy calibration, rapid bed mesh, camera state shell triggers).
- **`crowsnest.conf`**: Crowsnest webcam configuration (`cam 0` corner camera and `cam 1` offset camera).

---

## 🚀 Installation & Deployment

Clone this repository to your home directory and execute the setup script:

```shell
git clone https://github.com/dxmarch/klipper-march ~/cubidex-klipper
cd ~/cubidex-klipper
git checkout standard-klipper
~/cubidex-klipper/scripts/setup.sh
```

Restart Klipper to apply the updated standalone configuration:

```shell
sudo systemctl restart klipper
```