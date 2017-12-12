From: Stafford Horne <shorne@gmail.com>
Date: Wed, 13 Dec 2017 00:10:30 +0900
Subject: [OpenRISC] or1k GDB port - upstream now
Message-ID: <20171212151030.GC3483@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi All,

I have just pushed the or1k port of gdb upstream.  Thanks to all those that have
helped review patches over the last year.

There are still a few things left to do:

Tomorrow or Next day
 - MAINTAINERS - add myself for or1k port
 - NEWS - add a news line for the or1k port

Next few weeks
 - arbitrary reggroups - finish up my tdesc patch [0]

Long term
 - linux support - add linux debugging support

Please let me know if there are any concerns or anything I am missing.

-Stafford

[0] https://sourceware.org/ml/gdb-patches/2017-06/msg00187.html
