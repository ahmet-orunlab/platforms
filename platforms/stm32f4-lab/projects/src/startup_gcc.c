#include <stdint.h>

extern int main(void);

// Linker sembolleri
extern uint32_t _estack;
extern uint32_t _etext;
extern uint32_t _sdata;
extern uint32_t _edata;
extern uint32_t _sbss;
extern uint32_t _ebss;

void Reset_Handler(void);
void Default_Handler(void) {
    while(1);
}

// Kesme fonksiyonları için zayıf referanslar
void NMI_Handler(void)          __attribute__((weak, alias("Default_Handler")));
void HardFault_Handler(void)    __attribute__((weak, alias("Default_Handler")));

// Vektör tablosunun kesinlikle FLASH başlangıcında (0x08000000) kalmasını sağlıyoruz
__attribute__((section(".isr_vector"), used, aligned(4)))
const uint32_t g_pfnVectors[] = {
    (uint32_t)&_estack,         // 1. Ana Stack Pointer (MSP)
    (uint32_t)Reset_Handler,    // 2. Reset vektörü
    (uint32_t)NMI_Handler,      // 3. NMI
    (uint32_t)HardFault_Handler // 4. HardFault
};

void Reset_Handler(void) {
    // 1. Flash'taki .data bölümünü SRAM'e kopyala
    uint32_t *pSrc = &_etext;
    uint32_t *pDest = &_sdata;
    while(pDest < &_edata) {
        *pDest++ = *pSrc++;
    }

    // 2. SRAM'deki .bss bölümünü sıfırla
    pDest = &_sbss;
    while(pDest < &_ebss) {
        *pDest++ = 0;
    }

    // 3. main()'i çağır
    main();
    
    // main'den çıkış olursa sonsuz döngüde kal
    while(1);
}
