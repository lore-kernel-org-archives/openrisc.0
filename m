From: Philipp Wagner <mail@philipp-wagner.com>
Date: Tue, 3 May 2022 18:38:22 +0200
Subject: [OpenRISC] Add openrisc@lists.librecores.org to lore.kernel.org
In-Reply-To: <CAAfxs75mxjefcTi5ficG0YvDr1THkPGG6aOxX0oor6WWTUngxA@mail.gmail.com>
References: <CAHmME9ooFW5unm1AOWU5738_GHkYqVZ0whEgfKn6RH6k=SCm5g@mail.gmail.com>
 <20220428201950.6emdw5i2fvyktt2i@nitro.local>
 <CAAfxs75mxjefcTi5ficG0YvDr1THkPGG6aOxX0oor6WWTUngxA@mail.gmail.com>
Message-ID: <e9227aed-3450-dfdd-5bc2-4d14027e41b9@philipp-wagner.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

On 29.04.22 05:14, Stafford Horne wrote:
> On Fri, Apr 29, 2022, 5:19 AM Konstantin Ryabitsev 
> <konstantin at linuxfoundation.org <mailto:konstantin@linuxfoundation.org>> 
> wrote:
> 
>     On Thu, Apr 28, 2022 at 01:15:09PM +0200, Jason A. Donenfeld wrote:
>      > Hi folks,
>      >
>      > Any interest in getting this mailing list up on lore.kernel.org
>     <http://lore.kernel.org>? This
>      > would make sense since it's the mailing list specified in the Linux
>      > MAINTAINERS file for OpenRISC development. It'd require the list
>      > administrator to send the current list archives to Konstantin and
>     then
>      > add some archiver as a subscriber. Given this is a fairly normal
>      > mailman list, that doesn't seem too hard.
> 
>     We can add it, but it would be great if the list can be made
>     DKIM-compliant
>     first:
> 
>     1. turn off subject modification, if possible

done (unset the subject_prefix setting)

>     2. remove body modification, if present (mailman list footers, etc)

Done that as well (cleared msg_footer setting).

>     This way any messages sent to this list and to any other lists are
>     properly
>     deduplicated.
> 
> 
> I think it's a good idea, I am not an admin at librecores.  Can you guys 
> help out?

I made the changes above, let me know if that's not sufficient and more 
changes are needed.

(I think you're actually an admin on that list, Stafford :-))

Philipp
