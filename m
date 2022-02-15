From: Christoph Hellwig <hch@lst.de>
Date: Tue, 15 Feb 2022 07:29:42 +0100
Subject: [OpenRISC] [PATCH 09/14] m68k: drop custom __access_ok()
In-Reply-To: <Ygr11RGjj3C9uAUg@zeniv-ca.linux.org.uk>
References: <20220214163452.1568807-1-arnd@kernel.org>
 <20220214163452.1568807-10-arnd@kernel.org>
 <Ygr11RGjj3C9uAUg@zeniv-ca.linux.org.uk>
Message-ID: <20220215062942.GA12551@lst.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Feb 15, 2022 at 12:37:41AM +0000, Al Viro wrote:
> Perhaps simply wrap that sucker into #ifdef CONFIG_CPU_HAS_ADDRESS_SPACES
> (and trim the comment down to "coldfire and 68000 will pick generic
> variant")?

I wonder if we should invert CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE,
select the separate address space config for s390, sparc64, non-coldfire
m68k and mips with EVA and then just have one single access_ok for
overlapping address space (as added by Arnd) and non-overlapping ones
(always return true).
