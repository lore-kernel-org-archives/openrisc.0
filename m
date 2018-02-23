From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 23 Feb 2018 09:10:19 -0800
Subject: [OpenRISC] Removing architectures without upstream gcc support
In-Reply-To: <20180223154316.35b26857@alans-desktop>
References: <CAK8P3a2-6YwRR3j7J78fVHSvDpq8Kf4wRj6d9mnGgAxgkYypxg@mail.gmail.com>
 <20180222234833.GA3047@roeck-us.net>
 <CAK8P3a3Y2b-DivYz1ZqhFGUqQaiF=5SDB6RFLtCknwY2--09OQ@mail.gmail.com>
 <20180223154316.35b26857@alans-desktop>
Message-ID: <20180223171019.GA1125@roeck-us.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Feb 23, 2018 at 03:43:16PM +0000, Alan Cox wrote:
> > Regarding the older architectures I mentioned (m32r, frv, mn10300),
> > the situation is a bit different as they don't have the problems with
> > build testing but they do have problems with using less of the
> > standard interfaces (syscall, timer, gpio, rtc, ...), so they do add
> > more to the maintenance burden without the nostalgia value of
> > some of the even older architectures (parisc, alpha, m68k, ia64)
> > that people maintain mainly for fun.
> 
> IMHO the magic word is 'maintain'. If someone is actively maintaining it
> then I don't think we should care too much, if not then while the code
> may be buildable on current systems does anyone honestly think it works
> properly if used in anger ?
> 

FWIW, alpha and m68k are known boot with qemu (even though m68k
generates a warning traceback with the mainline kernel).

Guenter
