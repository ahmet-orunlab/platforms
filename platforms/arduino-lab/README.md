# Arduino Uno Lab

Bu klasor, bir musterinin sunucuya SSH ile baglanip VS Code Remote SSH uzerinden Arduino Uno icin gelistirme yapmasi amaciyla hazirlandi.

## Neler var

- Ubuntu tabanli Docker imaji
- Konteyner icinde SSH sunucusu
- `avr-gcc` ile derleme
- `avrdude` ile gercek karta yukleme
- `simavr + avr-gdb` ile simulasyon tabanli debug

## Onemli not

Arduino Uno (ATmega328P) kartinda STM32 tarafindaki gibi yerlesik donanimsal debug yoktur. Bu nedenle:

- `Karta Yukle` gorevi gercek karti programlar.
- `Simulasyon Debug` gorevi ise ayni firmware'i `simavr` icinde adim adim debug eder.
- Gercek donanim uzerinde break-point tabanli debug icin ek bir `debugWIRE` uyumlu harici debugger gerekir.

## Kullanim

1. Sunucuda bu klasore girin.
2. `chmod +x docker_run.sh` komutunu bir kez calistirin.
3. `./docker_run.sh` ile konteyneri baslatin.
4. VS Code ile `developer` kullanicisi ve `ardu123` sifresiyle SSH uzerinden `2230` portuna baglanin.
5. Uzak ortamda `/workspace` klasorunu acin.

## Gerekli VS Code eklentileri

Bu senaryoda baglanti modeli `Remote-SSH` oldugu icin `.devcontainer` altindaki eklenti listesi otomatik uygulanmayabilir. Debug icin en az su eklentinin uzak hedefe kurulmus olmasi gerekir:

- `ms-vscode.cpptools`

Istege bagli ama yararli ek eklenti:

- `ms-vscode.makefile-tools`

Eger `cppdbg debug type not supported` hatasi gorursen bu neredeyse her zaman `C/C++` eklentisinin uzak SSH hedefinde kurulu olmadigi anlamina gelir.

Cozum:

1. VS Code icinde `Extensions` panelini ac.
2. `C/C++` eklentisini bul (`ms-vscode.cpptools`).
3. `Install in SSH: ...` veya `Install on <remote>` secenegini kullan.
4. Ardindan `Developer: Reload Window` yap.

## IntelliSense notu

Bu projede `avr/io.h` gibi AVR basliklari icin workspace icinde [c_cpp_properties.json](/home/ahmet/orunlab/projs/platforms/arduino-lab/projects/.vscode/c_cpp_properties.json) tanimlandi. Eger yine de `could not open source file 'avr/io.h'` gorursen:

1. `C/C++: Select a Configuration` komutunu ac.
2. `Arduino Uno AVR` profilini sec.
3. Gerekirse `Developer: Reload Window` calistir.

## VS Code gorevleri

- `1 - Arduino Uno: Derle (Make)`
- `2 - Arduino Uno: Karta Yukle (avrdude)`
- `3 - Arduino Uno: Simulasyon GDB Sunucusunu Baslat`

## Debug kullanimi

Debug task'inin `SIMAVR_GDB_READY` demesi, GDB sunucusunun hazir oldugu anlamina gelir. Sonrasinda:

1. `Run and Debug` panelini ac.
2. `Arduino Uno Simulasyon Debug` profilini sec.
3. `F5` ile baslat.

Eger `preLaunchTask` sonrasi hata penceresi acilirsa once `Problems` panelinde `avr/io.h` benzeri IntelliSense hatalari kalip kalmadigini kontrol et. Bu hatalar temizlendikten sonra debug akisi normalde devam eder.

Not: Bu debug oturumu gercek kart ustunde degil, `simavr` simulasyonu icinde calisir.

## Seri port erisimi

`/dev/ttyACM0` gibi cihazlar hosttan konteyner icine mount edilir. Bu nedenle konteyner icindeki normal kullanicinin grup kimligi hosttaki cihaz izinleriyle birebir uyusmayabilir.

Bu klasorde `Karta Yukle` gorevi bu yuzden `sudo` ile calisacak sekilde ayarlanmistir.

Elle yukleme yapmak istersen:

```bash
sudo bash ./scripts/upload.sh
```

## Port secimi

Yukleme betigi once `udev` tarafindan uretilen sabit kimlikli symlinkleri dener:

- `/dev/serial/by-id/...`

Bu sayede cihaza yeni USB donanimlari eklense bile kartin portu `ttyACM0` yerine farkli bir numaraya kaysa da ayni symlink ile bulunabilir.

`by-id` altinda birden fazla cihaz varsa betik oncelikle su isim desenlerini tercih eder:

- `Arduino`
- `arduino`
- `usb-1a86`
- `usb-FTDI`
- `usb-Silicon_Labs`

`/dev/serial/by-id` yoksa veya uygun symlink bulunamazsa su fallback sirasini dener:

- `/dev/ttyACM0`
- `/dev/ttyACM1`
- `/dev/ttyUSB0`
- `/dev/ttyUSB1`

Mevcut symlinkleri gormek icin:

```bash
ls -l /dev/serial/by-id
```

En guvenli yontem, dogrudan sabit symlink'i elle vermektir:

```bash
export ARDUINO_PORT=/dev/serial/by-id/usb-Arduino__www.arduino.cc__Arduino_Uno_85439343031351D0D102-if00
sudo bash ./scripts/upload.sh
```
