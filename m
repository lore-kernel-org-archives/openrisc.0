From: Doug Evans <dje@google.com>
Date: Mon, 09 Oct 2017 17:01:22 +0000
Subject: [OpenRISC] [PATCH v5 1/6] sim: cgen: add remainder functions
 (needed for OR1K lf.rem.[sd])
Message-ID: <94eb2c070010e06fcd055b202330@google.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Stafford Horne writes:
 > From: Peter Gavin <pgavin@gmail.com>
 > 
 > * sim/common/ChangeLog:
 > 
 > 2016-05-21  Peter Gavin  <pgavin@gmail.com>
 > 	    Stafford Horne <shorne@gmail.com>
 > 
 > 	* cgen-accfp.c (remsf, remdf): New function.
 > 	(cgen_init_accurate_fpu): Add remsf and remdf.
 > 	* cgen-fpu.h (cgen_fp_ops): Add remsf, remdf, remxf and remtf.
 > 	* sim-fpu.c (sim_fpu_rem): New function.
 > 	* sim-fpu.h (sim_fpu_status_invalid_irx): New enum.
 > 	(sim_fpu_rem): New function.

LGTM (with the discussed changes to date).
