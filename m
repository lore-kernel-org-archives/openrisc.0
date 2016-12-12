From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 12 Dec 2016 09:50:50 -0800
Subject: [OpenRISC] [GIT PULL] Openrisc changes for 4.10 merge
In-Reply-To: <CA+55aFyx2oJy_h-PqKy=+3oSTjpwNzwyZQ4qN4NtcNeRFrDaNw@mail.gmail.com>
References: <20161212143856.GA2650@lianli.shorne-pla.net>
 <CA+55aFyx2oJy_h-PqKy=+3oSTjpwNzwyZQ4qN4NtcNeRFrDaNw@mail.gmail.com>
Message-ID: <20161212175050.GB29734@roeck-us.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Dec 12, 2016 at 09:05:36AM -0800, Linus Torvalds wrote:
> On Mon, Dec 12, 2016 at 6:38 AM, Stafford Horne <shorne@gmail.com> wrote:
> >
> >  - This is my first pull request as the new OpenRISC architecture
> >    maintainer. I hope I have things in order.
> 
> Looks ok, but I note that I don't seem to find an email talking about
> the maintainership change.
> 
> In general, I really prefer seeing hand-off. I guess in this case
> there wasn't all that much hand-off to be done, but I think the last
> few changes came from pulling from Guenter..
> 
Hi Linus,

sorry for not keeping you in the loop. No bad intentions, I just know that
you are busy. I knew about this change, and I had offered to send the pull
request. Stafford wanted to do it himself, so I figured I'd only (need to)
get involved if needed.

I had a look through the changes, ran a diff against mainline, and tested the
resulting code in qemu. I did this both with the previous version and with the
version rebased to v4.9. I even checked that Stafford now has his key signed.
It all looks ok to me. Please consider this a Tested-by: and Reviewed-by:
from me for the entire series.

Now all we have left to do is to ask Stafford not to rebase to the latest
kernel before sending his pull requests...

Thanks,
Guenter

