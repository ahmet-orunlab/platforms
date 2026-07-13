#!/bin/bash

# Arka planda MSP430 için GDB Server başlat (Launchpad'ler genelde rf2500 sürücüsü kullanır)
# Eğer yeni nesil bir Launchpad kullanıyorsanız 'rf2500' yerine 'tilib' yazmanız gerekebilir.
mspdebug rf2500 "gdb 2000" &

# Konteynerin sürekli açık kalmasını sağla
tail -f /dev/null
