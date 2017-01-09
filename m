From: Russell King - ARM Linux <linux@armlinux.org.uk>
Date: Mon, 9 Jan 2017 12:00:04 +0000
Subject: [OpenRISC] [PATCH v2 1/7] arm: put types.h in uapi
In-Reply-To: <1990589.0aJHWbJK4F@wuerfel>
References: <bf83da6b-01ef-bf44-b3e1-ca6fc5636818@6wind.com>
 <1483695839-18660-1-git-send-email-nicolas.dichtel@6wind.com>
 <1483695839-18660-2-git-send-email-nicolas.dichtel@6wind.com>
 <1990589.0aJHWbJK4F@wuerfel>
Message-ID: <20170109120004.GV14217@n2100.armlinux.org.uk>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Jan 09, 2017 at 12:33:02PM +0100, Arnd Bergmann wrote:
> On Friday, January 6, 2017 10:43:53 AM CET Nicolas Dichtel wrote:
> > 
> > diff --git a/arch/arm/include/asm/types.h b/arch/arm/include/asm/types.h
> > index a53cdb8f068c..c48fee3d7b3b 100644
> > --- a/arch/arm/include/asm/types.h
> > +++ b/arch/arm/include/asm/types.h
> > @@ -1,40 +1,6 @@
> >  #ifndef _ASM_TYPES_H
> >  #define _ASM_TYPES_H
> >  
> > -#include <asm-generic/int-ll64.h>
> ...
> > -#define __UINTPTR_TYPE__       unsigned long
> > -#endif
> > +#include <uapi/asm/types.h>
> >  
> >  #endif /* _ASM_TYPES_H */
> > 
> 
> Moving the file is correct as far as I can tell, but the extra
> #include is not necessary here, as the kernel will automatically
> search both arch/arm/include/ and arch/arm/include/uapi/.

Indeed, I'd like to see the include/asm file gone.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
