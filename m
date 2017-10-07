From: Stafford Horne <shorne@gmail.com>
Date: Sun, 8 Oct 2017 00:08:02 +0900
Subject: [OpenRISC] OpenRISC Specification updates for Multicore
In-Reply-To: <20170821072848.GA2587@lianli.shorne-pla.net>
References: <20170819150129.GG3031@lianli.shorne-pla.net>
 <20170821072848.GA2587@lianli.shorne-pla.net>
Message-ID: <CAAfxs77zr=y_ESYMFBqv8Cbnxc9FaMRYW_2FF9KiYNYQqHiUOQ@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello,

Last it was mentioned that people might want to start looking into the
architecture updates after orconf.  I think enough time has passed.

Today Olof gave a few comments on the Pull Request:
  https://github.com/openrisc/doc/pull/1

If anyone else has any suggestions for issues with the changes please
let me know.  Otherwise I will merge and make a news announcement.

One discussion that came up on the Linux SMP patch reviews was making
it clear that our memory model transitivity [0] is defined.  I think
this is covered by the atomic functionality and cache coherency
mechanism docs.  But if anyone has a better idea please explain.

P.S. After this architecture change I think its worth adding the
proposals that Richard Henderson has made to the ORBIS64/ORFPX64 [1].
He has also posted GCC and mor1kx patches for those proposals. Any
volunteers?


[0]  https://lkml.org/lkml/2017/9/14/487
[1] https://openrisc.io/architecture

On Mon, Aug 21, 2017 at 4:28 PM, Stafford Horne <shorne@gmail.com> wrote:
>
> On Sun, Aug 20, 2017 at 12:01:29AM +0900, Stafford Horne wrote:
>> It has been on my todo list for a while to update the OpenRISC
>> specification to add some of the mutlicore features which have been
>> implemented but not yet made it into the spec.
>>
>> I have created 2 new architecture proposals:
>>
>>   https://openrisc.io/proposals/tls
>>   Here the proposal is to formally designate r10 as the TLS reserved
>>   register in the spec.  Please help to review my proposed wording and
>>   change. (This is not related to multicore)
>>
>>   https://openrisc.io/proposals/atomic-boundary
>>   Here the proposal is one that came from Peter Zijlstra when reviewing
>>   OpenRISC locking.  We should clarify that atomic reservations will be
>>   cancelled for any storage overlapping the load address reservation.  This
>>   includes byte and half-word offset stores.
>>
>> Also, I propose to finally add the following:
>>
>>   https://openrisc.io/proposals/core-identifier-and-number-of-cores
>>   The coreid and numcores SPRs have been implemented in several cores but
>>   are not yet part of the spec.  We would like to formally add them as they
>>   have been implemented.
>>
>> Also, I am planning to add a section to the specification about OpenRISC
>> Multicore Systems.  With a quick overview of:
>>
>>   - Atomic Instructions
>>   - Cache Coherency
>>   - Core identification
>>   - Bootstrapping Multicore Systems
>>   - Timer synchronization
>>     * Via global timer hardware
>>     * Via software lock-sync routines
>>   - Details on inter processor communication via the OMPIC
>>
>> Please let me know if you think anything else is relevant.
>>
>> Also if I get any Yay or Nay I will start incorporating the above into the
>> spec.
>
> Hello,
>
> I don't think I will get many Nay's on the above idea's so I started to
> perform the updates.
>
> Please find the draft available here:
>
>  https://github.com/stffrdhrn/doc/blob/arch-1.2-proposal/openrisc-arch-1.2-rev0.pdf
>
> This is based on some work that Stefan Wallentowitz started in March 2015,
> which fixed typos and had a few cleanups.  I have added:
>
>  - The items above
>  - Details on using Shadow Registers for temporary storage in multicore
>    configurations.  Previously memory between 0x0 and 0x100 was being used
>    which would not be workable in multicore.
>  - Details on the OpenRISC Multicore Programmable Interrupt Controller (OMPIC)
>  - A new chapter 10 highlighting "Multicore Support"
>
> I am not really sure of my writing style as I haven't written formal
> specifications for some time.  So please bare with me.
>
> Enjoy!
>
> -Stafford
