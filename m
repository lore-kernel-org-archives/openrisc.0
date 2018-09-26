From: Michal Hocko <mhocko@kernel.org>
Date: Wed, 26 Sep 2018 11:41:54 +0200
Subject: [OpenRISC] [PATCH 00/30] mm: remove bootmem allocator
In-Reply-To: <1536927045-23536-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1536927045-23536-1-git-send-email-rppt@linux.vnet.ibm.com>
Message-ID: <20180926094154.GT6278@dhcp22.suse.cz>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri 14-09-18 15:10:15, Mike Rapoport wrote:
[...]
>  326 files changed, 866 insertions(+), 2539 deletions(-)
>  delete mode 100644 include/linux/bootmem.h
>  delete mode 100644 mm/bootmem.c
>  delete mode 100644 mm/nobootmem.c

I _really_ love this part the most! Not only we got rid of the
translation which always has been a headache but also this nicely shows
how having multiple allocators hurt. I believe further cleanups on top
will make the boot allocator even a place where you look and your eyes
do not want to jump out.

I have only went through patches without my acks from the previous
iteration and there are only minor comments. This looks good overall.

Nice work Mike!
-- 
Michal Hocko
SUSE Labs
