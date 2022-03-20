From: Stafford Horne <shorne@gmail.com>
Date: Mon, 21 Mar 2022 06:13:16 +0900
Subject: [OpenRISC] [PATCH V2 5/5] openrisc: Move to ticket-spinlock
In-Reply-To: <CAAfxs74xtts3bzMGsVp9fOyxfZzj1vQPgrEsquXFa6AGAAC+_w@mail.gmail.com>
References: <20220319035457.2214979-6-guoren@kernel.org>
 <202203200824.EQJTy8pW-lkp@intel.com>
 <CAJF2gTQXgXJjX6h5d_5tM312Ky_QfCKm-wLZP2SJBuYtHvE9xQ@mail.gmail.com>
 <CAAfxs74xtts3bzMGsVp9fOyxfZzj1vQPgrEsquXFa6AGAAC+_w@mail.gmail.com>
Message-ID: <YjeY7CfaFKjr8IUc@antec>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sun, Mar 20, 2022 at 12:36:31PM +0900, Stafford Horne wrote:
> On Sun, Mar 20, 2022, 12:05 PM Guo Ren <guoren@kernel.org> wrote:
> 
> > Hi openrisc guys,
> >
> > >    kernel/signal.c:2625:49: sparse:     expected struct sighand_struct
> > *sighand
> > >    kernel/signal.c:2625:49: sparse:     got struct sighand_struct
> > [noderef] __rcu *sighand
> >
> > Some warning here, Is that all right? I don't think it is because of
> > changing arch_spinlock_t from struct qspinlock to atomic_t.
> >
> 
> I haven't built or tested this series yet.  But this doesn't look like a
> new problem. It looks like this patch series may have introduced a new
> instance of the existing issue.
> 
> I have some patches to clean up sparse warnings and I've seen this pattern
> before but haven't spent the time to clean it up. This is a good
> opportunity to do that now.  Let me have a look in the next few days.

Hello Guo Ren,

I was able to build the patch series for OpenRISC, but after applying the
openrisc SMP kernel build no longer can boot.  It doesn't boot on single core
system or multi-core systems.  I don't get any console output to help with
debugging it.

It may take be a bit longer to debug this.

-Stafford
