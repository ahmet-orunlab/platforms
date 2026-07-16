#include <stdint.h>

// Register Adresleri
#define RCC_AHB1ENR         (*((volatile uint32_t *)0x40023830))
#define GPIOD_MODER         (*((volatile uint32_t *)0x40020C00))
#define GPIOD_ODR           (*((volatile uint32_t *)0x40020C14))

// Gecikme fonksiyonu (volatile eklenerek derleyicinin optimize etmesi engellenir)
void delay(volatile uint32_t count) {
    while(count--) {
        __asm__("nop");
    }
}

int main(void) {
    // 1. GPIOD Portu saat sinyalini aktif et (Bit 3'ü 1 yap)
    RCC_AHB1ENR |= (1UL << 3);
    
    // Saat sinyalinin birime ulaşması için küçük bir bekleme süresi (Gerekli)
    delay(100);
    
    // 2. PD12 (Yeşil LED) pinini Output modu olarak ayarla
    // MODER12 için 24. ve 25. bitleri sırasıyla "01" (Output) yapıyoruz
    GPIOD_MODER &= ~(3UL << 24); // Önce temizle
    GPIOD_MODER |=  (1UL << 24); // Çıkış olarak ata
    
    while(1) {
        // 3. PD12 pinini tersle (Toggle)
        GPIOD_ODR ^= (1UL << 12);
        
        delay(2000000);
    }
}
