From: Michael Ellerman <mpe@ellerman.id.au>
Date: Wed, 17 Jun 2020 10:55:14 +1000
Subject: [OpenRISC] [PATCH 00/25] mm: Page fault accounting cleanups
In-Reply-To: <CAHk-=wiTjaXHu+uxMi0xCZQOm4KVr0MucECAK=Zm4p4YZZ1XEg@mail.gmail.com>
References: <20200615221607.7764-1-peterx@redhat.com>
 <CAHk-=wiTjaXHu+uxMi0xCZQOm4KVr0MucECAK=Zm4p4YZZ1XEg@mail.gmail.com>
Message-ID: <87imfqecjx.fsf@mpe.ellerman.id.au>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Linus Torvalds <torvalds@linux-foundation.org> writes:
> On Mon, Jun 15, 2020 at 3:16 PM Peter Xu <peterx@redhat.com> wrote:
>> This series tries to address all of them by introducing mm_fault_accounting()
>> first, so that we move all the page fault accounting into the common code base,
>> then call it properly from arch pf handlers just like handle_mm_fault().
>
> Hmm.
>
> So having looked at this a bit more, I'd actually like to go even
> further, and just get rid of the per-architecture code _entirely_.

<snip>

> One detail worth noting: I do wonder if we should put the
>
>     perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
>
> just in the arch code at the top of the fault handling, and consider
> it entirely unrelated to the major/minor fault handling. The
> major/minor faults fundamnetally are about successes. But the plain
> PERF_COUNT_SW_PAGE_FAULTS could be about things that fail, including
> things that never even get to this point at all.

Yeah I think we should keep it in the arch code at roughly the top.

If it's moved to the end you could have a process spinning taking bad
page faults (and fixing them up), and see no sign of it from the perf
page fault counters.

cheers
