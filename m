From: Jeremy Bennett <jeremy.bennett@embecosm.com>
Date: Thu, 25 Aug 2016 17:23:55 +0200
Subject: [OpenRISC] newlib, malloc missing, I must be missing something
In-Reply-To: <1472133706.4263.2727.camel@jericho>
References: <1472133706.4263.2727.camel@jericho>
Message-ID: <0707be5b-9b4f-9dc8-b981-204fcc7ab330@embecosm.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 25/08/16 16:01, Dan wrote:
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
> 0000000000000000
> dhry.o: In function `Func_2':
> dhry.c:(.text+0x444): undefined reference to `strcmp'
> dhry.o: In function `main':
> dhry.c:(.text.startup+0x34): undefined reference to `malloc'
> dhry.c:(.text.startup+0x48): undefined reference to `malloc'
> dhry.c:(.text.startup+0x1e8): undefined reference to `strcmp'
> dhry.c:(.text.startup+0x390): undefined reference to `exit'
> 
> However, if I just do the linking with GCC alone, I get:
> 
> % or1k-elf-gcc dhry.o -o dhry
> % (No errors)
> 
> Any thoughts?

Hi Dan,

The C compiler is a driver for the linker, putting in all the libraries
you need.  You should always link C code using gcc, not ld.

To see the link line used try gcc -v.  It will show you all the
sub-commands used.


Jeremy

> 
> Thanks!
> 
> Dan
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
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20160825/d355cc76/attachment.sig>
