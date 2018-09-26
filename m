From: Michal Hocko <mhocko@kernel.org>
Date: Wed, 26 Sep 2018 16:23:19 +0200
Subject: [OpenRISC] [PATCH 14/30] memblock: add align parameter to
 memblock_alloc_node()
In-Reply-To: <20180926134335.GF4628@rapoport-lnx>
References: <1536927045-23536-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1536927045-23536-15-git-send-email-rppt@linux.vnet.ibm.com>
 <20180926093127.GO6278@dhcp22.suse.cz>
 <20180926093648.GP6278@dhcp22.suse.cz>
 <20180926134335.GF4628@rapoport-lnx>
Message-ID: <20180926142319.GA6278@dhcp22.suse.cz>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed 26-09-18 16:43:35, Mike Rapoport wrote:
> On Wed, Sep 26, 2018 at 11:36:48AM +0200, Michal Hocko wrote:
> > On Wed 26-09-18 11:31:27, Michal Hocko wrote:
> > > On Fri 14-09-18 15:10:29, Mike Rapoport wrote:
> > > > With the align parameter memblock_alloc_node() can be used as drop in
> > > > replacement for alloc_bootmem_pages_node() and __alloc_bootmem_node(),
> > > > which is done in the following patches.
> > > 
> > > /me confused. Why do we need this patch at all? Maybe it should be
> > > folded into the later patch you are refereing here?
> > 
> > OK, I can see 1536927045-23536-17-git-send-email-rppt at linux.vnet.ibm.com
> > now. If you are going to repost for whatever reason please merge those
> > two. Also I would get rid of the implicit "0 implies SMP_CACHE_BYTES"
> > behavior. It is subtle and you have to dig deep to find that out. Why
> > not make it explicit?
> 
> Agree. I'd just prefer to make it a separate patch rather then resend the
> whole series. 

Sure, no objection from me.

-- 
Michal Hocko
SUSE Labs
