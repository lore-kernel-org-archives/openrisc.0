From: Stafford Horne <shorne@gmail.com>
Date: Fri, 9 Jul 2021 06:44:34 +0900
Subject: [OpenRISC] Maybe another or1k bug
In-Reply-To: <942dec94-e7e6-33d6-84e6-715e5e368c98@linaro.org>
References: <dbcce22d-b288-2451-4a8d-681f802c6f49@benettiengineering.com>
 <CAAfxs77Y1qOzex=Bkn5c_4Zxt6nzZP2cpG6qJ85eXnrAm18FgA@mail.gmail.com>
 <6bc67759-18c2-bca5-bdb2-c637e873b8ab@benettiengineering.com>
 <YMvdpzYqcwNzAeQ/@antec> <YOYXPQENdaFWobWO@antec>
 <942dec94-e7e6-33d6-84e6-715e5e368c98@linaro.org>
Message-ID: <YOdxwtNeQ2eUr+L3@antec>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Jul 07, 2021 at 02:25:39PM -0700, Richard Henderson wrote:
> On 7/7/21 2:06 PM, Stafford Horne wrote:
> > +CC Richards other account
> > 
> > Hi Richard,
> > 
> > I Cced this to you twiddle.net account you on this one originally. Do you recall
> > why we added the below check in or1k bfd?  It seems to be overly restrictive and
> > causing some issues below.
> > 
> >   case R_OR1K_INSN_REL_26:
> >     if (bfd_link_pic (info) && !SYMBOL_REFERENCES_LOCAL (info, h))
> >       ERROR
> ...
> > > 4. The symbols are from `readelf -s`:
> > > 
> > >     221: 00008ce4   716 FUNC    GLOBAL PROTECTED   24 alSourcePausev
> > >     222: 00008fb0    36 FUNC    GLOBAL PROTECTED   24 alSourcePause
> > >     223: 00008fd4   784 FUNC    GLOBAL PROTECTED   24 alSourceStopv
> > >     224: 000092e4    36 FUNC    GLOBAL PROTECTED   24 alSourceStop
> > >     225: 00009308   720 FUNC    GLOBAL PROTECTED   24 alSourceRewindv
> > >     226: 000095d8    36 FUNC    GLOBAL PROTECTED   24 alSourceRewind
> 
> Ah, STV_PROTECTED.  Unusual.
> 
> It looks like this should be SYMBOL_CALLS_LOCAL.  The only difference from
> SYMBOL_REFERENCES_LOCAL is versus protected symbols.

Thanks Richard.

I will post a patch for this in a few days.  Or, maybe Giulio can do it if he
has time.

-Stafford
