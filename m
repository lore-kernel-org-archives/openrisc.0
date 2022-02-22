From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Date: Tue, 22 Feb 2022 17:36:15 +0100
Subject: [OpenRISC] [PATCH v2 09/18] mips: use simpler access_ok()
In-Reply-To: <CAK8P3a2usZWPDDDUcscwS0aVKsY6aLXFGFPqYNkm4hcDERim9w@mail.gmail.com>
References: <20220216131332.1489939-1-arnd@kernel.org>
 <20220216131332.1489939-10-arnd@kernel.org>
 <20220221132456.GA7139@alpha.franken.de>
 <CAK8P3a2usZWPDDDUcscwS0aVKsY6aLXFGFPqYNkm4hcDERim9w@mail.gmail.com>
Message-ID: <20220222163615.GA14620@alpha.franken.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Feb 21, 2022 at 03:31:23PM +0100, Arnd Bergmann wrote:
> I'll update it this way, otherwise I'd need help in form of a patch
> that changes the exception handling so __get_user/__put_user
> also return -EFAULT for an address error.

https://lore.kernel.org/all/20220222155345.138861-1-tsbogend at alpha.franken.de/

That does the trick.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
