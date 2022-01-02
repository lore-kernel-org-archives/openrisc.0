From: Stafford Horne <shorne@gmail.com>
Date: Sun, 2 Jan 2022 09:30:11 +0900
Subject: [OpenRISC] [PATCH v4 10/13] or1k: ABI lists
In-Reply-To: <CAAfxs77-NEGg5vCTPxNd7aJmOqvvf1Nf6=Mm8YfrFxJ6GOcDHQ@mail.gmail.com>
References: <20211229044251.2203653-1-shorne@gmail.com>
 <20211229044251.2203653-11-shorne@gmail.com>
 <alpine.DEB.2.22.394.2112311744180.2293191@digraph.polyomino.org.uk>
 <CAAfxs77-NEGg5vCTPxNd7aJmOqvvf1Nf6=Mm8YfrFxJ6GOcDHQ@mail.gmail.com>
Message-ID: <YdDyExgBArUaOmOc@antec>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sat, Jan 01, 2022 at 01:54:09PM +0900, Stafford Horne wrote:
> On Sat, Jan 1, 2022, 2:45 AM Joseph Myers <joseph@codesourcery.com> wrote:
> 
> > On Wed, 29 Dec 2021, Stafford Horne via Libc-alpha wrote:
> >
> > >  sysdeps/unix/sysv/linux/or1k/libnsl.abilist   |  121 +
> >
> > As noted for the LoongArch port submission, I don't think new ports should
> > have libnsl or an ABI test baseline for it.
> >
> 
> Ok, I'll have a look. Is this something we have to do in new ports or is
> this something wrong with the generic parts?

Hello,

The option to build libnsl was removed with ae7a94e5e3.  However, since there is
no longer and option it is now build unconditionally for ifdef have-GLIBC_2.28.

Our new architectures will have have-GLIBC_2.35, so libnsl is not built at all.

This libnsl.abilist file must just be leftover.  I removed it and check-abi
still passes.

-Stafford
