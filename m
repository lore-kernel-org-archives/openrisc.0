From: Stafford Horne <shorne@gmail.com>
Date: Fri, 19 Nov 2021 20:45:58 +0900
Subject: [OpenRISC] [PATCH v2 03/13] or1k: ABI Implementation
In-Reply-To: <alpine.DEB.2.22.394.2111182213000.1393807@digraph.polyomino.org.uk>
References: <20211113031639.2402161-1-shorne@gmail.com>
 <20211113031639.2402161-4-shorne@gmail.com>
 <alpine.DEB.2.22.394.2111182213000.1393807@digraph.polyomino.org.uk>
Message-ID: <YZeOdryKnxllpuNk@antec>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Nov 18, 2021 at 10:13:41PM +0000, Joseph Myers wrote:
> On Sat, 13 Nov 2021, Stafford Horne via Libc-alpha wrote:
> 
> > +/* Helper for generic ____longjmp_chk(). */
> 
> Don't use () after a function name just to indicate it's a function, as 
> opposed to a function call with no arguments (see the GNU Coding 
> Standards).

OK, sorry about that, I know this but didn't remember when going though
the patch on my own.  I will go through and clean this up.

-Stafford
