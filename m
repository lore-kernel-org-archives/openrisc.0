From: Jeremy Bennett <jeremy.bennett@embecosm.com>
Date: Thu, 25 Aug 2016 10:15:17 +0200
Subject: [OpenRISC] Installing gcc commpiler on openrisc linux
In-Reply-To: <CAAfxs74gbczfR4bkQpJPKytK-747qoU+d3vSmpxnQqpW3-_ofA@mail.gmail.com>
References: <CAFoY_wzJ43q=97rSJu2jMnOnOj4QvzR7GkF+LPAyOrfsVdWPsQ@mail.gmail.com>
 <CAAfxs75ioYwn81RX_raF0rWW0Pwu00V6kj4B_RKqYAFWpjbd6g@mail.gmail.com>
 <CAFoY_ww=jonkgne6xTis6EvGLJFGTnw_O=HEhCbNZnvQFutO8A@mail.gmail.com>
 <CAAfxs77h1CeyF2awfWOrKDdGmVW2aGinJPAF_CatfMF4KdWKLg@mail.gmail.com>
 <CAAfxs74gbczfR4bkQpJPKytK-747qoU+d3vSmpxnQqpW3-_ofA@mail.gmail.com>
Message-ID: <bf51bb8b-afe7-5f63-d5bd-2255378df0d3@embecosm.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi

IIRC we used FTP and telnet when running GCC regression tests.  You
probably need to add this to the BusyBox build.

You should also be able to get ssh/scp working, although I've never done
it.  BusyBox also supports NFS, although when I last looked (some years
ago) it was only NFS 3, not NFS 4, which can cause difficulty, because
they don't co-exist happily.

HTH,


Jeremy

On 25/08/16 09:19, Stafford Horne wrote:
> +cc Mailing list.
> 
> 
> On 25 Aug 2016 3:50 p.m., "Stafford Horne" <shorne@gmail.com
> <mailto:shorne@gmail.com>> wrote:
> 
>     Hello,
> 
>     There are two ways.
> 
>     1.
>     When building the Linux kernel you can place any files you want
>     under /arch
>     <https://github.com/openrisc/linux/tree/master/arch>/openrisc
>     <https://github.com/openrisc/linux/tree/master/arch/openrisc>/support <https://github.com/openrisc/linux/tree/master/arch/openrisc/support>/*initramfs*
>     and they will be there when you buy the system.
> 
>     2.
>     When you connect to your serial terminal there are ways to transfer
>     through the serial connection. You can maybe get builds of zmodem
>     working there.
> 
>     -Stafford
> 
> 
>     On 25 Aug 2016 2:47 p.m., "Manaar Alam" <alam.manaar@gmail.com
>     <mailto:alam.manaar@gmail.com>> wrote:
> 
>         Hello Sir,
> 
>         Can I transfer any executable file from my Ubuntu system to the
>         Linux on de0_nano?
>         If that is possible then gcc won't be required.
>         Any suggestion from you will be very helpful for me.
> 
>         Thanks and regards,
> 
>         On Thu, Aug 25, 2016 at 5:14 AM, Stafford Horne
>         <shorne at gmail.com <mailto:shorne@gmail.com>> wrote:
> 
>             Hello Manaar,
> 
>             The openrisc Linux build creates an image with all the tools
>             provided using busybox (it's in the kernel source tree). So
>             it's basically a busybox embedded system.  You can Google
>             about adding gcc or another c compiler to busybox for details.
> 
>             I don't think it's been done before. Gcc is rather large for
>             de0 nano ;it's not just gcc but linkers and assemblers and
>             libraries you would want to link in. However, I wouldnt bet
>             it's impossible if you strip it down.
> 
>             -Stafford
> 
> 
>             On 25 Aug 2016 8:03 a.m., "Manaar Alam"
>             <alam.manaar at gmail.com <mailto:alam.manaar@gmail.com>> wrote:
> 
>                 Hello,
> 
>                 I have managed to boot Linux on de0-nano board with
>                 openrisc. But the problem is, this linux image doesn't
>                 have any C Compiler in it. How to install C compiler on
>                 the linux?
> 
>                 -- 
>                 *Manaar Alam,*
>                 Junior Research Fellow,
>                 Department of Computer Science and Engineering,
>                 Indian Institute of Technology, Kharagpur,
>                 West Bengal, India.
> 
>                 _______________________________________________
>                 OpenRISC mailing list
>                 OpenRISC at lists.librecores.org
>                 <mailto:OpenRISC@lists.librecores.org>
>                 https://lists.librecores.org/listinfo/openrisc
>                 <https://lists.librecores.org/listinfo/openrisc>
> 
> 
> 
> 
>         -- 
>         *Manaar Alam,*
>         Junior Research Fellow,
>         Department of Computer Science and Engineering,
>         Indian Institute of Technology, Kharagpur,
>         West Bengal, India.
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
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20160825/4bb68049/attachment.sig>
