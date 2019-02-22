From: Olof Kindgren <olof.kindgren@gmail.com>
Date: Fri, 22 Feb 2019 09:05:04 +0100
Subject: [OpenRISC] openRISC question
In-Reply-To: <1a75cc63-9b02-0253-b491-9657a7a0c16a@polimi.it>
References: <1a75cc63-9b02-0253-b491-9657a7a0c16a@polimi.it>
Message-ID: <CAKaYPCNFB97RYYBnvi0Fh36yhiCLOrt8bq8GN+U=RyKULAb8Cw@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Feb 22, 2019 at 8:58 AM Luca Maria Cassano <luca.cassano@polimi.it>
wrote:

> Hi all,
>
> I am Luca Cassano, an assistant professor at Politecnico di Milano, Italy.
>
>
> Mattia (which one of my students) and I are trying to install and use the
> openRISC environment. We are running everything on a Linux virtual machine.
>
> When compiling with *or1k-elf-gcc *we get this error:
>
> $:~/Desktop$ /opt/toolchains/or1k-elf/bin/or1k-elf-gcc -o prova.elf
> hello.c
> /tmp/cciAQA5z.s: Assembler messages:
> /tmp/cciAQA5z.s:7: Error: no such instruction: `l.addi r1,r1,-8'
> /tmp/cciAQA5z.s:8: Error: no such instruction: `l.sw 0(r1),r2'
> /tmp/cciAQA5z.s:9: Error: no such instruction: `l.addi r2,r1,8'
> /tmp/cciAQA5z.s:10: Error: no such instruction: `l.sw 4(r1),r9'
> /tmp/cciAQA5z.s:11: Error: no such instruction: `l.nop'
> /tmp/cciAQA5z.s:12: Error: no such instruction: `l.lwz r2,0(r1)'
> /tmp/cciAQA5z.s:13: Error: no such instruction: `l.lwz r9,4(r1)'
> /tmp/cciAQA5z.s:14: Error: no such instruction: `l.addi r1,r1,8'
> /tmp/cciAQA5z.s:15: Error: no such instruction: `l.jr r9'
> /tmp/cciAQA5z.s:16: Error: no such instruction: `l.nop'
>
>
> Does anybody encountered (and hopefully solved) such a problem?
>
>
> Hi Luca and Mattia,

It's hard to tell right away what the problem could be. Just looking at the
errors I would first suspect there is something wrong with the toolchain.
Which instructions did you follow to install the toolchain? The easiest way
could be to just use one of the precompiled ones (as the one found here
https://github.com/openrisc/or1k-gcc/releases/tag/or1k-7.2.0-20180317) if
you don't do that already.

//Olof


Best regards,
>
> Luca and Mattia
>
>
> --
> Luca Cassano, PhD
> Assistant Professor
> web:   cassano.faculty.polimi.it
> email: luca.cassano at polimi.it
> tel:   02-23994174
> Department of Electronics, Information and Bioingeneering
> (room 129, Building 20, via Ponzio 35/5)
> Politecnico di Milano
> Italy
>
> _______________________________________________
> OpenRISC mailing list
> OpenRISC at lists.librecores.org
> https://lists.librecores.org/listinfo/openrisc
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20190222/af840a92/attachment-0001.html>
