#!/bin/bash
set -euo pipefail

pkill -f "simavr -m atmega328p -f 16000000 -g /workspace/build/firmware.elf" 2>/dev/null || true

LOG_FILE=/tmp/simavr-gdb.log
simavr -m atmega328p -f 16000000 -g /workspace/build/firmware.elf >"$LOG_FILE" 2>&1 &
SIMAVR_PID=$!

cleanup() {
    kill "$SIMAVR_PID" 2>/dev/null || true
}
trap cleanup EXIT INT TERM

for _ in $(seq 1 50); do
    if ss -ltn | grep -q ':1234'; then
        echo "SIMAVR_GDB_READY"
        wait "$SIMAVR_PID"
        exit $?
    fi

    if ! kill -0 "$SIMAVR_PID" 2>/dev/null; then
        cat "$LOG_FILE"
        exit 1
    fi

    sleep 0.2
done

cat "$LOG_FILE"
echo "simavr GDB portu acilmadi." >&2
exit 1
