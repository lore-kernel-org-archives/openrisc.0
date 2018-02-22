From: James Hogan <jhogan@kernel.org>
Date: Thu, 22 Feb 2018 16:28:46 +0000
Subject: [OpenRISC] Removing architectures without upstream gcc support
In-Reply-To: <CAK8P3a2-6YwRR3j7J78fVHSvDpq8Kf4wRj6d9mnGgAxgkYypxg@mail.gmail.com>
References: <CAK8P3a2-6YwRR3j7J78fVHSvDpq8Kf4wRj6d9mnGgAxgkYypxg@mail.gmail.com>
Message-ID: <20180222162845.GC9891@saruman>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Arnd,

On Thu, Feb 22, 2018 at 04:45:06PM +0100, Arnd Bergmann wrote:
> * Meta was ImgTec's own architecture and they upstreamed the kernel
>   port just before they acquired MIPS. Apparently Meta was abandoned
>   shortly afterwards and disappeared from imgtec's website in 2014.
>   The maintainer is still fixing bugs in the port, but I could not find
>   any toolchain more recent than
>   https://github.com/img-meta/metag-buildroot/tree/metag-core/toolchain/gcc/4.2.4
>   Not sure about this one, I'd be interested in more background
>   from James Hogan, who probably has an opinion and might have
>   newer toolchain sources.

Interesting timing! Have you seen this (which I'll send for 4.17, and
leave 4.16 broken)?

https://marc.info/?l=linux-kernel&m=151925667323732&w=2

The Meta port is essentially unused and for a while I have only looked
at it when something went wrong. PURE's Linux based digital radios I
believe were never updated to 3.10. The fact that the GCC port wasn't
upstreamed before the MIPS acquisition meant it was always a ticking
time bomb (though binutils was upstreamed).

Sad really, given that at least 9 years of effort went into the port
before permission was finally given to upstream it, and within a week or
so of the first patchset the intention to acquire MIPS was announced.

FWIW, my experience was that upstreaming the port caught a whole lot of
issues (Al Viro's review of signal handling alone was tremendously
valuable), and drastically reduced the effort required to forward port
to each new kernel version. Updating an out of tree arch tends to result
in a lot of runtime failures that require digging, which reduced
drastically once the port was upstreamed.

Cheers
James
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: Digital signature
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20180222/514d156f/attachment-0001.sig>
