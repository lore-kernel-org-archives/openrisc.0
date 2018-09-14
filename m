From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Date: Fri, 14 Sep 2018 15:10:45 +0300
Subject: [OpenRISC] [PATCH 30/30] docs/boot-time-mm: remove bootmem
	documentation
In-Reply-To: <1536927045-23536-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1536927045-23536-1-git-send-email-rppt@linux.vnet.ibm.com>
Message-ID: <1536927045-23536-31-git-send-email-rppt@linux.vnet.ibm.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 Documentation/core-api/boot-time-mm.rst | 71 +++++----------------------------
 1 file changed, 10 insertions(+), 61 deletions(-)

diff --git a/Documentation/core-api/boot-time-mm.rst b/Documentation/core-api/boot-time-mm.rst
index 03cb164..e5ec9f1 100644
--- a/Documentation/core-api/boot-time-mm.rst
+++ b/Documentation/core-api/boot-time-mm.rst
@@ -5,54 +5,23 @@ Boot time memory management
 Early system initialization cannot use "normal" memory management
 simply because it is not set up yet. But there is still need to
 allocate memory for various data structures, for instance for the
-physical page allocator. To address this, a specialized allocator
-called the :ref:`Boot Memory Allocator <bootmem>`, or bootmem, was
-introduced. Several years later PowerPC developers added a "Logical
-Memory Blocks" allocator, which was later adopted by other
-architectures and renamed to :ref:`memblock <memblock>`. There is also
-a compatibility layer called `nobootmem` that translates bootmem
-allocation interfaces to memblock calls.
+physical page allocator.
 
-The selection of the early allocator is done using
-``CONFIG_NO_BOOTMEM`` and ``CONFIG_HAVE_MEMBLOCK`` kernel
-configuration options. These options are enabled or disabled
-statically by the architectures' Kconfig files.
-
-* Architectures that rely only on bootmem select
-  ``CONFIG_NO_BOOTMEM=n && CONFIG_HAVE_MEMBLOCK=n``.
-* The users of memblock with the nobootmem compatibility layer set
-  ``CONFIG_NO_BOOTMEM=y && CONFIG_HAVE_MEMBLOCK=y``.
-* And for those that use both memblock and bootmem the configuration
-  includes ``CONFIG_NO_BOOTMEM=n && CONFIG_HAVE_MEMBLOCK=y``.
-
-Whichever allocator is used, it is the responsibility of the
-architecture specific initialization to set it up in
-:c:func:`setup_arch` and tear it down in :c:func:`mem_init` functions.
+A specialized allocator called ``memblock`` performs the
+boot time memory management. The architecture specific initialization
+must set it up in :c:func:`setup_arch` and tear it down in
+:c:func:`mem_init` functions.
 
 Once the early memory management is available it offers a variety of
 functions and macros for memory allocations. The allocation request
 may be directed to the first (and probably the only) node or to a
 particular node in a NUMA system. There are API variants that panic
-when an allocation fails and those that don't. And more recent and
-advanced memblock even allows controlling its own behaviour.
-
-.. _bootmem:
-
-Bootmem
-=======
-
-(mostly stolen from Mel Gorman's "Understanding the Linux Virtual
-Memory Manager" `book`_)
-
-.. _book: https://www.kernel.org/doc/gorman/
-
-.. kernel-doc:: mm/bootmem.c
-   :doc: bootmem overview
+when an allocation fails and those that don't.
 
-.. _memblock:
+Memblock also offers a variety of APIs that control its own behaviour.
 
-Memblock
-========
+Memblock Overview
+=================
 
 .. kernel-doc:: mm/memblock.c
    :doc: memblock overview
@@ -61,26 +30,6 @@ Memblock
 Functions and structures
 ========================
 
-Common API
-----------
-
-The functions that are described in this section are available
-regardless of what early memory manager is enabled.
-
-.. kernel-doc:: mm/nobootmem.c
-
-Bootmem specific API
---------------------
-
-These interfaces available only with bootmem, i.e when ``CONFIG_NO_BOOTMEM=n``
-
-.. kernel-doc:: include/linux/bootmem.h
-.. kernel-doc:: mm/bootmem.c
-   :nodocs:
-
-Memblock specific API
----------------------
-
 Here is the description of memblock data structures, functions and
 macros. Some of them are actually internal, but since they are
 documented it would be silly to omit them. Besides, reading the
@@ -89,4 +38,4 @@ really happens under the hood.
 
 .. kernel-doc:: include/linux/memblock.h
 .. kernel-doc:: mm/memblock.c
-   :nodocs:
+   :functions:
-- 
2.7.4

