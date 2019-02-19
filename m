From: Luca Maria Cassano <luca.cassano@polimi.it>
Date: Tue, 19 Feb 2019 10:04:28 +0000
Subject: [OpenRISC] openRISC question
Message-ID: <1a75cc63-9b02-0253-b491-9657a7a0c16a@polimi.it>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi all,

I am Luca Cassano, an assistant professor at Politecnico di Milano, Italy.


Mattia (which one of my students) and I are trying to install and use the openRISC environment. We are running everything on a Linux virtual machine.

When compiling with or1k-elf-gcc we get this error:

$:~/Desktop$ /opt/toolchains/or1k-elf/bin/or1k-elf-gcc -o prova.elf hello.c
/tmp/cciAQA5z.s: Assembler messages:
/tmp/cciAQA5z.s:7: Error: no such instruction: `l.addi r1,r1,-8'
/tmp/cciAQA5z.s:8: Error: no such instruction: `l.sw 0(r1),r2'
/tmp/cciAQA5z.s:9: Error: no such instruction: `l.addi r2,r1,8'
/tmp/cciAQA5z.s:10: Error: no such instruction: `l.sw 4(r1),r9'
/tmp/cciAQA5z.s:11: Error: no such instruction: `l.nop'
/tmp/cciAQA5z.s:12: Error: no such instruction: `l.lwz r2,0(r1)'
/tmp/cciAQA5z.s:13: Error: no such instruction: `l.lwz r9,4(r1)'
/tmp/cciAQA5z.s:14: Error: no such instruction: `l.addi r1,r1,8'
/tmp/cciAQA5z.s:15: Error: no such instruction: `l.jr r9'
/tmp/cciAQA5z.s:16: Error: no such instruction: `l.nop'


Does anybody encountered (and hopefully solved) such a problem?


Best regards,

Luca and Mattia


--
Luca Cassano, PhD
Assistant Professor
web:   cassano.faculty.polimi.it
email: luca.cassano at polimi.it<mailto:luca.cassano@polimi.it>
tel:   02-23994174
Department of Electronics, Information and Bioingeneering
(room 129, Building 20, via Ponzio 35/5)
Politecnico di Milano
Italy
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20190219/6dff36a6/attachment-0001.html>
