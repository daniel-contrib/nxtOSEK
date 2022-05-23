/* template.c for TOPPERS/ATK(OSEK) */ 
#include "kernel.h"
#include "kernel_id.h"
#include "ecrobot_interface.h"

void ecrobot_device_initialize() {}
void ecrobot_device_terminate() {}
void user_1ms_isr_type2(void) {}

TASK(OSEK_Task_Background)
{
	while(1)
	{
  		ecrobot_status_monitor("OSEK HelloWorld!");
		systick_wait_ms(500); /* 500msec wait */
	}
}
