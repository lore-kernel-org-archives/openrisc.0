From: Stafford Horne <shorne@gmail.com>
Date: Tue, 13 Dec 2016 06:56:44 +0900
Subject: [OpenRISC] [GIT PULL] Openrisc changes for 4.10 merge
In-Reply-To: <20161212175050.GB29734@roeck-us.net>
References: <20161212143856.GA2650@lianli.shorne-pla.net>
 <CA+55aFyx2oJy_h-PqKy=+3oSTjpwNzwyZQ4qN4NtcNeRFrDaNw@mail.gmail.com>
 <20161212175050.GB29734@roeck-us.net>
Message-ID: <20161212215644.GB2650@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Dec 12, 2016 at 09:50:50AM -0800, Guenter Roeck wrote:
> On Mon, Dec 12, 2016 at 09:05:36AM -0800, Linus Torvalds wrote:
> > On Mon, Dec 12, 2016 at 6:38 AM, Stafford Horne <shorne@gmail.com> wrote:
> > >
> > >  - This is my first pull request as the new OpenRISC architecture
> > >    maintainer. I hope I have things in order.
> > 
> > Looks ok, but I note that I don't seem to find an email talking about
> > the maintainership change.
> > 
> > In general, I really prefer seeing hand-off. I guess in this case
> > there wasn't all that much hand-off to be done, but I think the last
> > few changes came from pulling from Guenter..
> > 
> Hi Linus,
> 
> sorry for not keeping you in the loop. No bad intentions, I just know that
> you are busy. I knew about this change, and I had offered to send the pull
> request. Stafford wanted to do it himself, so I figured I'd only (need to)
> get involved if needed.
> 
> I had a look through the changes, ran a diff against mainline, and tested the
> resulting code in qemu. I did this both with the previous version and with the
> version rebased to v4.9. I even checked that Stafford now has his key signed.
> It all looks ok to me. Please consider this a Tested-by: and Reviewed-by:
> from me for the entire series.
> 
> Now all we have left to do is to ask Stafford not to rebase to the latest
> kernel before sending his pull requests...

Thanks Guenter, 

I see Linus did do the merge already, but just for completion here is a
bit more about the maintainer handoff. I sent this in some of my earlier
pull requests, I should have included it to Linus.

Mail threads from Jonas (previous maintainer)
https://lkml.org/lkml/2015/5/13/469 - mail from Jonas mentioning
                                      he is no longer able to maintain
https://lkml.org/lkml/2015/6/11/426 - mail from Jonas mentioning stefan
                                      is to be the new maintainer

Ideally Stefan Kristiansson would have become the maintainer but he
does not seem to have much time recently.  I am in talks with Stefan
regularly via the #openrisc freenode irc room.  Also, Stefan and I have
met last summer and did a pgp key signing.

Either way, all is set now.  I'll be working on the next batch of
patches now.

Thank you,

-Stafford


