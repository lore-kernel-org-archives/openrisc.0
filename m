From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Fri, 23 Feb 2018 18:19:44 +0000
Subject: [OpenRISC] Removing architectures without upstream gcc support
In-Reply-To: <20180223171019.GA1125@roeck-us.net>
References: <CAK8P3a2-6YwRR3j7J78fVHSvDpq8Kf4wRj6d9mnGgAxgkYypxg@mail.gmail.com>
 <20180222234833.GA3047@roeck-us.net>
 <CAK8P3a3Y2b-DivYz1ZqhFGUqQaiF=5SDB6RFLtCknwY2--09OQ@mail.gmail.com>
 <20180223154316.35b26857@alans-desktop>
 <20180223171019.GA1125@roeck-us.net>
Message-ID: <20180223181943.GF30522@ZenIV.linux.org.uk>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Feb 23, 2018 at 09:10:19AM -0800, Guenter Roeck wrote:

> FWIW, alpha and m68k are known boot with qemu (even though m68k
> generates a warning traceback with the mainline kernel).

alpha works with qemu (I considered putting together a debian
autobuilder on that, got mired in the scripts; builds AFAICS
happen the same way as on the actual hardware, and considerably
faster than any of the alpha boxen I've got here).  For m68k,
IIRC, qemu is mostly for coldfire and friends with aranym
working for m68k/MMU testing.

IIRC, parisc/qemu stuff had been announced a while ago; I hadn't
tried that yet (got an old parisc box, so 32bit testing can be
done on that).  Itanic... ski(1) is, IME, not usable for kernel
testing and AFAIK no usable ia64/qemu exists.  That's another
one that has to be tested on actual hardware.
