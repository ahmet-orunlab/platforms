# STM32F4 Lab

Bu klasor, bir musterinin sunucuya SSH ile baglanip VS Code Remote SSH uzerinden STM32F4 karti icin gelistirme yapmasi amaciyla hazirlandi.

## Baglanti bilgileri

- SSH portu: `2222`
- Kullanici: `developer`
- Sifre: `stm123`
- Udev symlink varsayilani: `/dev/stm32_stlink`
- Override env var: `STM32_DEVICE_SYMLINK`

## Kullanim

1. Bu klasore girin.
2. `chmod +x docker_run.sh` komutunu bir kez calistirin.
3. `./docker_run.sh` ile konteyneri baslatin.
4. VS Code ile `developer` kullanicisi uzerinden SSH baglantisi kurun.
5. Uzak ortamda `/workspace` klasorunu acin.

## VS Code gorevleri

- `1 - STM32: Derle (Make)`
- `2 - STM32: Sadece Karta Yazilimi At (Flash)`

## Debug

Debug profili `cortex-debug` ve `openocd` ile calisir.
Gercek donanim debug akisi ST-Link uzerinden hedeflenmistir.

## USB erisimi

`docker_run.sh`, udev symlink varsa onu `--device` ile ekler. Symlink yoksa konteyner yine `/dev/bus/usb` mount'u ile baslar.

Ornek:

```bash
STM32_DEVICE_SYMLINK=/dev/stm32_stlink ./docker_run.sh
```

## SSH config ornegi

```sshconfig
Host stm32f4-lab
    HostName <sunucu-adresi>
    Port 2222
    User developer
```
