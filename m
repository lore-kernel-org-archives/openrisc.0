From: Stafford Horne <shorne@gmail.com>
Date: Thu, 25 Aug 2016 08:44:13 +0900
Subject: [OpenRISC] Installing gcc commpiler on openrisc linux
In-Reply-To: <CAFoY_wzJ43q=97rSJu2jMnOnOj4QvzR7GkF+LPAyOrfsVdWPsQ@mail.gmail.com>
References: <CAFoY_wzJ43q=97rSJu2jMnOnOj4QvzR7GkF+LPAyOrfsVdWPsQ@mail.gmail.com>
Message-ID: <CAAfxs75ioYwn81RX_raF0rWW0Pwu00V6kj4B_RKqYAFWpjbd6g@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello Manaar,

The openrisc Linux build creates an image with all the tools provided using
busybox (it's in the kernel source tree). So it's basically a busybox
embedded system.  You can Google about adding gcc or another c compiler to
busybox for details.

I don't think it's been done before. Gcc is rather large for de0 nano ;it's
not just gcc but linkers and assemblers and libraries you would want to
link in. However, I wouldnt bet it's impossible if you strip it down.

-Stafford

On 25 Aug 2016 8:03 a.m., "Manaar Alam" <alam.manaar@gmail.com> wrote:

> Hello,
>
> I have managed to boot Linux on de0-nano board with openrisc. But the
> problem is, this linux image doesn't have any C Compiler in it. How to
> install C compiler on the linux?
>
> --
> *Manaar Alam,*
> Junior Research Fellow,
> Department of Computer Science and Engineering,
> Indian Institute of Technology, Kharagpur,
> West Bengal, India.
>
> _______________________________________________
> OpenRISC mailing list
> OpenRISC at lists.librecores.org
> https://lists.librecores.org/listinfo/openrisc
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20160825/1db571ea/attachment.html>
