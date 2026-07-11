#include <stdint.h>

// Tiva C TM4C123GH6PM Donanim Kayitcilari (Register) Adresleri
#define SYSCTL_RCGCGPIO_R       (*((volatile uint32_t *)0x400FE608))
#define GPIO_PORTF_DATA_R       (*((volatile uint32_t *)0x400253FC))
#define GPIO_PORTF_DIR_R        (*((volatile uint32_t *)0x40025400))
#define GPIO_PORTF_DEN_R        (*((volatile uint32_t *)0x4002551C))

void delay(volatile uint32_t count) {
    while(count--) {
        // Bos dongu (Gecikme)
    }
}

int main(void) {
    // 1. Port F saat sinyalini aktif et (Gömülü sistemlerde sarttir)
    SYSCTL_RCGCGPIO_R |= 0x20;
    delay(3); // Saatin oturmasi için kisa bir beklesin
    
    // 2. Kirmizi LED (PF1) pinini cikis (Output) yap
    GPIO_PORTF_DIR_R |= 0x02;
    
    // 3. PF1 pinini dijital olarak aktif et
    GPIO_PORTF_DEN_R |= 0x02;
    
    while(1) {
        GPIO_PORTF_DATA_R ^= 0x02; // LED durumunu tersle (Toggle)
        delay(4000000);             // Yaklasik 1 saniye gecikme
    }
}
