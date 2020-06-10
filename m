From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Date: Wed, 10 Jun 2020 17:48:11 +0200
Subject: [OpenRISC] Possible duplicate page fault accounting on some archs
 after commit 4064b9827063
Message-ID: <20200610174811.44b94525@thinkpad>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi,

Some architectures have their page fault accounting code inside the fault
retry loop, and rely on only going through that code once. Before commit
4064b9827063 ("mm: allow VM_FAULT_RETRY for multiple times"), that was
ensured by testing for and clearing FAULT_FLAG_ALLOW_RETRY.

That commit had to remove the clearing of FAULT_FLAG_ALLOW_RETRY for all
architectures, and introduced a subtle change to page fault accounting
logic in the affected archs. It is now possible to go through the retry
loop multiple times, and the affected archs would then account multiple
page faults instead of just one.

This was found by coincidence in s390 code, and a quick check showed that
there are quite a lot of other architectures that seem to be affected in a
similar way. I'm preparing a fix for s390, by moving the accounting behind
the retry loop, similar to x86. It is not completely straight-forward, so
I leave the fix for other archs to the respective maintainers.

Added the lists for possibly affected archs on cc, but no guarantee for
completeness.

Regards,
Gerald
