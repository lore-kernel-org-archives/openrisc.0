From: Stafford Horne <shorne@gmail.com>
Date: Sat, 2 Feb 2019 08:12:26 +0900
Subject: [OpenRISC] [RFC] Splitting out Marocchino to new Repo
In-Reply-To: <CAKaYPCMtPDaXMRS9jmGijv2SGFP9LkUA51LFWmvtufWH7GnXLg@mail.gmail.com>
References: <CAAfxs76ysqzXWnJH02eDe0vSCLvuqwdwwKNiQoQV7Kfst4_mNw@mail.gmail.com>
 <CAKaYPCMtPDaXMRS9jmGijv2SGFP9LkUA51LFWmvtufWH7GnXLg@mail.gmail.com>
Message-ID: <20190201231226.GA3235@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Olof,

On Wed, Jan 30, 2019 at 10:56:42AM +0100, Olof Kindgren wrote:
> On Sun, Jan 27, 2019 at 11:12 AM Stafford Horne <shorne@gmail.com> wrote:
> 
> > Hi All,
> >
> > Sorry this mail got a bit long the outline is:
> >  - Testing Efforts
> >  - Marocchino Pipeline
> >  - Proposal to Split Marocchino to new Repo
> >
> > ## Testing Efforts ##
> >
> > Recently I have been working on adding FPU support to GCC.  The GCC
> > generated FPU code is working and running on the simulator, but I have
> > been taking extra time now to verify on iverilog and verilator
> > simulators of mor1kx.  This has gotten me a bit sidetracked to get a
> > CI environment for testing mor1kx cores.  What I have so far is:
> >    - Using mor1kx + mor1kx-generic + or1k-tests to run the tests
> >    - Almost all tests are passing for mor1kx cappuccino pipeline
> > (multiply carry flag is not implemented, so there is one failure)
> >    - Most tests are failing for the Espresso pipeline (Issue with
> > >1clock instructions in delay slots)
> >    - Most tests are failing for the Marocchino pipeline (Its likely an
> > issue with how I implemented the monitor_* signals)
> >
> > TODO
> >   - FPU tests are not run in or1k-tests
> >   - Document test coverage for each pipeline
> >   - CI - Automate testing for each commit/PR
> >   - Confirm debug capabilities, i.e. single-stepping
> >   - Synthesize with Xilinx/Altera toolchains to verify resource
> > usage/budget
> >
> > Not planning todo
> >   - GCC support for no-delay-slot code which would be needed for pronto
> > espresso
> >
> >
> Fantastic! Are you looking at resource usage for CI? In that case it might
> be worth building with yosys instead to avoid a dependency on a commercial
> EDA tool. Even if a synthesis with yosys would require more resources it
> doesn't that much. I guess we are more interested in the varitation between
> builds than any absolute number. It's on my TODO list to add support in the
> Edalize backends for just doing synthesis without P&R. That could be
> helpful in this case too.

Thats a good idea, I was thinking to do xilinx, altera and yosys to get relative
resource usages, but thats probably flying too close to the sun.  Yosys alone
should be good for now.

> And I think you do well in ignoring the or1k-nd versions for now. There are
> likely problems all over the place with that. Would be cool to see if
> espresso is any good though.

I have been having problems with espresso around delay slots.  It seems to not
be able to properly advance if the instruction in the delay slot takes more
than 1 clock.

-Stafford

