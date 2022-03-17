From: Peter Zijlstra <peterz@infradead.org>
Date: Thu, 17 Mar 2022 10:47:35 +0100
Subject: [OpenRISC] [PATCH 5/5] RISC-V: Move to queued RW locks
In-Reply-To: <20220316232600.20419-6-palmer@rivosinc.com>
References: <20220316232600.20419-1-palmer@rivosinc.com>
 <20220316232600.20419-6-palmer@rivosinc.com>
Message-ID: <YjMDt8BgtIZZH8IY@hirez.programming.kicks-ass.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Mar 16, 2022 at 04:26:00PM -0700, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
> 
> With the move to fair spinlocks, we might as well move to fair rwlocks.

s/might as well/can/ ?

Note that qrwlock relies on spinlock to be/provide fairness.

> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
