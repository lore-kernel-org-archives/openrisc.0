From: Stafford Horne <shorne@gmail.com>
Date: Sun, 20 Aug 2017 00:01:29 +0900
Subject: [OpenRISC] OpenRISC Specification updates for Multicore
Message-ID: <20170819150129.GG3031@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello,

It has been on my todo list for a while to update the OpenRISC
specification to add some of the mutlicore features which have been
implemented but not yet made it into the spec.

I have created 2 new architecture proposals:

  https://openrisc.io/proposals/tls
  Here the proposal is to formally designate r10 as the TLS reserved
  register in the spec.  Please help to review my proposed wording and
  change. (This is not related to multicore)

  https://openrisc.io/proposals/atomic-boundary
  Here the proposal is one that came from Peter Zijlstra when reviewing
  OpenRISC locking.  We should clarify that atomic reservations will be
  cancelled for any storage overlapping the load address reservation.  This
  includes byte and half-word offset stores.

Also, I propose to finally add the following:

  https://openrisc.io/proposals/core-identifier-and-number-of-cores
  The coreid and numcores SPRs have been implemented in several cores but
  are not yet part of the spec.  We would like to formally add them as they
  have been implemented.

Also, I am planning to add a section to the specification about OpenRISC
Multicore Systems.  With a quick overview of:

  - Atomic Instructions
  - Cache Coherency
  - Core identification
  - Bootstrapping Multicore Systems
  - Timer synchronization
    * Via global timer hardware
    * Via software lock-sync routines
  - Details on inter processor communication via the OMPIC

Please let me know if you think anything else is relevant.

Also if I get any Yay or Nay I will start incorporating the above into the
spec.

-Stafford

