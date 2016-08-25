From: Jeremy Bennett <jeremy.bennett@embecosm.com>
Date: Thu, 25 Aug 2016 09:03:35 +0200
Subject: [OpenRISC] Installing gcc commpiler on openrisc linux
In-Reply-To: <CAAfxs75ioYwn81RX_raF0rWW0Pwu00V6kj4B_RKqYAFWpjbd6g@mail.gmail.com>
References: <CAFoY_wzJ43q=97rSJu2jMnOnOj4QvzR7GkF+LPAyOrfsVdWPsQ@mail.gmail.com>
 <CAAfxs75ioYwn81RX_raF0rWW0Pwu00V6kj4B_RKqYAFWpjbd6g@mail.gmail.com>
Message-ID: <c457cd43-6d35-0acf-d8df-6317bb2e8fa0@embecosm.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 25/08/16 01:44, Stafford Horne wrote:
> Hello Manaar,
> 
> The openrisc Linux build creates an image with all the tools provided
> using busybox (it's in the kernel source tree). So it's basically a
> busybox embedded system.  You can Google about adding gcc or another c
> compiler to busybox for details.
> 
> I don't think it's been done before. Gcc is rather large for de0 nano
> ;it's not just gcc but linkers and assemblers and libraries you would
> want to link in. However, I wouldnt bet it's impossible if you strip it
> down.

Hi Manaar,

I think you'll struggle to get GCC to work on the DE0-Nano, and even if
you could it would be dreadfully slow.  Getting modern GCC to work on
anything with less than 1GB is pretty hard.  The usual way of running
the OpenRISC tool chain is as a cross-compiler on a PC.

HTH,


Jeremy

> 
> -Stafford
> 
> 
> On 25 Aug 2016 8:03 a.m., "Manaar Alam" <alam.manaar@gmail.com
> <mailto:alam.manaar@gmail.com>> wrote:
> 
>     Hello,
> 
>     I have managed to boot Linux on de0-nano board with openrisc. But
>     the problem is, this linux image doesn't have any C Compiler in it.
>     How to install C compiler on the linux?
> 
>     -- 
>     *Manaar Alam,*
>     Junior Research Fellow,
>     Department of Computer Science and Engineering,
>     Indian Institute of Technology, Kharagpur,
>     West Bengal, India.
> 
>     _______________________________________________
>     OpenRISC mailing list
>     OpenRISC at lists.librecores.org <mailto:OpenRISC@lists.librecores.org>
>     https://lists.librecores.org/listinfo/openrisc
>     <https://lists.librecores.org/listinfo/openrisc>
> 
> 
> 
> _______________________________________________
> OpenRISC mailing list
> OpenRISC at lists.librecores.org
> https://lists.librecores.org/listinfo/openrisc
> 


-- 
Tel:     +44 (1590) 610184
Cell:    +44 (7970) 676050
SkypeID: jeremybennett
Twitter: @jeremypbennett
Email:   jeremy.bennett at embecosm.com
Web:     www.embecosm.com
PGP key: 1024D/BEF58172FB4754E1 2009-03-20

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: OpenPGP digital signature
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20160825/2fccc6bc/attachment.sig>
