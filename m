From: Peter Zijlstra <peterz@infradead.org>
Date: Wed, 22 Feb 2017 12:32:17 +0100
Subject: [OpenRISC] [PATCH v3 10/25] openrisc: add spinlock
	implementation
In-Reply-To: <9ec913b47790e9412d5b71a5fc52794ce4ebafb9.1487702890.git.shorne@gmail.com>
References: <cover.1487702890.git.shorne@gmail.com>
 <9ec913b47790e9412d5b71a5fc52794ce4ebafb9.1487702890.git.shorne@gmail.com>
Message-ID: <20170222113217.GO6515@twins.programming.kicks-ass.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Feb 22, 2017 at 04:11:39AM +0900, Stafford Horne wrote:
> +/*
> + * RWLOCKS
> + *

Any particular reason you're not using qrwlock ?

  include/asm-generic/qrwlock_types.h
  include/asm-generic/qrwlock.h
  kernel/locking/qrwlock.c
