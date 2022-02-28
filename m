From: Russell King (Oracle) <linux@armlinux.org.uk>
Date: Mon, 28 Feb 2022 10:57:18 +0000
Subject: [OpenRISC] [PATCH V3 09/30] arm/mm: Enable
 ARCH_HAS_VM_GET_PAGE_PROT
In-Reply-To: <1646045273-9343-10-git-send-email-anshuman.khandual@arm.com>
References: <1646045273-9343-1-git-send-email-anshuman.khandual@arm.com>
 <1646045273-9343-10-git-send-email-anshuman.khandual@arm.com>
Message-ID: <Yhyqjo/4bozJB6j5@shell.armlinux.org.uk>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Feb 28, 2022 at 04:17:32PM +0530, Anshuman Khandual wrote:
> This defines and exports a platform specific custom vm_get_page_prot() via
> subscribing ARCH_HAS_VM_GET_PAGE_PROT. Subsequently all __SXXX and __PXXX
> macros can be dropped which are no longer needed.

What I would really like to know is why having to run _code_ to work out
what the page protections need to be is better than looking it up in a
table.

Not only is this more expensive in terms of CPU cycles, it also brings
additional code size with it.

I'm struggling to see what the benefit is.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
