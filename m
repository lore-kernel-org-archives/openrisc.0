From: Stafford Horne <shorne@gmail.com>
Date: Mon, 19 Oct 2020 05:16:50 +0900
Subject: [OpenRISC] [PATCH 0/1] OpenRISC binder.c compiler failure fix for
 stable
Message-ID: <20201018201651.2604140-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

This is a backported version of the v5.9 patch to fix issues on OpenRISC using
get_user with 64-bit values.  This also fixes compilation failures when
compiling binder.c.

Discussion: https://lkml.org/lkml/2020/10/16/198

Stafford Horne (1):
  openrisc: Fix issue with get_user for 64-bit values

 arch/openrisc/include/asm/uaccess.h | 35 ++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 13 deletions(-)

-- 
2.26.2

