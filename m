From: Prasanna Karthik <vprasannakarthik@gmail.com>
Date: Fri, 30 Sep 2016 11:52:42 -0400
Subject: [OpenRISC] Running timer.c program on or1ksim
Message-ID: <CAB2+Xt_E32V-vkF-x52yok7AUS2oKS228=gUDsQx9ZFFR1ceUA@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi,
    We want to run the attached code on the or1ksim OpenRisc simulator. The
code uses the following function to enable timers.

*Code*
static inline void timer_enable()
{
        or1k_mtspr(SPR_TTMR, SPR_TTMR_CR);
}

*Compilation*
We compiled the code(on a ubuntu machine) using the following command:
or1k-linux-musl-gcc -O -Iarch/openrisc/include
-I../baremetal-compiler/or1k-elf/or1k-elf/  main.c -o
arch/openrisc/support/initramfs/main.elf

*Execution*
We then run the elf file (on the openrisc simulator) using the following
command:
./main.elf

*Output*
WARNING: trying to write SPR while SR[SUPV] is cleared.


*Debug attempts*
We have set the following value for the SR register
 sr =  0x18001
We see that the SUPV bit is set.

Can someone help us understand what is going wrong?



-- 
Prasanna Karthik V
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20160930/9977785a/attachment.html>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: main.c
Type: text/x-csrc
Size: 4451 bytes
Desc: not available
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20160930/9977785a/attachment.c>
