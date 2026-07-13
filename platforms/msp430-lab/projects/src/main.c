#include <msp430.h>

int main(void) {
    WDTCTL = WDTPW | WDTHOLD;   // Watchdog timer'ı durdur
    P1DIR |= 0x01;              // P1.0 pinini çıkış yap (Launchpad üzerindeki kırmızı LED)

    while(1) {
        P1OUT ^= 0x01;          // LED durumunu tersle
        __delay_cycles(100000); // Gecikme
    }
}



