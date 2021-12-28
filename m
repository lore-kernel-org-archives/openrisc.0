From: Mauro Carvalho Chehab <mchehab@kernel.org>
Date: Tue, 28 Dec 2021 17:32:02 +0100
Subject: [OpenRISC] [RFC 02/32] Kconfig: introduce HAS_IOPORT option and
 select it as necessary
In-Reply-To: <20211227164317.4146918-3-schnelle@linux.ibm.com>
References: <20211227164317.4146918-1-schnelle@linux.ibm.com>
 <20211227164317.4146918-3-schnelle@linux.ibm.com>
Message-ID: <20211228173202.678baa44@coco.lan>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Em Mon, 27 Dec 2021 17:42:47 +0100
Niklas Schnelle <schnelle@linux.ibm.com> escreveu:

> We introduce a new HAS_IOPORT Kconfig option to gate support for
> I/O port access. In a future patch HAS_IOPORT=n will disable compilation
> of the I/O accessor functions inb()/outb() and friends on architectures
> which can not meaningfully support legacy I/O spaces. On these platforms
> inb()/outb() etc are currently just stubs in asm-generic/io.h which when
> called will cause a NULL pointer access which some compilers actually
> detect and warn about.
> 
> The dependencies on HAS_IOPORT in drivers as well as ifdefs for
> HAS_IOPORT specific sections will be added in subsequent patches on
> a per subsystem basis. Then a final patch will ifdef the I/O access
> functions on HAS_IOPORT thus turning any use not gated by HAS_IOPORT
> into a compile-time warning.
> 
> Link: https://lore.kernel.org/lkml/CAHk-=wg80je=K7madF4e7WrRNp37e3qh6y10Svhdc7O8SZ_-8g at mail.gmail.com/
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

...

> @@ -486,6 +487,9 @@ config HAS_IOMEM
>  	depends on !NO_IOMEM
>  	default y
>  
> +config HAS_IOPORT
> +	def_bool ISA || LEGACY_PCI
> +

That doesn't sound right. 

The only dependency for LEGACY_PCI is PCI. If one selects LEGACY_PCI
on an architecture that doesn't support it, this will cause problems.

Instead, HAS_IOPORT should be selected at architecture level, and
the dependency here should be just the opposite: LEGACY_API should
depends on HAS_IOPORT.

Thanks,
Mauro
