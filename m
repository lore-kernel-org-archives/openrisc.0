From: Heiko =?unknown-8bit?q?St=C3=BCbner?= <heiko@sntech.de>
Date: Wed, 04 May 2022 13:57:31 +0200
Subject: [PATCH v4 1/7] asm-generic: ticket-lock: New generic ticket-based
 spinlock
In-Reply-To: <20220430153626.30660-2-palmer@rivosinc.com>
References: <20220430153626.30660-1-palmer@rivosinc.com>
 <20220430153626.30660-2-palmer@rivosinc.com>
Message-ID: <2180881.iZASKD2KPV@diego>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Am Samstag, 30. April 2022, 17:36:20 CEST schrieb Palmer Dabbelt:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> This is a simple, fair spinlock.  Specifically it doesn't have all the
> subtle memory model dependencies that qspinlock has, which makes it more
> suitable for simple systems as it is more likely to be correct.  It is
> implemented entirely in terms of standard atomics and thus works fine
> without any arch-specific code.
> 
> This replaces the existing asm-generic/spinlock.h, which just errored
> out on SMP systems.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

on riscv64+riscv32 qemu, beaglev and d1-nezha

Tested-by: Heiko Stuebner <heiko@sntech.de>


