From: Peter Zijlstra <peterz@infradead.org>
Date: Thu, 17 Mar 2022 10:46:32 +0100
Subject: [OpenRISC] [PATCH 3/5] openrisc: Move to ticket-spinlock
In-Reply-To: <20220316232600.20419-4-palmer@rivosinc.com>
References: <20220316232600.20419-1-palmer@rivosinc.com>
 <20220316232600.20419-4-palmer@rivosinc.com>
Message-ID: <YjMDeKw/3qxclCJf@hirez.programming.kicks-ass.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Mar 16, 2022 at 04:25:58PM -0700, Palmer Dabbelt wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> We have no indications that openrisc meets the qspinlock requirements,
> so move to ticket-spinlock as that is more likey to be correct.
> 

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

