# Smart Home Devices 🏠

DIY smart home devices built with ESP32, ESPHome, and Home Assistant.

## Devices

### 🎲 Status Dice
A 3D-printed desk cube with an accelerometer inside. Flip it to set your office availability status in Home Assistant. Battery powered with automatic deep sleep.

- **Hardware:** Olimex ESP32-C3-DevKit-Lipo Rev C + SparkFun LIS3DH
- **Config:** [`esphome/status-dice.yaml`](esphome/status-dice.yaml)
- **Features:** 6 face orientations, battery monitoring, USB power detection, charging state, deep sleep on battery, always-on when USB powered

### 🏒 Status Puck
A wall-mounted LED ring indicator outside the office door. Glows different colours based on the dice status — so the family knows when to knock.

- **Hardware:** Olimex ESP32-DevKit-Lipo Rev D + Adafruit NeoPixel Ring 12
- **Config:** [`esphome/status-puck.yaml`](esphome/status-puck.yaml)
- **Features:** 6 status colours (green/red/yellow/blue/purple/off), brightness slider, reads status from dice via HA

## Setup

1. Install [ESPHome](https://esphome.io/)
2. Copy `esphome/secrets.yaml.example` to `esphome/secrets.yaml` and fill in your values
3. Flash: `esphome run esphome/status-dice.yaml`

## Secrets

WiFi credentials and API keys are stored in `esphome/secrets.yaml` (git-ignored). See `esphome/secrets.yaml.example` for the required keys.
