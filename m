From: Stafford Horne <shorne@gmail.com>
Date: Tue, 18 Apr 2017 23:27:23 +0900
Subject: [OpenRISC] [Qemu-devel] [PATCH 7/7] target/openrisc: Implement
 full vmstate serialization
In-Reply-To: <2b6eee7d-e83d-5d0f-c1ef-a8a85236807d@twiddle.net>
References: <cover.1492384862.git.shorne@gmail.com>
 <fae2ac85b7226ec28c8419f488cd9947bb6142a0.1492384862.git.shorne@gmail.com>
 <2b6eee7d-e83d-5d0f-c1ef-a8a85236807d@twiddle.net>
Message-ID: <20170418142723.GD2599@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Apr 18, 2017 at 01:14:19AM -0700, Richard Henderson wrote:
> On 04/16/2017 04:23 PM, Stafford Horne wrote:
> > Previously serialization did not persist the tlb, timer, pic and other
> > key state items.  This meant snapshotting and restoring a running os
> > would crash. After adding these I am able to take snapshots of a
> > running linux os and restore at a later time.
> > 
> > I am currently not trying to maintain capatibility with older versions
> > as I do not believe this really worked before or anyone used it.
> 
> That's fine, but you still have to bump the version numbers.

Actually, I bumped the version in the previous patch.  Ill make that more
clear an do that in this patch instead.

-Stafford

> r~
> 
