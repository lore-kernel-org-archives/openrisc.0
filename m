From: Dan <dgisselq@verizon.net>
Date: Thu, 25 Aug 2016 10:01:46 -0400
Subject: [OpenRISC] newlib, malloc missing, I must be missing something
Message-ID: <1472133706.4263.2727.camel@jericho>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hello!

I just built the or1k tool suite according to the directions on
openrisk.io/newlib/building.html.  However, when trying to build my
first file, I'm getting:


% or1k-elf-gcc -O3 -o dhry.o -c dhry.c
% or1k-elf-ld -o dhry dhry.o
% or1k-elf-ld: warning: cannot find entry symbol _start; defaulting to
0000000000000000
dhry.o: In function `Func_2':
dhry.c:(.text+0x444): undefined reference to `strcmp'
dhry.o: In function `main':
dhry.c:(.text.startup+0x34): undefined reference to `malloc'
dhry.c:(.text.startup+0x48): undefined reference to `malloc'
dhry.c:(.text.startup+0x1e8): undefined reference to `strcmp'
dhry.c:(.text.startup+0x390): undefined reference to `exit'

However, if I just do the linking with GCC alone, I get:

% or1k-elf-gcc dhry.o -o dhry
% (No errors)

Any thoughts?

Thanks!

Dan
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20160825/68ef21c5/attachment.html>
