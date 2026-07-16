# Tiva C Lab

Bu klasor, bir musterinin sunucuya SSH ile baglanip VS Code Remote SSH uzerinden Tiva C karti icin gelistirme yapmasi amaciyla hazirlandi.

## Baglanti bilgileri

- SSH portu: `2224`
- Kullanici: `developer`
- Sifre: `tiva123`
- Varsayilan udev symlink: `/dev/tivac_icdi`
- Override env var: `TIVAC_DEVICE_SYMLINK`

## Kullanim

1. Bu klasore girin.
2. `chmod +x docker_run.sh` komutunu bir kez calistirin.
3. `./docker_run.sh` ile konteyneri baslatin.
4. VS Code ile `developer` kullanicisi uzerinden SSH baglantisi kurun.
5. Uzak ortamda `/workspace` klasorunu acin.

## VS Code gorevleri

- `1 - TIVA: Derle (Make)`
- `2 - TIVA: Sadece Karta Yazilimi At (Flash)`

## Debug

Debug profili `cortex-debug` ve `openocd` ile calisir.
Gercek donanim debug akisi Tiva C LaunchPad uzerindeki ICDI/OpenOCD akisini hedefler.

## USB erisimi

`docker_run.sh`, udev symlink varsa onu `--device` ile ekler. Symlink yoksa konteyner yine `/dev/bus/usb` mount'u ile baslar.

Ornek:

```bash
TIVAC_DEVICE_SYMLINK=/dev/tivac_icdi ./docker_run.sh
```

## SSH config ornegi

```sshconfig
Host tivac-lab
    HostName <sunucu-adresi>
    Port 2224
    User developer
```
