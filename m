From: Pavel Machek <pavel@ucw.cz>
Date: Sun, 25 Feb 2018 23:50:02 +0100
Subject: [OpenRISC] Removing architectures without upstream gcc support
In-Reply-To: <20180225202806.735a6870@alans-desktop>
References: <CAK8P3a2-6YwRR3j7J78fVHSvDpq8Kf4wRj6d9mnGgAxgkYypxg@mail.gmail.com>
 <20180222234833.GA3047@roeck-us.net>
 <CAK8P3a3Y2b-DivYz1ZqhFGUqQaiF=5SDB6RFLtCknwY2--09OQ@mail.gmail.com>
 <20180223154316.35b26857@alans-desktop>
 <20180223171019.GA1125@roeck-us.net>
 <20180225202806.735a6870@alans-desktop>
Message-ID: <20180225225002.GA6078@amd>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi!

On Sun 2018-02-25 20:28:06, Alan Cox wrote:
> > FWIW, alpha and m68k are known boot with qemu (even though m68k
> > generates a warning traceback with the mainline kernel).
> 
> M68K works - people actively use it. Crazy people true 8). Alpha I
> believe one or two people boot. I just need to track down some discs for
> my Alpha 8)

I guess it would be useful to track who tested what kernel on what
hardware ... and I created a project for
that. Feel free to contribute: https://github.com/pavelmachek/missy --
I'd like to get some data from "big" iron...

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20180225/cd29939c/attachment.sig>
