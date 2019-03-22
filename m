From: Waiman Long <longman@redhat.com>
Date: Fri, 22 Mar 2019 16:27:26 -0400
Subject: [OpenRISC] [PATCH v5 1/3] locking/rwsem: Remove arch specific
 rwsem files
In-Reply-To: <20190322193010.azb7rmmmaclhal35@linux-r8p5>
References: <20190322143008.21313-1-longman@redhat.com>
 <20190322143008.21313-2-longman@redhat.com>
 <CAHk-=wikkO-1f1=FEOEzkSnaDg3yJLP=4Vd59UCuLBztFd0KOw@mail.gmail.com>
 <20190322193010.azb7rmmmaclhal35@linux-r8p5>
Message-ID: <45315aa9-f006-c4ca-705f-71d6c2650508@redhat.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

On 03/22/2019 03:30 PM, Davidlohr Bueso wrote:
> On Fri, 22 Mar 2019, Linus Torvalds wrote:
>> Some of them _might_ be performance-critical. There's the one on
>> mmap_sem in the fault handling path, for example. And yes, I'd expect
>> the normal case to very much be "no other readers or writers" for that
>> one.
>
> Yeah, the mmap_sem case in the fault path is really expecting an unlocked
> state. To the point that four archs have added branch predictions, ie:
>
> 92181f190b6 (x86: optimise x86's do_page_fault (C entry point for the
> page fault path))
> b15021d994f (powerpc/mm: Add a bunch of (un)likely annotations to
> do_page_fault)
>
> And using PROFILE_ANNOTATED_BRANCHES shows pretty clearly:
> (without resetting the counters)
>
> correct incorrect  %        Function              File          Line
> ------- ---------  -        --------              ----          ----
>  4603685       34   0 do_user_addr_fault         fault.c          1416
> (bootup)
> 382327745      449   0 do_user_addr_fault         fault.c         
> 1416 (kernel build)
> 399446159      461   0 do_user_addr_fault         fault.c         
> 1416 (redis benchmark)
>
> It would probably wouldn't harm doing the unlikely() for all archs, or
> alternatively, add likely() to the atomic_long_try_cmpxchg_acquire in
> patch 3 and do it implicitly but maybe that would be less flexible(?)
>
> Thanks,
> Davidlohr

I had used the my lock event counting code to count the number of
contended and uncontended trylocks. I tested both bootup and kernel
build. I think I saw less than 1% were contended, the rests were all
uncontended. That is similar to what you got. I thought I had sent the
data out previously, but I couldn't find the email. That was the main
reason why I took Linus' suggestion to optimize it for the uncontended case.

Thanks,
Longman

