From: Heiko =?unknown-8bit?q?St=C3=BCbner?= <heiko@sntech.de>
Date: Wed, 04 May 2022 14:03:23 +0200
Subject: [PATCH v4 6/7] RISC-V: Move to queued RW locks
In-Reply-To: <20220430153626.30660-7-palmer@rivosinc.com>
References: <20220430153626.30660-1-palmer@rivosinc.com>
 <20220430153626.30660-7-palmer@rivosinc.com>
Message-ID: <3100713.5fSG56mABF@diego>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Am Samstag, 30. April 2022, 17:36:25 CEST schrieb Palmer Dabbelt:
> From: Palmer Dabbelt <palmer@rivosinc.com>
> 
> Now that we have fair spinlocks we can use the generic queued rwlocks,
> so we might as well do so.
> 
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

on riscv64+riscv32 qemu, beaglev and d1-nezha

Tested-by: Heiko Stuebner <heiko@sntech.de>


