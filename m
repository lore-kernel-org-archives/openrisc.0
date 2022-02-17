From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 17 Feb 2022 09:13:43 +0100
Subject: [OpenRISC] [PATCH v2 00/18] clean up asm/uaccess.h,
 kill set_fs for good
In-Reply-To: <20220216131332.1489939-1-arnd@kernel.org>
References: <20220216131332.1489939-1-arnd@kernel.org>
Message-ID: <CAK8P3a3QBWDYjr6VpPdjTBGFg88DdH3SHVgxEowgScgJOkNguQ@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Feb 16, 2022 at 2:13 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Christoph Hellwig and a few others spent a huge effort on removing
> set_fs() from most of the important architectures, but about half the
> other architectures were never completed even though most of them don't
> actually use set_fs() at all.
>
> I did a patch for microblaze at some point, which turned out to be fairly
> generic, and now ported it to most other architectures, using new generic
> implementations of access_ok() and __{get,put}_kernel_nocheck().
>
> Three architectures (sparc64, ia64, and sh) needed some extra work,
> which I also completed.
>
> The final series contains extra cleanup changes that touch all
> architectures. Please review and test these, so we can merge them
> for v5.18.
>
> The series is available at
> https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/log/?h=set_fs-2
> for testing.

I've added the updated contents to my asm-generic tree now to put them
into linux-next.

         Arnd
