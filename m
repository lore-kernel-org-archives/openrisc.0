From: Davidson Francis <davidsondfgl@gmail.com>
Date: Fri, 8 Jun 2018 03:48:40 -0300
Subject: [OpenRISC] OpenRISC: SMP support for more than 2 cores
In-Reply-To: <5185f351-8f1d-bc81-9806-a5e412cfebb0@twiddle.net>
References: <CALAE4RoMmLDrSkvBUPhp-pCddbb-j1unXee3vPcUzbT1_q_G-A@mail.gmail.com>
 <5185f351-8f1d-bc81-9806-a5e412cfebb0@twiddle.net>
Message-ID: <7c9a8e94-2f45-aeba-a12b-0c83c70c6f99@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 07-06-2018 12:56, Richard Henderson wrote:
> On 06/07/2018 06:27 AM, Davidson Francis wrote:
>> Dear all,
>>
>> Currently Qemu supports only 2 cores when SMP enabled for or1k architecure, so
>> I would like to know if there is a quick way to increase the number of cores by
>> changing a few lines of code or to accomplish this, will requires significant
>> changes in the source code?
> 
> Probably not significant changes.
> The limit of 2 seems to be the way the interrupts are wired up.
> That can probably be extended relatively easily.
> 
> 
> r~
> 

Thank you Richard, I will investigate how the interrupts are wired.

Kind regards,
Davidson Francis.

