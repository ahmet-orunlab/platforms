#include <msp430.h>

void main(void)
{
    WDTCTL = WDTPW | WDTHOLD;  // Stop the watchdog timer
    P1DIR |= 0x01;             // Set P1.0 (LED1) as output
    P1OUT &= ~0x01;            // Start with LED off

    while (1)
    {
        P1OUT ^= 0x01;        // Toggle LED1 (P1.0)
        __delay_cycles(100000);  // Delay for a while (adjust as needed)
    }
}

