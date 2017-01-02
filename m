From: Stafford Horne <shorne@gmail.com>
Date: Mon, 2 Jan 2017 11:16:04 +0900
Subject: [OpenRISC] [GIT PULL] Openrisc fixes for 4.10
Message-ID: <20170102021604.GE2777@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Linus, 

Please pull the below for Openrisc, There was nothing much interesting
here except a build fix pointed out by the test robots. Highlights:

 - Defined _text symbol for fix build error

-Stafford


The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  https://github.com/openrisc/linux.git tags/openrisc-for-linus

for you to fetch changes up to 086cc1c31a0ec075dac02425367c871bb65bc2c9:

  openrisc: Add _text symbol to fix ksym build error (2017-01-02
10:35:11 +0900)

----------------------------------------------------------------
Openrisc more fixes for 4.10

----------------------------------------------------------------
Stafford Horne (1):
      openrisc: Add _text symbol to fix ksym build error

 arch/openrisc/kernel/vmlinux.lds.S | 2 ++
 1 file changed, 2 insertions(+)


