From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 1 Dec 2016 08:35:55 +1100
Subject: [OpenRISC] Add openrisc for-next branch to linux-next
In-Reply-To: <alpine.LFD.2.20.1611302214520.29569@lianli.shorne-pla.net>
References: <alpine.LFD.2.20.1611302214520.29569@lianli.shorne-pla.net>
Message-ID: <20161201083555.1b9005c2@canb.auug.org.au>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Stafford,

On Wed, 30 Nov 2016 22:22:41 +0900 (JST) Stafford Horne <shorne@gmail.com> wrote:
>
> I have been working on getting the OpenRISC backlog of fixes sorted out 
> for upstream.  Can this branch be added to linux-next?
> 
>    git://github.com/openrisc/linux.git for-next
> 
> These have been through a few reviews and we plan to ask Linus to pull in 
> the next merge window.

Added from today.

Just a note: your top commits has no Signed-off-by from you as the committer ...

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window. 

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and 
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

-- 
Cheers,
Stephen Rothwell 
sfr at canb.auug.org.au

