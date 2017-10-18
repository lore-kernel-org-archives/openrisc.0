From: Doug Evans <dje@google.com>
Date: Wed, 18 Oct 2017 20:15:35 +0000
Subject: [OpenRISC] [PATCH v6 3/6] sim: or1k: add or1k target to sim
Message-ID: <94eb2c05879608d374055bd7e7c3@google.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Stafford Horne writes:
 > This adds the OpenRISC 32-bit sim target.  The OpenRISC sim is a CGEN
 > based sim so the bulk of the code is generated from the .cpu files by
 > CGEN.  The engine decode and execute logic in mloop uses scache with
 > pseudo-basic-block extraction and supports both full and fast (switch)
 > modes.
 > 
 > The sim does not implement an mmu at the moment.  The sim does implement
 > fpu instructions via the common sim-fpu implementation.
 > 
 > sim/ChangeLog:
 > 
 > 2017-09-13  Stafford Horne  <shorne@gmail.com>
 > 	    Peter Gavin  <pgavin@gmail.com>
 > 
 > 	* configure.tgt: Add or1k sim.
 > 	* or1k/README: New file.
 > 	* or1k/Makefile.in: New file.
 > 	* or1k/configure.ac: New file.
 > 	* or1k/mloop.in: New file.
 > 	* or1k/or1k-sim.h: New file.
 > 	* or1k/or1k.c: New file.
 > 	* or1k/sim-if.c: New file.
 > 	* or1k/sim-main.h: New file.
 > 	* or1k/traps.c: New file.

LGTM
