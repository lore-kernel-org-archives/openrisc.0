From: Richard Henderson <rth@twiddle.net>
Date: Sat, 22 Apr 2017 17:25:53 +0200
Subject: [OpenRISC] [Qemu-devel] [PATCH 2/7] target/openrisc: add
	shutdown logic
In-Reply-To: <20170422100942.GA4797@lianli.shorne-pla.net>
References: <cover.1492384862.git.shorne@gmail.com>
 <fb69c137317a365dcb549dfef1ecd2fbff48e92c.1492384862.git.shorne@gmail.com>
 <6914f9b7-ece1-973d-2210-871b71319ae0@twiddle.net>
 <20170418142055.GB2599@lianli.shorne-pla.net>
 <20170422100942.GA4797@lianli.shorne-pla.net>
Message-ID: <ab4f029c-8264-7d35-b0e0-9b35a8e80d9d@twiddle.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 04/22/2017 12:09 PM, Stafford Horne wrote:
> I discussed a bit on #qemu and Alexander Graf suggested to properly define
> shutdown semantics for openrisc. Some examples were shown from ppc, s390
> and arm.

Yes, properly defining this in the spec goes a long way toward fixing the 
underlying problem.

It's probably worth thinking about a wait-state condition as well, so that qemu 
can avoid staying pegged at 100% host cpu for an idle guest cpu.

>    ppc - platform
>    http://git.qemu.org/?p=qemu.git;a=blob;f=hw/ppc/e500.c;hb=HEAD#l936
>    Registers hardware device mpc8xxx_gpio which handles shutdown via gpio

That's one possibility.  Another is to define an SPR.


r~
