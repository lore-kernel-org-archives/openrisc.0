From: Stafford Horne <shorne@gmail.com>
Date: Sun, 27 Mar 2022 16:30:00 +0900
Subject: [OpenRISC] [GIT PULL] OpenRISC updates for 5.18
Message-ID: <YkASeMlP+k/OJm3+@antec>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Linus,

Not much for OpenRISC this merge window, I do have some things on the back
burner like sparse warning cleanups and new defconfigs.  But I didn't get time
to polish the patches off for this round.  There are OpenRISC updates coming in
via other queues like removal of set_fs() and possibly new generic ticket locks.

With that said please consider for pull:

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git at github.com:openrisc/linux.git tags/for-linus

for you to fetch changes up to 862cf8d5fd98ed8ea8989726ed5da53761a9ed76:

  openrisc/boot: Remove unnecessary initialisation in memcpy(). (2022-01-30 17:44:34 +0900)

----------------------------------------------------------------
OpenRISC updates for 5.18

Fixups and enhancements for OpenRISC:
 - Small fixup to remove duplicate initializer in memcpy from Kuniyuki
   Iwashima

----------------------------------------------------------------
Kuniyuki Iwashima (1):
      openrisc/boot: Remove unnecessary initialisation in memcpy().

 arch/openrisc/lib/memcpy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
