From: Stafford Horne <shorne@gmail.com>
Date: Sat, 13 Nov 2021 12:16:38 +0900
Subject: [OpenRISC] [PATCH v2 12/13] build-many-glibcs.py: add OpenRISC
 support
In-Reply-To: <20211113031639.2402161-1-shorne@gmail.com>
References: <20211113031639.2402161-1-shorne@gmail.com>
Message-ID: <20211113031639.2402161-13-shorne@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

---
 scripts/build-many-glibcs.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/build-many-glibcs.py b/scripts/build-many-glibcs.py
index e8b9b213ca..40072883c2 100755
--- a/scripts/build-many-glibcs.py
+++ b/scripts/build-many-glibcs.py
@@ -334,6 +334,10 @@ class Context(object):
                                  'ccopts': '-mabi=64'}])
         self.add_config(arch='nios2',
                         os_name='linux-gnu')
+        self.add_config(arch='or1k',
+                        os_name='linux-gnu',
+                        variant='soft',
+                        gcc_cfg=['--with-multilib-list=mcmov'])
         self.add_config(arch='powerpc',
                         os_name='linux-gnu',
                         gcc_cfg=['--disable-multilib', '--enable-secureplt'],
@@ -1270,6 +1274,7 @@ def install_linux_headers(policy, cmdlist):
                 'microblaze': 'microblaze',
                 'mips': 'mips',
                 'nios2': 'nios2',
+                'or1k': 'openrisc',
                 'powerpc': 'powerpc',
                 's390': 's390',
                 'riscv32': 'riscv',
-- 
2.31.1

