From: Stefan Wallentowitz <stefan@wallentowitz.de>
Date: Thu, 25 Aug 2016 09:13:49 +0200
Subject: [OpenRISC] Installing gcc commpiler on openrisc linux
In-Reply-To: <CAAfxs75ioYwn81RX_raF0rWW0Pwu00V6kj4B_RKqYAFWpjbd6g@mail.gmail.com>
References: <CAFoY_wzJ43q=97rSJu2jMnOnOj4QvzR7GkF+LPAyOrfsVdWPsQ@mail.gmail.com>
 <CAAfxs75ioYwn81RX_raF0rWW0Pwu00V6kj4B_RKqYAFWpjbd6g@mail.gmail.com>
Message-ID: <ab2639ae-6747-ce88-edc3-559700c4b45c@wallentowitz.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 25.08.2016 01:44, Stafford Horne wrote:
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
> 
> -Stafford

Hi Manaar,

just to add to this and Jeremy's comment: It is not the standard way to
compile inside the target system. Instead you cross-compile on your host
and transfer the binary ELF to the target.

I am not sure if the tutorial already covers adding files to the ramdisk
(the image you load onto the target). Stafford, you are the expert on
this, right?

Cheers,
Stefan


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: OpenPGP digital signature
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20160825/e9322d03/attachment.sig>
