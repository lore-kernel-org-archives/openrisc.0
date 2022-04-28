From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Date: Thu, 28 Apr 2022 16:19:50 -0400
Subject: [OpenRISC] Add openrisc@lists.librecores.org to lore.kernel.org
In-Reply-To: <CAHmME9ooFW5unm1AOWU5738_GHkYqVZ0whEgfKn6RH6k=SCm5g@mail.gmail.com>
References: <CAHmME9ooFW5unm1AOWU5738_GHkYqVZ0whEgfKn6RH6k=SCm5g@mail.gmail.com>
Message-ID: <20220428201950.6emdw5i2fvyktt2i@nitro.local>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Apr 28, 2022 at 01:15:09PM +0200, Jason A. Donenfeld wrote:
> Hi folks,
> 
> Any interest in getting this mailing list up on lore.kernel.org? This
> would make sense since it's the mailing list specified in the Linux
> MAINTAINERS file for OpenRISC development. It'd require the list
> administrator to send the current list archives to Konstantin and then
> add some archiver as a subscriber. Given this is a fairly normal
> mailman list, that doesn't seem too hard.

We can add it, but it would be great if the list can be made DKIM-compliant
first:

1. turn off subject modification, if possible
2. remove body modification, if present (mailman list footers, etc)

This way any messages sent to this list and to any other lists are properly
deduplicated.

-K
