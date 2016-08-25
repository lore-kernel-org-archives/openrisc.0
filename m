From: Stefan Wallentowitz <stefan@wallentowitz.de>
Date: Thu, 25 Aug 2016 16:39:39 +0200
Subject: [OpenRISC] newlib, malloc missing, I must be missing something
In-Reply-To: <1472133706.4263.2727.camel@jericho>
References: <1472133706.4263.2727.camel@jericho>
Message-ID: <44f4aaf0-2697-1738-5d8f-b8daa2bb030c@wallentowitz.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 25.08.2016 16:01, Dan wrote:
> Hello!
> 
> I just built the or1k tool suite according to the directions on
> openrisk.io/newlib/building.html.  However, when trying to build my
> first file, I'm getting:
> 
> 
> % or1k-elf-gcc -O3 -o dhry.o -c dhry.c
> % or1k-elf-ld -o dhry dhry.o
> % or1k-elf-ld: warning: cannot find entry symbol _start; defaulting to

Hi,

can you try:

or1k-elf-gcc -o dhry dhry.o

Cheers,
Stefan


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: OpenPGP digital signature
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20160825/4f9a9f23/attachment.sig>
