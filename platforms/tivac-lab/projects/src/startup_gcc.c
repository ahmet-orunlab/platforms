#include <stdint.h>

extern int main(void);

// Stack baslangic adresi (Linker script'ten alinacak)
extern uint32_t _estack;

void Reset_Handler(void) {
    // Gerekirse veri kopyalama islemleri burada yapilabilir
    main();
    while(1);
}

// Vektör Tablosu - ARM Cortex-M4 standardi
__attribute__ ((section(".isr_vector")))
uint32_t *g_pfnVectors[] = {
    (uint32_t *)&_estack,
    (uint32_t *)Reset_Handler
};
