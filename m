From: Al Viro <viro@zeniv.linux.org.uk>
Date: Tue, 15 Feb 2022 07:13:42 +0000
Subject: [OpenRISC] [PATCH 09/14] m68k: drop custom __access_ok()
In-Reply-To: <20220215062942.GA12551@lst.de>
References: <20220214163452.1568807-1-arnd@kernel.org>
 <20220214163452.1568807-10-arnd@kernel.org>
 <Ygr11RGjj3C9uAUg@zeniv-ca.linux.org.uk>
 <20220215062942.GA12551@lst.de>
Message-ID: <YgtSpk0boDjsyjFK@zeniv-ca.linux.org.uk>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Feb 15, 2022 at 07:29:42AM +0100, Christoph Hellwig wrote:
> On Tue, Feb 15, 2022 at 12:37:41AM +0000, Al Viro wrote:
> > Perhaps simply wrap that sucker into #ifdef CONFIG_CPU_HAS_ADDRESS_SPACES
> > (and trim the comment down to "coldfire and 68000 will pick generic
> > variant")?
> 
> I wonder if we should invert CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE,
> select the separate address space config for s390, sparc64, non-coldfire
> m68k and mips with EVA and then just have one single access_ok for
> overlapping address space (as added by Arnd) and non-overlapping ones
> (always return true).

parisc is also such...  How about

	select ALTERNATE_SPACE_USERLAND

for that bunch?  While we are at it, how many unusual access_ok() instances are
left after this series?  arm64, itanic, um, anything else?

FWIW, sparc32 has a slightly unusual instance (see uaccess_32.h there); it's
obviously cheaper than generic and I wonder if the trick is legitimate (and
applicable elsewhere, perhaps)...
