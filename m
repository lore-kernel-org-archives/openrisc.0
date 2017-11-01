From: Stafford Horne <shorne@gmail.com>
Date: Wed, 1 Nov 2017 09:34:47 +0900
Subject: [OpenRISC] [PATCH v4 13/13] openrisc: add tick timer multi-core
	sync logic
In-Reply-To: <20171031231759.GB29237@lianli.shorne-pla.net>
References: <20171029231123.27281-1-shorne@gmail.com>
 <20171029231123.27281-14-shorne@gmail.com>
 <05333dd1-f8df-c96e-03df-1623ff67ab39@mips.com>
 <20171031231759.GB29237@lianli.shorne-pla.net>
Message-ID: <20171101003447.GC29237@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Nov 01, 2017 at 08:17:59AM +0900, Stafford Horne wrote:
> On Tue, Oct 31, 2017 at 02:06:21PM +0000, Matt Redfearn wrote:
> > Hi,
> > 
> > 
> > On 29/10/17 23:11, Stafford Horne wrote:
> > > In case timers are not in sync when cpus start (i.e. hot plug / offset
> > > resets) we need to synchronize the secondary cpus internal timer with
> > > the main cpu.  This is needed as in OpenRISC SMP there is only one
> > > clocksource registered which reads from the same ttcr register on each
> > > cpu.
> > > 
> > > This synchronization routine heavily borrows from mips implementation that
> > > does something similar.
> [..]
> > > diff --git a/arch/openrisc/kernel/smp.c b/arch/openrisc/kernel/smp.c
> > > index 4763b8b9161e..4d80ce6fa045 100644
> > > --- a/arch/openrisc/kernel/smp.c
> > > +++ b/arch/openrisc/kernel/smp.c
> > > @@ -100,6 +100,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
> > >   		pr_crit("CPU%u: failed to start\n", cpu);
> > >   		return -EIO;
> > >   	}
> > > +	synchronise_count_master(cpu);
> > >   	return 0;
> > >   }
> > > @@ -129,6 +130,8 @@ asmlinkage __init void secondary_start_kernel(void)
> > >   	set_cpu_online(cpu, true);
> > >   	complete(&cpu_running);
> > > +	synchronise_count_slave(cpu);
> > > +
> > 
> > 
> > Note that until 8f46cca1e6c06a058374816887059bcc017b382f, the MIPS timer
> > synchronization code contained the possibility of deadlock. If you mark a
> > CPU online before it goes into the synchronize loop, then the boot CPU can
> > schedule a different thread and send IPIs to all "online" CPUs. It gets
> > stuck waiting for the secondary to ack it's IPI, since this secondary CPU
> > has not enabled IRQs yet, and is stuck waiting for the master to synchronise
> > with it. The system then deadlocks.
> > Commit 8f46cca1e6c06a058374816887059bcc017b382f fixed this for MIPS and you
> > might want to similarly move the
> > 
> > set_cpu_online(cpu, true);
> > 
> > after counters are synchronized.
> 
> Thank you for the heads up.  I do remember having interim issues with the timer
> syncing but I havent seen it for a while.  I think I fixed it by also moving
> synchronise_count_slave.
> 
> Let me double check.  Also, I see your patch 8f46cca1e6c06a0583748168 was merged
> last year?

Hello,

I should have read a bit more closely, definitely this could be an issue if the
boot cpu has other things running.

However, looking at mainline I can see the clock sync comes after set_cpu_online
again after this patch in mips.

  6f542ebeaee0 MIPS: Fix race on setting and getting cpu_online_mask
  Author: Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>

Is this deadlock an issue in mips again?

-Stafford
