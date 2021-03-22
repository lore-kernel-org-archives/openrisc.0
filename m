From: Michal Hocko <mhocko@suse.com>
Date: Mon, 22 Mar 2021 14:35:41 +0100
Subject: [OpenRISC] [PATCH RFC 1/3] drivers/char: remove /dev/kmem for
 good
In-Reply-To: <20210319143452.25948-2-david@redhat.com>
References: <20210319143452.25948-1-david@redhat.com>
 <20210319143452.25948-2-david@redhat.com>
Message-ID: <YFidLVQs+/zw4aIF@dhcp22.suse.cz>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri 19-03-21 15:34:50, David Hildenbrand wrote:
> Exploring /dev/kmem and /dev/mem in the context of memory hot(un)plug and
> memory ballooning, I started questioning the existance of /dev/kmem.
> 
> Comparing it with the /proc/kcore implementation, it does not seem to be
> able to deal with things like
> a) Pages unmapped from the direct mapping (e.g., to be used by secretmem)
>   -> kern_addr_valid(). virt_addr_valid() is not sufficient.
> b) Special cases like gart aperture memory that is not to be touched
>   -> mem_pfn_is_ram()
> Unless I am missing something, it's at least broken in some cases and might
> fault/crash the machine.
> 
> Looks like its existance has been questioned before in 2005 and 2010
> [1], after ~11 additional years, it might make sense to revive the
> discussion.
> 
> CONFIG_DEVKMEM is only enabled in a single defconfig (on purpose or by
> mistake?). All distributions I looked at disable it.
> 
> 1) /dev/kmem was popular for rootkits [2] before it got disabled
>    basically everywhere. Ubuntu documents [3] "There is no modern user of
>    /dev/kmem any more beyond attackers using it to load kernel rootkits.".
>    RHEL documents in a BZ [5] "it served no practical purpose other than to
>    serve as a potential security problem or to enable binary module drivers
>    to access structures/functions they shouldn't be touching"
> 
> 2) /proc/kcore is a decent interface to have a controlled way to read
>    kernel memory for debugging puposes. (will need some extensions to
>    deal with memory offlining/unplug, memory ballooning, and poisoned
>    pages, though)
> 
> 3) It might be useful for corner case debugging [1]. KDB/KGDB might be a
>    better fit, especially, to write random memory; harder to shoot
>    yourself into the foot.
> 
> 4) "Kernel Memory Editor" hasn't seen any updates since 2000 and seems
>    to be incompatible with 64bit [1]. For educational purposes,
>    /proc/kcore might be used to monitor value updates -- or older
>    kernels can be used.
> 
> 5) It's broken on arm64, and therefore, completely disabled there.
> 
> Looks like it's essentially unused and has been replaced by better
> suited interfaces for individual tasks (/proc/kcore, KDB/KGDB). Let's
> just remove it.
> 
> [1] https://lwn.net/Articles/147901/
> [2] https://www.linuxjournal.com/article/10505
> [3] https://wiki.ubuntu.com/Security/Features#A.2Fdev.2Fkmem_disabled
> [4] https://sourceforge.net/projects/kme/
> [5] https://bugzilla.redhat.com/show_bug.cgi?id=154796
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Hillf Danton <hdanton@sina.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: huang ying <huang.ying.caritas@gmail.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@bootlin.com>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Brian Cain <bcain@codeaurora.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: Rich Felker <dalias@libc.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Rob Herring <robh@kernel.org>
> Cc: "Pavel Machek (CIP)" <pavel@denx.de>
> Cc: Theodore Dubois <tblodt@icloud.com>
> Cc: "Alexander A. Klimov" <grandmaster@al2klimov.de>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Xiaoming Ni <nixiaoming@huawei.com>
> Cc: Robert Richter <rric@kernel.org>
> Cc: William Cohen <wcohen@redhat.com>
> Cc: Corentin Labbe <clabbe@baylibre.com>
> Cc: Kairui Song <kasong@redhat.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: linux-doc at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: uclinux-h8-devel at lists.sourceforge.jp
> Cc: linux-hexagon at vger.kernel.org
> Cc: linux-m68k at lists.linux-m68k.org
> Cc: openrisc at lists.librecores.org
> Cc: linux-sh at vger.kernel.org
> Cc: sparclinux at vger.kernel.org
> Cc: linux-xtensa at linux-xtensa.org
> Cc: linux-fsdevel at vger.kernel.org
> Cc: Linux API <linux-api@vger.kernel.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>
-- 
Michal Hocko
SUSE Labs
