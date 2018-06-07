From: Richard Henderson <rth@twiddle.net>
Date: Thu, 7 Jun 2018 08:56:42 -0700
Subject: [OpenRISC] OpenRISC: SMP support for more than 2 cores
In-Reply-To: <CALAE4RoMmLDrSkvBUPhp-pCddbb-j1unXee3vPcUzbT1_q_G-A@mail.gmail.com>
References: <CALAE4RoMmLDrSkvBUPhp-pCddbb-j1unXee3vPcUzbT1_q_G-A@mail.gmail.com>
Message-ID: <5185f351-8f1d-bc81-9806-a5e412cfebb0@twiddle.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 06/07/2018 06:27 AM, Davidson Francis wrote:
> Dear all,
> 
> Currently Qemu supports only 2 cores when SMP enabled for or1k architecure, so
> I would like to know if there is a quick way to increase the number of cores by
> changing a few lines of code or to accomplish this, will requires significant
> changes in the source code?

Probably not significant changes.
The limit of 2 seems to be the way the interrupts are wired up.
That can probably be extended relatively easily.


r~
