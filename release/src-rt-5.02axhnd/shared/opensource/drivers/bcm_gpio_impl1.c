/*
 * <:copyright-BRCM:2013:DUAL/GPL:standard
 * 
 *    Copyright (c) 2013 Broadcom 
 *    All Rights Reserved
 * 
 * Unless you and Broadcom execute a separate written software license
 * agreement governing use of this software, this software is licensed
 * to you under the terms of the GNU General Public License version 2
 * (the "GPL"), available at http://www.broadcom.com/licenses/GPLv2.php,
 * with the following added to such license:
 * 
 *    As a special exception, the copyright holders of this software give
 *    you permission to link this software with independent modules, and
 *    to copy and distribute the resulting executable under terms of your
 *    choice, provided that you also meet, for each linked independent
 *    module, the terms and conditions of the license of that module.
 *    An independent module is a module which is not derived from this
 *    software.  The special exception does not apply to any modifications
 *    of the software.
 * 
 * Not withstanding the above, under no circumstances may you combine
 * this software in any way with any other Broadcom software provided
 * under a license other than the GPL, without Broadcom's express prior
 * written consent.
 * 
 * :>
 */

// BCMFORMAT: notabs reindent:uncrustify:bcm_minimal_i4.cfg

#include "boardparms.h"
#include "bcm_gpio.h"

#ifdef _CFE_                                                
#include "lib_types.h"
#include "lib_printf.h"
#include "lib_string.h"
#include "bcm_map.h"
#define printk  printf
#else // Linux
#include <linux/kernel.h>
#include <linux/module.h>
#include <bcm_map_part.h>
#include <linux/string.h>
#endif

/*
  These are low level functions that can be called from CFE or from the Linux board driver
  The Linux board driver handles any necessary locking so these functions should not be called
  directly from elsewhere.
*/

unsigned int bcm_gpio_get_dir(unsigned int gpio_num)
{
    return (GPIO->GPIODir[GPIO_NUM_TO_ARRAY_IDX(gpio_num)] & (GPIO_NUM_TO_MASK(gpio_num))) >> GPIO_NUM_TO_ARRAY_SHIFT(gpio_num);
}
#ifndef _CFE_
EXPORT_SYMBOL(bcm_gpio_get_dir);
#endif

void bcm_gpio_set_dir(unsigned int gpio_num, unsigned int dir)
{
    if(dir)	
        GPIO->GPIODir[GPIO_NUM_TO_ARRAY_IDX(gpio_num)] |= GPIO_NUM_TO_MASK(gpio_num);	
    else
        GPIO->GPIODir[GPIO_NUM_TO_ARRAY_IDX(gpio_num)] &= ~GPIO_NUM_TO_MASK(gpio_num);	
}
#ifndef _CFE_
EXPORT_SYMBOL(bcm_gpio_set_dir);
#endif

unsigned int bcm_gpio_get_data(unsigned int gpio_num)
{
	//printk(KERN_INFO "%s: gpio:%d, Gpio[%d],(mask:%x), 1st res=(%d), 2nd res=%d\n", __func__, gpio_num, GPIO_NUM_TO_ARRAY_IDX(gpio_num), GPIO_NUM_TO_MASK(gpio_num), GPIO->GPIOio[GPIO_NUM_TO_ARRAY_IDX(gpio_num)] & (GPIO_NUM_TO_MASK(gpio_num)), (GPIO->GPIOio[GPIO_NUM_TO_ARRAY_IDX(gpio_num)] & (GPIO_NUM_TO_MASK(gpio_num))) >> GPIO_NUM_TO_ARRAY_SHIFT(gpio_num));
	//printk(KERN_INFO "bp_gpio_num_mask=%x\n", BP_GPIO_NUM_MASK);

    return (GPIO->GPIOio[GPIO_NUM_TO_ARRAY_IDX(gpio_num)] & (GPIO_NUM_TO_MASK(gpio_num))) >> GPIO_NUM_TO_ARRAY_SHIFT(gpio_num);
}
#ifndef _CFE_
EXPORT_SYMBOL(bcm_gpio_get_data);
#endif

void bcm_gpio_set_data(unsigned int gpio_num, unsigned int data)
{
    if (data)	
        GPIO->GPIOio[GPIO_NUM_TO_ARRAY_IDX(gpio_num)] |= GPIO_NUM_TO_MASK(gpio_num);	
    else
        GPIO->GPIOio[GPIO_NUM_TO_ARRAY_IDX(gpio_num)] &= ~GPIO_NUM_TO_MASK(gpio_num);
}
#ifndef _CFE_
EXPORT_SYMBOL(bcm_gpio_set_data);
#endif
