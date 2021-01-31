From: Stafford Horne <shorne@gmail.com>
Date: Mon, 1 Feb 2021 06:27:52 +0900
Subject: [OpenRISC] [PATCH] openrisc: use device tree to determine
 present cpus
In-Reply-To: <d9f4aafc-4d65-38b0-dde0-5e155836aee1@rwth-aachen.de>
References: <0b26eda7-229d-3dc9-f2ae-19b9212fb0ea@rwth-aachen.de>
 <20210129221643.GZ2002709@lianli.shorne-pla.net>
 <2a018afc-d797-3a91-ffab-e55ae3b0a795@rwth-aachen.de>
 <20210130230310.GC2002709@lianli.shorne-pla.net>
 <d9f4aafc-4d65-38b0-dde0-5e155836aee1@rwth-aachen.de>
Message-ID: <20210131212752.GG2002709@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sun, Jan 31, 2021 at 09:22:31AM +0100, Jan Henrik Weinstock wrote:
> On 31/01/2021 00:03, Stafford Horne wrote:
> 
> > This looks good, one small comment below.  Can you send the next patch as a v2?
> > 
> > Using 'git format-patch -v2 ...'
> 
> Sorry, was not aware of that, will do better next time!
> 
> > Should we warn on the else case?
> 
> I think it is fine for the kernel to have room for more CPUs than are
> actually present (i.e. NR_CPUs > present_cpus is OK). Other Archs do not
> show a warning in this case either, therefore I also omitted it.

Fair enough.

Reviewed-by: Stafford Horne <shorne@gmail.com>

I can queue this for 5.12 when you send v2.

-Stafford
