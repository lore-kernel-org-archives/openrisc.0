From: Arnd Bergmann <arnd@kernel.org>
Date: Fri, 18 Feb 2022 08:23:29 +0100
Subject: [OpenRISC] [PATCH v2 13/18] uaccess: generalize access_ok()
In-Reply-To: <20220218063450.GI22576@lst.de>
References: <20220216131332.1489939-1-arnd@kernel.org>
 <20220216131332.1489939-14-arnd@kernel.org>
 <20220218063450.GI22576@lst.de>
Message-ID: <CAK8P3a17kdz0gKYz3cDSpvWa80TY6QNSom11HVAb8h91RZn0Jg@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Feb 18, 2022 at 7:34 AM Christoph Hellwig <hch@lst.de> wrote:
>
> > +#include <asm-generic/access_ok.h>
>
> Instead of the asm-generic games, shouldn't we just define access_ok in
> <linux/uaccess.h> if not already defined by the architecture?

I tried, but couldn't actually make it work because asm/uaccess.h tends
to contain inline functions that rely on access_ok(). It could work once we
move all the high-level functions into linux/uaccess.h, but that would likely
require another long patch series.

One option that can work is to require architectures to have an
asm/access_ok.h header that gets included by linux/uaccess.h.
On most architectures, that would be redirected to
asm-generic/access_ok.h, as only ia64, x86, arm64 and um
need to override the definition.

      Arnd
