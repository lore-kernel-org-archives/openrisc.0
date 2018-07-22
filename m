From: Stafford Horne <shorne@gmail.com>
Date: Mon, 23 Jul 2018 08:57:21 +0900
Subject: [OpenRISC] GCC testing and dynamic linker
In-Reply-To: <4B4D66F3-A47B-4666-B9B1-8B988422DBA1@twiddle.net>
References: <20180711144943.GA9742@lianli.shorne-pla.net>
 <4B4D66F3-A47B-4666-B9B1-8B988422DBA1@twiddle.net>
Message-ID: <CAAfxs777aT+2-_JOPFYpG8ydGcXiS5n1onkVW-tj0Ze7AvKDvg@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Thanks,

I made this change and fixed a bug with the linker spec which was making
c++ exceptions fail on newlib.

Also I got my CI to run and report dejagnu test.  New binaries and results
are available here

https://github.com/stffrdhrn/gcc/releases/tag/or1k-9.0.0-20180722

I will look into fixing some remaining bugs now.  But i think we might as
well also post the patches to gcc and binutils.

Stafford

On Thu, Jul 12, 2018, 12:28 AM Richard Henderson <rth@twiddle.net> wrote:

> Please do. I think that's a remenent of a misconfigured linker, once upon
> a midnight weary, and accidentally carried over to the new port.
>
>
> r~
>
>
> >I have a question, I noticed in `gcc\config\or1k\linux.h` you have put:
> >
> >  #define MUSL_DYNAMIC_LINKER  "/lib/ld.so.1"
> >
> >It seems musl produces the file as `ld-musl-or1k.so.1`.  Do you mind if
> >I change
> >it?
> >
> >-Stafford
>
> --
> Sent from my Android device with K-9 Mail. Please excuse my brevity.
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20180723/4812be59/attachment.html>
