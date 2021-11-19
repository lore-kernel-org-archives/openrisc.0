From: Stafford Horne <shorne@gmail.com>
Date: Sat, 20 Nov 2021 08:03:38 +0900
Subject: [OpenRISC] [PATCH v2 05/13] or1k: Thread Local Storage support
In-Reply-To: <alpine.DEB.2.22.394.2111182219580.1393807@digraph.polyomino.org.uk>
References: <20211113031639.2402161-1-shorne@gmail.com>
 <20211113031639.2402161-6-shorne@gmail.com>
 <alpine.DEB.2.22.394.2111182219580.1393807@digraph.polyomino.org.uk>
Message-ID: <YZgtSoIRAiH/Xjjt@antec>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Nov 18, 2021 at 10:22:23PM +0000, Joseph Myers wrote:
> On Sat, 13 Nov 2021, Stafford Horne via Libc-alpha wrote:
> 
> > diff --git a/sysdeps/or1k/dl-tls.h b/sysdeps/or1k/dl-tls.h
> > new file mode 100644
> > index 0000000000..f25645c715
> > --- /dev/null
> > +++ b/sysdeps/or1k/dl-tls.h
> > @@ -0,0 +1,26 @@
> > +/* Copyright (C) 2021 Free Software Foundation, Inc.
> 
> Each file should have a one-line description on the line before the 
> copyright notice.

OK, I went through the patch's and made sure I have this on all .c .h and .S
files.

> > diff --git a/sysdeps/or1k/libc-tls.c b/sysdeps/or1k/libc-tls.c
> > new file mode 100644
> > index 0000000000..43571944dd
> > --- /dev/null
> > +++ b/sysdeps/or1k/libc-tls.c
> > @@ -0,0 +1,32 @@
> > +/* Copyright (C) 2021 Free Software Foundation, Inc.
> 
> Likewise.
> 
> > diff --git a/sysdeps/or1k/stackinfo.h b/sysdeps/or1k/stackinfo.h
> > new file mode 100644
> > index 0000000000..14e767c5bf
> > --- /dev/null
> > +++ b/sysdeps/or1k/stackinfo.h
> > @@ -0,0 +1,33 @@
> > +/* Copyright (C) 2021 Free Software Foundation, Inc.
> 
> Likewise.
> 
> > +/* Default to an executable stack.  PF_X can be overridden if PT_GNU_STACK is
> > + * present, but it is presumed absent.  */
> 
> We don't use '*' at the start of second and subsequent lines of comments.

OK, I went through the patch and tried to sort all of these occurances out.
Also there were a few where we didn't have two spaces after period ".". Also, a
few other similar issues.

> (It seems unfortunate for a new port to default to executable stacks, but 
> it looks like this is indeed what the Linux kernel port to OpenRISC does, 
> given the lack of an override of the default VM_DATA_DEFAULT_FLAGS and 
> VM_STACK_DEFAULT_FLAGS.)

Yes.

Thanks for reviewing.

-Stafford
