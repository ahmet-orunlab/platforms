# MSP430 Lab

Bu klasor, bir musterinin sunucuya SSH ile baglanip VS Code Remote SSH uzerinden MSP430 karti icin gelistirme yapmasi amaciyla hazirlandi.

## Baglanti bilgileri

- SSH portu: `2223`
- Kullanici: `developer`
- Sifre: `msp123`
- Varsayilan udev symlink: `/dev/msp430_launchpad`
- Override env var: `MSP430_DEVICE_SYMLINK`
- GDB server portu: `3333`

## Kullanim

1. Bu klasore girin.
2. `chmod +x docker_run.sh` komutunu bir kez calistirin.
3. `./docker_run.sh` ile konteyneri baslatin.
4. VS Code ile `developer` kullanicisi uzerinden SSH baglantisi kurun.
5. Uzak ortamda `/workspace` klasorunu acin.

## Gerekli VS Code eklentisi

MSP430 debug profili `cppdbg` tipini kullandigi icin `ms-vscode.cpptools` eklentisinin uzak SSH hedefinde kurulu olmasi gerekir.

Eger VS Code `cppdbg` kurmanizi veya `C/C++` eklentisini yuklemenizi istiyorsa:

1. `Extensions` panelini acin.
2. `C/C++` eklentisini bulun (`ms-vscode.cpptools`).
3. `Install in SSH: ...` veya `Install on <remote>` secenegiyle uzak hedefe kurun.
4. Gerekirse `Developer: Reload Window` calistirin.

Workspace icinde bunun icin eklenti onerisi de eklendi: `projects/.vscode/extensions.json`.

## VS Code gorevleri

- `MSP430: 1. Projeyi Derle (Make)`
- `MSP430: 2. Direkt Flash Belleğe Yaz (Flash)`
- `MSP430: GDB Sunucusunu Baslat`

## Debug

Debug profili `msp430-gdb` ile `localhost:3333` uzerinden `mspdebug` GDB sunucusuna baglanir.

## USB erisimi

`docker_run.sh`, udev symlink varsa onu `--device` ile ekler. Symlink yoksa konteyner yine `/dev` ve `/dev/bus/usb` mount'lari ile baslar.

Ornek:

```bash
MSP430_DEVICE_SYMLINK=/dev/msp430_launchpad ./docker_run.sh
```

## SSH config ornegi

```sshconfig
Host msp430-lab
    HostName <sunucu-adresi>
    Port 2223
    User developer
```
