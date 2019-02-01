From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Date: Fri, 1 Feb 2019 13:17:03 +0200
Subject: [OpenRISC] [RFC] Splitting out Marocchino to new Repo
In-Reply-To: <CAF6YiZ5RrwcEj-Kqk4-MvrqZFK8WWUgU1MVjzmu2M3=90qbPdQ@mail.gmail.com>
References: <CAAfxs76ysqzXWnJH02eDe0vSCLvuqwdwwKNiQoQV7Kfst4_mNw@mail.gmail.com>
 <CAF6YiZ5RrwcEj-Kqk4-MvrqZFK8WWUgU1MVjzmu2M3=90qbPdQ@mail.gmail.com>
Message-ID: <CADzBsGO_pzk-oeEbtfNcE86+dAhXq1fuK2JOMHxGvkFOHXQPSA@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

I don't mind either, even if some code is taken from mor1kx, if it makes
more sense to have it in a separate repo, go ahead.

On Fri, Feb 1, 2019 at 12:51 PM Julius Baxter <juliusbaxter@gmail.com>
wrote:

>
>
> On Sun, 27 Jan 2019 at 11:11, Stafford Horne <shorne@gmail.com> wrote:
>
>> Hi All,
>>
>> Sorry this mail got a bit long the outline is:
>>  - Testing Efforts
>>  - Marocchino Pipeline
>>  - Proposal to Split Marocchino to new Repo
>>
>> ## Testing Efforts ##
>>
>> Recently I have been working on adding FPU support to GCC.  The GCC
>> generated FPU code is working and running on the simulator, but I have
>> been taking extra time now to verify on iverilog and verilator
>> simulators of mor1kx.  This has gotten me a bit sidetracked to get a
>> CI environment for testing mor1kx cores.  What I have so far is:
>>    - Using mor1kx + mor1kx-generic + or1k-tests to run the tests
>>    - Almost all tests are passing for mor1kx cappuccino pipeline
>> (multiply carry flag is not implemented, so there is one failure)
>>    - Most tests are failing for the Espresso pipeline (Issue with
>> >1clock instructions in delay slots)
>>    - Most tests are failing for the Marocchino pipeline (Its likely an
>> issue with how I implemented the monitor_* signals)
>>
>
> Hi Stafford,
>
> Great job - integrating this into a CI flow would be very nice indeed.
>
>
>>
>> TODO
>>   - FPU tests are not run in or1k-tests
>>   - Document test coverage for each pipeline
>>   - CI - Automate testing for each commit/PR
>>   - Confirm debug capabilities, i.e. single-stepping
>>   - Synthesize with Xilinx/Altera toolchains to verify resource
>> usage/budget
>>
>> Not planning todo
>>   - GCC support for no-delay-slot code which would be needed for pronto
>> espresso
>>
>
> Yep, fair enough.
>
>
>>
>> ## Marocchino Pipeline ##
>>
>> Which brings us to Marocchino.  Andrey has been working on the
>> Marocchino implementation for a while.  This is a fork of the mor1kx
>> cappuccino pipeline that adds many advanced features like: out of
>> order instruction execution, simplify by reducing parameter options,
>> separate Wishbone and CPU clocks and 64-bit FPU operations via the
>> ORFPX64A32 (https://openrisc.io/proposals/orfpx64a32) specification.
>> In the end this has turned into a very different internal
>> architecture.
>>
>> Currently the work is all stored in the marocchino_devel branch of mor1kx.
>>
>
> This sounds great! Does CoreMark run on it yet? How much of a speedup have
> you achieved so far?
>
>
>>
>> ## Proposal to Split Marocchino to new Repo ##
>>
>> As we discussed in a recent PR
>> (https://github.com/openrisc/mor1kx/pull/72) marocchino doesn't really
>> share any code with the rest of mor1kx and even now has a separate top
>> level module (mor1kx_top_marocchino).
>>
>> Andrey and I have proposed moving the code to a new repo
>> openrisc/mor1kx_marocchino.  Though it's not really exactly a mor1kx
>> pipeline swap any longer the name might be controversial.
>>
>> Does anyone have a objection / suggestion for this?
>>
>
> I don't mind. If it's not intended to share any of the components with the
> other pipelines then by all means do what's best for the development of
> that core.
>
> Looking forward to seeing where this goes!
>
> Cheers,
>
> Julius
>
>
>>
>> -Stafford
>>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20190201/ce136405/attachment.html>
