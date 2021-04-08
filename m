From: Waiman Long <longman@redhat.com>
Date: Thu, 8 Apr 2021 15:00:59 -0400
Subject: [OpenRISC] [PATCH v6 1/9] locking/qspinlock: Add
 ARCH_USE_QUEUED_SPINLOCKS_XCHG32
In-Reply-To: <20210406235208.GG3288043@lianli.shorne-pla.net>
References: <1617201040-83905-1-git-send-email-guoren@kernel.org>
 <1617201040-83905-2-git-send-email-guoren@kernel.org>
 <YGyRrBjomDCPOBUd@boqun-archlinux>
 <20210406235208.GG3288043@lianli.shorne-pla.net>
Message-ID: <1199af5f-275a-5812-fc73-f1d33449036b@redhat.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 4/6/21 7:52 PM, Stafford Horne wrote:
>
> For OpenRISC I did ack the patch to convert to
> CONFIG_ARCH_USE_QUEUED_SPINLOCKS_XCHG32=y.  But I think you are right, the
> generic code in xchg_tail and the xchg16 emulation code in produced by OpenRISC
> using xchg32 would produce very similar code.  I have not compared instructions,
> but it does seem like duplicate functionality.
>
> Why doesn't RISC-V add the xchg16 emulation code similar to OpenRISC?  For
> OpenRISC we added xchg16 and xchg8 emulation code to enable qspinlocks.  So
> one thought is with CONFIG_ARCH_USE_QUEUED_SPINLOCKS_XCHG32=y, can we remove our
> xchg16/xchg8 emulation code?

For the record, the latest qspinlock code doesn't use xchg8 anymore. It 
still need xchg16, though.

Cheers,
Longman

