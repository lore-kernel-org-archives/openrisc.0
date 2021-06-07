From: Russell King (Oracle) <linux@armlinux.org.uk>
Date: Mon, 7 Jun 2021 10:31:21 +0100
Subject: [OpenRISC] [PATCH v2 00/15] init_mm: cleanup ARCH's
 text/data/brk setup code
In-Reply-To: <006eb573-5a20-1ac7-6234-338d11346a08@csgroup.eu>
References: <20210604070633.32363-1-wangkefeng.wang@huawei.com>
 <YL0+Jargm+y9aqx1@kernel.org>
 <481056ab-686e-9f42-3b8a-b31941f58af6@huawei.com>
 <006eb573-5a20-1ac7-6234-338d11346a08@csgroup.eu>
Message-ID: <20210607093121.GC22278@shell.armlinux.org.uk>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Jun 07, 2021 at 07:48:54AM +0200, Christophe Leroy wrote:
> Hi Kefeng,
> 
> What you could do is to define a __weak function that architectures can
> override and call that function from mm_init() as suggested by Mike,

The problem with weak functions is that they bloat the kernel. Each
time a weak function is overriden, it becomes dead unreachable code
within the kernel image.

At some point we're probabily going to have to enable -ffunction-sections
to (hopefully) allow the dead code to be discarded.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
