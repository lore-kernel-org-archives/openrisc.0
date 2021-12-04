From: Stafford Horne <shorne@gmail.com>
Date: Sat,  4 Dec 2021 11:18:39 +0900
Subject: [OpenRISC] [PATCH 0/3] OpenRISC Switch and Clone cleanups
Message-ID: <20211204021842.1853549-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

These are a few patches that came after auditing the OpenRISC switch code
recently following the discussion with Rob and Arnd and the clone and clone3
wrappers [0].

I noticed a few places where OpenRISC could shave a few instructions and also
that we need a ABI wrapper for clone3.

[0] https://lore.kernel.org/all/41206fc7-f8ce-98aa-3718-ba3e1431e320 at landley.net/T/#m9c0cdb2703813b9df4da04cf6b30de1f1aa89944

Stafford Horne (3):
  openrisc: Cleanup switch code and comments
  openrisc: Use delay slot for clone and fork wrappers
  openrisc: Add clone3 ABI wrapper

 arch/openrisc/include/asm/syscalls.h |  2 ++
 arch/openrisc/kernel/entry.S         | 27 +++++++++++++--------------
 2 files changed, 15 insertions(+), 14 deletions(-)

-- 
2.31.1

