From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Fri, 23 Feb 2018 14:32:08 -0500
Subject: [OpenRISC] Removing architectures without upstream gcc support
In-Reply-To: <20180223181943.GF30522@ZenIV.linux.org.uk>
References: <CAK8P3a2-6YwRR3j7J78fVHSvDpq8Kf4wRj6d9mnGgAxgkYypxg@mail.gmail.com>
 <20180222234833.GA3047@roeck-us.net>
 <CAK8P3a3Y2b-DivYz1ZqhFGUqQaiF=5SDB6RFLtCknwY2--09OQ@mail.gmail.com>
 <20180223154316.35b26857@alans-desktop>
 <20180223171019.GA1125@roeck-us.net>
 <20180223181943.GF30522@ZenIV.linux.org.uk>
Message-ID: <1519414328.30443.29.camel@HansenPartnership.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

On Fri, 2018-02-23 at 18:19 +0000, Al Viro wrote:
[...]
> IIRC, parisc/qemu stuff had been announced a while ago;

I have, but it didn't work sufficiently for me to either boot a kernel
using system emulation or start an architecture container using user
emulation.  I'll try again now that qemu has gone through several
revisions.

>  I hadn't tried that yet (got an old parisc box, so 32bit testing can
> be done on that).

The mailing list (linux-parisc at vger.kernel.org) does regular build
testing on a variety of 32 and 64 bit hardware.

James

