#!/bin/bash
set -euo pipefail

PORT="${ARDUINO_PORT:-}"

find_port() {
    local by_id_candidates=()
    local generic_candidates=(
        /dev/ttyACM0
        /dev/ttyACM1
        /dev/ttyUSB0
        /dev/ttyUSB1
    )
    local candidate

    if compgen -G "/dev/serial/by-id/*" >/dev/null; then
        while IFS= read -r candidate; do
            by_id_candidates+=("$candidate")
        done < <(find /dev/serial/by-id -maxdepth 1 -type l | sort)

        for candidate in "${by_id_candidates[@]}"; do
            if [[ "$candidate" == *Arduino* || "$candidate" == *arduino* || "$candidate" == *usb-1a86* || "$candidate" == *usb-FTDI* || "$candidate" == *usb-Silicon_Labs* ]]; then
                echo "$candidate"
                return 0
            fi
        done

        if [[ ${#by_id_candidates[@]} -gt 0 ]]; then
            echo "${by_id_candidates[0]}"
            return 0
        fi
    fi

    for candidate in "${generic_candidates[@]}"; do
        if [[ -e "$candidate" ]]; then
            echo "$candidate"
            return 0
        fi
    done

    return 1
}

if [[ -z "$PORT" ]]; then
    PORT="$(find_port || true)"
fi

if [[ -z "$PORT" ]]; then
    echo "Arduino Uno portu bulunamadi. Mümkünse /dev/serial/by-id altindaki sabit baglantiyi, degilse ARDUINO_PORT ortam degiskenini kullanin." >&2
    exit 1
fi

if [[ ! -r "$PORT" || ! -w "$PORT" ]]; then
    echo "Secilen seri port mevcut ama mevcut kullanici icin erisilebilir degil: $PORT" >&2
    echo "VS Code gorevi bunu 'sudo' ile calistiracak sekilde ayarlandi. Elle calistiriyorsan sudo kullan." >&2
fi

echo "Kullanilan port: $PORT"
avrdude -p m328p -c arduino -P "$PORT" -b 115200 -D -U flash:w:build/firmware.hex:i
