From: Stafford Horne <shorne@gmail.com>
Date: Mon,  6 Feb 2017 23:38:37 +0900
Subject: [OpenRISC] [PATCH 0/3] openrisc: various fixes
Message-ID: <cover.1486391219.git.shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello,

These are a few patches that have collected in the openrisc newlib
repository on github over the last year.  Most issues were found
when running the gdb test suite as I worked on getting that ready
for upstream.

I am working with Stefan Wallentowitz who has sent openrisc patches
in the past.

Olof Kindgren (1):
  or1k: Make open reentrant

Stafford Horne (2):
  libgloss: or1k: If available call the init for init_array
  libgloss: Remove duplicate definition of environ

 libgloss/or1k/crt0.S     | 6 ++++++
 libgloss/or1k/syscalls.c | 5 +----
 2 files changed, 7 insertions(+), 4 deletions(-)

-- 
2.9.3

