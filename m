From: Stafford Horne <shorne@gmail.com>
Date: Sat, 13 Apr 2019 05:56:10 +0900
Subject: [OpenRISC] OpenRISC 1.3 spec
Message-ID: <CAAfxs77GkWenpN0s1pM_YeVgNZabBx55fCqLfxoMffTSa-E=cw@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi All,

As Andrey and I have been working on adding FPU support the GCC port, this
has brought up a few issues and possibly need for new optional
instructions.  Many of these are already documented by Rth back in 2015.

I propose to incorporate the following into the openrisc spec.

Use proposals

P6 https://openrisc.io/proposals/lfmadd - clarification on internal
rounding (possibly exclude new madd instructions)
P7 https://openrisc.io/proposals/lstod-ldtos - convert between double and
float
P9 https://openrisc.io/proposals/ladrp - New instruction for PIC code
(already in binutils)
P14 https://openrisc.io/proposals/orfpx64a32 - 64-bit fpu implemented in
marocchino (gcc/bintuils patches under review)
P11 https://openrisc.io/proposals/lfsf - add support for 'unordered'
compares
P13 https://openrisc.io/proposals/corrections - various corrections
(possibly exclude correction for l.ext* being mandatory as its not
implemented everywhere)

Additionally
Clarification on write back of FPU results after exceptions. As per IEEE
results should be written back.

-Stafford
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20190413/0b3c8240/attachment.html>
