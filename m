From: Peter Zijlstra <peterz@infradead.org>
Date: Sat, 15 May 2021 14:51:36 +0200
Subject: [OpenRISC] [PATCH] openrisc: Define memory barrier mb
In-Reply-To: <20210515075810.163206-1-shorne@gmail.com>
References: <20210515075810.163206-1-shorne@gmail.com>
Message-ID: <20210515125136.GF5618@worktop.programming.kicks-ass.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sat, May 15, 2021 at 04:58:08PM +0900, Stafford Horne wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> This came up in the discussion of the requirements of qspinlock on an
> architecture.  OpenRISC uses qspinlock, but it was noticed that the
> memmory barrier was not defined.
> 
> Peter defined it in the mail thread writing:
> 
>     As near as I can tell this should do. The arch spec only lists
>     this one instruction and the text makes it sound like a completion
>     barrier.
> 
> This is correct so applying this patch.
> 
> Signed-off-by: Peter Zijlstra <peterz@infradead.org>
> [shorne at gmail.com:Turned the mail into a patch]
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
> I just applied the patch posted by Peter in the mail as is hence it is labeled
> from peter.  This also required me to set the Signed-off-by to Peter.
> 
> If there is any issue with that let me know.  I tested this out on my single
> processor setup and it all works fine, it will take me some time to get my SMP
> setup up and running again to test the other patches, but I figured I would send
> this patch first.

Works for me; thanks for not loosing it ;-)

> Also, I got delayed because I had to rebuild my main workstation after a
> hardware failure.

*ouch*, hate it when that happens.
