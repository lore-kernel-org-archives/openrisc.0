From: Peter Zijlstra <peterz@infradead.org>
Date: Thu, 31 Aug 2017 09:46:54 +0200
Subject: [OpenRISC] [PATCH 03/13] openrisc: add 1 and 2 byte cmpxchg
	support
In-Reply-To: <1a5c872fdf79d00c84ccd5ba3a5e02d02c1039c6.1504129273.git.shorne@gmail.com>
References: <cover.1504129273.git.shorne@gmail.com>
 <1a5c872fdf79d00c84ccd5ba3a5e02d02c1039c6.1504129273.git.shorne@gmail.com>
Message-ID: <20170831074654.aebcc7wvfbv7ebrw@hirez.programming.kicks-ass.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Aug 31, 2017 at 06:58:34AM +0900, Stafford Horne wrote:
> OpenRISC only supports hardware instructions that perform 4 byte atomic
> operations.  For enabling qrwlocks for upcoming SMP support 1 and 2 byte
> implementations are needed.  To do this we leverage the 4 byte atomic
> operations and shift/mask the 1 and 2 byte areas as needed.
> 
> This heavily borrows ideas and routines from sh and mips, which do
> something similar.

Is there value in lifting them into something common?
