From: Stafford Horne <shorne@gmail.com>
Date: Sun, 14 Apr 2019 15:44:15 +0900
Subject: [OpenRISC] [PATCH v2 3/6] sim/or1k: Regenerate sim for
 orfp64a32 spec
In-Reply-To: <20190413214002.GJ2737@embecosm.com>
References: <20190409213925.32699-1-shorne@gmail.com>
 <20190409213925.32699-4-shorne@gmail.com>
 <20190413214002.GJ2737@embecosm.com>
Message-ID: <20190414064415.GE32284@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sat, Apr 13, 2019 at 10:40:02PM +0100, Andrew Burgess wrote:
> * Stafford Horne <shorne@gmail.com> [2019-04-10 06:39:22 +0900]:
> 
> > sim/ChangeLog:
> > 
> > 	* or1k/cpu.c: Regenerate.
> > 	* or1k/cpu.h: Regenerate.
> > 	* or1k/decode.c: Regenerate.
> > 	* or1k/decode.h: Regenerate.
> > 	* or1k/model.c: Regenerate.
> > 	* or1k/sem-switch.c: Regenerate.
> > 	* or1k/sem.c: Regenerate.
> 
> Kind-of hard to argue with that :)
> 
> This is fine with me,

Thanks, actually after some recent reviews of the spec that this is implementing
we may be having a revision to how we encode some of these instructions.

Thread for those interested:

 - https://lists.librecores.org/pipermail/openrisc/2019-April/001958.html

I will have to make some revisions on this and will submit the series again in a
few weeks.

-Stafford
