From: Stafford Horne <shorne@gmail.com>
Date: Thu, 23 Feb 2017 07:42:42 +0900
Subject: [OpenRISC] [PATCH v3 09/25] openrisc: add optimized atomic
 operations
In-Reply-To: <c775b4d1-fa98-c1b2-d212-1441343b62d4@twiddle.net>
References: <cover.1487702890.git.shorne@gmail.com>
 <1479fc4a4a18712003849341affe74b2a0da609a.1487702890.git.shorne@gmail.com>
 <20170222112737.GM6515@twins.programming.kicks-ass.net>
 <20170222142246.GC2449@lianli.shorne-pla.net>
 <c775b4d1-fa98-c1b2-d212-1441343b62d4@twiddle.net>
Message-ID: <20170222224242.GD2449@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Feb 23, 2017 at 04:31:34AM +1100, Richard Henderson wrote:
> On 02/23/2017 01:22 AM, Stafford Horne wrote:
> > > static inline int __atomic_add_unless(atomic_t *v, int a, int u)
> > > {
> > > 	int old, tmp;
> > > 
> > > 	__asm__ __volatile__(
> > > 		"1:     l.lwa %0, 0(%2)         \n"
> > > 		"       l.sfeq %0, %4           \n"
> > > 		"       l.bf 2f                 \n"
> > > 		"        l.nop                  \n"
> > > 		"	l.add %1, %0, %3	\n"
> 
> You can move this add into the delay slot and drop the preceding nop.

Thanks, Thats right, also here the 2: label being after the l.nop can be
applied.   I should have thought about it.  I made the change, Ill also
fix/look again in the other places.

-Stafford

> 
> r~
