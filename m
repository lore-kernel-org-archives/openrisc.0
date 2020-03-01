From: Stafford Horne <shorne@gmail.com>
Date: Mon,  2 Mar 2020 06:38:48 +0900
Subject: [OpenRISC] [PATCH v2 0/3] OpenRISC clone3 support
Message-ID: <20200301213851.8096-1-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

This series fixes the clone3 not implemented warnings I have been seeing
during recent builds.  It was a simple case of implementing copy_thread_tls
and turning on clone3 generic support.  Testing shows no issues.

Changes since v1:

 - Fix some comments pointed out in reviews
 - Add Acks to 2/3 and 3/3 from Christian Brauner

Stafford Horne (3):
  openrisc: Convert copy_thread to copy_thread_tls
  openrisc: Enable the clone3 syscall
  openrisc: Cleanup copy_thread_tls docs and comments

 arch/openrisc/Kconfig                   |  1 +
 arch/openrisc/include/uapi/asm/unistd.h |  1 +
 arch/openrisc/kernel/process.c          | 18 ++++++------------
 3 files changed, 8 insertions(+), 12 deletions(-)

-- 
2.21.0

