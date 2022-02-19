From: Stafford Horne <shorne@gmail.com>
Date: Sun, 20 Feb 2022 08:04:55 +0900
Subject: [OpenRISC] Architecture Revision 1.4 - FPCSR access
Message-ID: <CAAfxs770Shy8Unwo75aXiT135AvBwyr3oxOQZ5hnTeckKBdVoA@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi All,

A next milestone for OpenRISC is to add Linux user-space access for
the FPU.  One limitation in the OpenRISC architecture is that the
FPCSR is not User-Space accessible.

This is required to use all of the user-space FPU functionality
available in C Libraries like glibc (i.e. setting rounding, and
checking exceptions).  This will help Andrey with Marocchino FPU
testing as well as help get the hard-float support for glibc
upstreamed.

I have created an initial PR for the architecture specification change:
  https://github.com/openrisc/doc/pull/4

Changes for cores to support FPCSR access have been done by Andrey:
  mor1kx - https://github.com/openrisc/mor1kx/commits/fpcsr_free_access
  marocchino - https://github.com/openrisc/or1k_marocchino/tree/fpcsr_free_access

Hard float support for GLIBC is available here:
  https://github.com/openrisc/or1k-glibc/commits/or1k-hard-float

Concerns
There may be some concern that this makes a change that means hardware
expecting access to FPCSR could not run on older CPUs.  I think such
future software could detect this by attempting a read/write to the
FPCSR to check if access is available.

At this point we could also look into the proposal to change how SPR
access is handled as described in P3.  P3 proposes that we could
change unauthorized SPR access to raise Illegal Instruction Exceptions
and have access controlled by the OS.   However I think that will have
more impact than we need at this time.

  P3 https://openrisc.io/proposals/spr-access-updates

-Stafford
