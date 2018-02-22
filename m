From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 22 Feb 2018 17:19:04 +0100
Subject: [OpenRISC] Removing architectures without upstream gcc support
In-Reply-To: <20180222160217.GA18243@infradead.org>
References: <CAK8P3a2-6YwRR3j7J78fVHSvDpq8Kf4wRj6d9mnGgAxgkYypxg@mail.gmail.com>
 <20180222160217.GA18243@infradead.org>
Message-ID: <CAK8P3a1ZMQTPq1Szvgdg3yzpr+LdsoDaO6YtzNUycYcbOzDPSQ@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Feb 22, 2018 at 5:02 PM, Christoph Hellwig <hch@infradead.org> wrote:
> On Thu, Feb 22, 2018 at 04:45:06PM +0100, Arnd Bergmann wrote:
>> There are also a couple of architectures that are more or less
>> unmaintained but do have working gcc support: FR-V and M32R
>> have been orphaned for a while and are not getting updated
>> MN10300 is still maintained officially by David Howells but doesn't
>> seem any more active than the other two, the last real updates were
>> in 2013.
>
> I'd love to see dead architecture ports dropped if they really are
> more or less abandoned.  In addition to your missing gcc port ones
> above (minus openrisc) it seems like frv and m32r certainly qualify,
> and xtensa seems to be going that way with the glibc port being dropped
> now.

Regarding xtensa, I looked at that one while I wrote my list and it seems
quite a bit more active than the others. Cris and xtensa are two architectures
that don't see much maintenance over long periods of time but occasionally
get a proper update. For xtensa this just happened, see [1]. Unlike cris,
xtensa is also commercially still very successful, just less so in the
Linux+glibc space.

       Arnd

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d0bd31dc5c0b46b9c778112900cf8f910ac26e1b
