From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Date: Fri, 13 Jan 2017 11:46:38 +0100
Subject: [OpenRISC] [PATCH v3 0/8] uapi: export all headers under uapi
	directories
In-Reply-To: <3131144.4Ej3KFWRbz@wuerfel>
References: <3131144.4Ej3KFWRbz@wuerfel>
Message-ID: <1484304406-10820-1-git-send-email-nicolas.dichtel@6wind.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Here is the v3 of this series. The first 5 patches are just cleanup: some
exported headers were still under a non-uapi directory or (x86 case) were
wrongly exported.
The patch 6 was spotted by code review: there is no in-tree user of this
functionality.
Patches 7 and 8 remove the need to list explicitly headers. Now all files
under an uapi directory are exported.

This series has been tested with a 'make headers_install' on x86 and a
'make headers_install_all'. I've checked the result of both commands.

This patch is built against linus tree. If I must rebase it against the kbuild
tree, just tell me ;-)

v2 -> v3:
 - patch #1: remove arch/arm/include/asm/types.h
 - patch #2: remove arch/h8300/include/asm/bitsperlong.h
 - patch #3: remove arch/nios2/include/uapi/asm/setup.h
 - patch #4: don't export msr-index.h
 - patch #5: fix a typo: s/unput-files3-name/input-files3-name
 - patch #6: no change
 - patch #7: fix include/uapi/asm-generic/Kbuild.asm by introducing mandatory-y
 - add patch #8

v1 -> v2:
 - add patch #1 to #6
 - patch #7: remove use of header-y

Comments are welcomed,
Nicolas
