From: Doug Evans <dje@google.com>
Date: Wed, 18 Oct 2017 20:09:28 +0000
Subject: [OpenRISC] [PATCH v6 2/6] sim: cgen: add MUL2OFSI and MUL1OFSI
 functions (needed for OR1K l.mul[u])
Message-ID: <94eb2c0534042260b1055bd7d1ff@google.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Stafford Horne writes:
 > From: Peter Gavin <pgavin@gmail.com>
 > 
 > sim/common/ChangeLog:
 > 
 > 2012-03-14  Peter Gavin  <pgavin@gmail.com>
 > 	    Stafford Horne  <shorne@gmail.com>
 > 
 > 	* cgen-ops.h (MUL2OFSI): New function, 2's complement overflow
 > 	flag.
 > 	(MUL1OFSI): New function, 1's complement overflow flag.

LGTM
