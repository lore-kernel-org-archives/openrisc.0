From: BAndViG <bandvig@mail.ru>
Date: Thu, 31 Jan 2019 21:52:07 +0300
Subject: [OpenRISC] [RFC] Splitting out Marocchino to new Repo
In-Reply-To: <CAKaYPCMtPDaXMRS9jmGijv2SGFP9LkUA51LFWmvtufWH7GnXLg@mail.gmail.com>
References: <CAAfxs76ysqzXWnJH02eDe0vSCLvuqwdwwKNiQoQV7Kfst4_mNw@mail.gmail.com>
 <CAKaYPCMtPDaXMRS9jmGijv2SGFP9LkUA51LFWmvtufWH7GnXLg@mail.gmail.com>
Message-ID: <37FCFC974D464083BD1071538AD0EAFD@BAndViG>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

## Reused Sources ##

To be accurate, MAROCCHINO re-uses the following mor1kx sources:

    mor1kx_cfgrs.v
    mor1kx-sprs.v
    mor1kx-defines.v
    mor1kx_utils.vh

Is it normally to just copy them in new repo? As we change them rarely, I think it couldn’t be too hard to keep them synchronized with originals from “openrisc/mor1kx”.


## Prefix Replacement ##

I see there are reasons to remove “mor1kx_” prefix from MAROCHCHINO sources. I would prefer to replace it with someone suitable rather than to just drop it. What about “or1k_”? Or something other? 
Note 1. To keep consistency I think all mentioned above copies of shared sources should be renamed (in MAROCHCINO repo). Same to all MAROCCHINO modules. I’ll do that if we agree about new prefix.
Note 2. What about monitor? If I understand correctly Stafford renamed instance of mor1kx_cpu_marocchino from “u_cpu_marocchino” to “mor1kx_cpu” in MAROCCHINO top exactly to restore compatibility with mor1kx monitor. If we drop/replace “mor1kx_” prefix we will lose compatibility with or1k-tests suite again.

Andrey


From: Olof Kindgren 
Sent: Wednesday, January 30, 2019 12:56 PM
To: Stafford Horne 
Cc: Openrisc ; Philipp Wagner ; Julius Baxter ; BAndViG ; Stefan Wallentowitz 
Subject: Re: [OpenRISC] [RFC] Splitting out Marocchino to new Repo



On Sun, Jan 27, 2019 at 11:12 AM Stafford Horne <shorne@gmail.com> wrote:

  Hi All,

  Sorry this mail got a bit long the outline is:
  - Testing Efforts
  - Marocchino Pipeline
  - Proposal to Split Marocchino to new Repo

  ## Testing Efforts ##

  Recently I have been working on adding FPU support to GCC.  The GCC
  generated FPU code is working and running on the simulator, but I have
  been taking extra time now to verify on iverilog and verilator
  simulators of mor1kx.  This has gotten me a bit sidetracked to get a
  CI environment for testing mor1kx cores.  What I have so far is:
     - Using mor1kx + mor1kx-generic + or1k-tests to run the tests
     - Almost all tests are passing for mor1kx cappuccino pipeline
  (multiply carry flag is not implemented, so there is one failure)
     - Most tests are failing for the Espresso pipeline (Issue with
  >1clock instructions in delay slots)
     - Most tests are failing for the Marocchino pipeline (Its likely an
  issue with how I implemented the monitor_* signals)

  TODO
    - FPU tests are not run in or1k-tests
    - Document test coverage for each pipeline
    - CI - Automate testing for each commit/PR
    - Confirm debug capabilities, i.e. single-stepping
    - Synthesize with Xilinx/Altera toolchains to verify resource usage/budget

  Not planning todo
    - GCC support for no-delay-slot code which would be needed for pronto espresso



Fantastic! Are you looking at resource usage for CI? In that case it might be worth building with yosys instead to avoid a dependency on a commercial EDA tool. Even if a synthesis with yosys would require more resources it doesn't that much. I guess we are more interested in the varitation between builds than any absolute number. It's on my TODO list to add support in the Edalize backends for just doing synthesis without P&R. That could be helpful in this case too.

And I think you do well in ignoring the or1k-nd versions for now. There are likely problems all over the place with that. Would be cool to see if espresso is any good though.


  ## Marocchino Pipeline ##

  Which brings us to Marocchino.  Andrey has been working on the
  Marocchino implementation for a while.  This is a fork of the mor1kx
  cappuccino pipeline that adds many advanced features like: out of
  order instruction execution, simplify by reducing parameter options,
  separate Wishbone and CPU clocks and 64-bit FPU operations via the
  ORFPX64A32 (https://openrisc.io/proposals/orfpx64a32) specification.
  In the end this has turned into a very different internal
  architecture.

  Currently the work is all stored in the marocchino_devel branch of mor1kx.

  ## Proposal to Split Marocchino to new Repo ##

  As we discussed in a recent PR
  (https://github.com/openrisc/mor1kx/pull/72) marocchino doesn't really
  share any code with the rest of mor1kx and even now has a separate top
  level module (mor1kx_top_marocchino).

  Andrey and I have proposed moving the code to a new repo
  openrisc/mor1kx_marocchino.  Though it's not really exactly a mor1kx
  pipeline swap any longer the name might be controversial.

  Does anyone have a objection / suggestion for this?



Exciting to see all the work on Marocchino! I'm fine with the move and think it could make sense to drop the mor1kx name for the reasons you cited, but I'd leave that up to Andrey.


//Olof

  -Stafford
  _______________________________________________
  OpenRISC mailing list
  OpenRISC at lists.librecores.org
  https://lists.librecores.org/listinfo/openrisc

WBR
Andrey
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20190131/a34270b6/attachment.html>
