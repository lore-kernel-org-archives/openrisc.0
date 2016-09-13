From: esmaeel ensanimehr <eensanimehr@gmail.com>
Date: Tue, 13 Sep 2016 10:14:26 +0430
Subject: [OpenRISC] OR1200-generic-question
Message-ID: <CALtEHQZcLoVy=nbZe_1P4YW8AjFt6yTo=geYHKo9zwwM0vKdrg@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Dear Sir

I want to use custom instruction in OR1200-generic with inline
assembly in a simple C code.

(may possible to use general  defined instruction buts i want to
implement it for future work on OR Project).

___add___  work  for me

 int x=2,y=3,sum=0;
__asm__("l.add %0,%1,%2" : "=r" (sum) : "r" (x), "r" (y));

///sum : 5

-----------------------
i try to implement a new shift command. shift  b to left by  c
position and store to a

int a,b,c;//
__asm__("l.cust5 %0%1%2":"=r" (a):"r" (b):"r" (c)); /// a <=  b << c ;

but this argument list cause error

///  __asm__("l.cust5");   run correct .

i find that   verilog  code for shift must be add in or1200_alu.v in final
part.

but how to inform to compiler new  added list of argument for cust5.

i find or1k-opc.c and or32-opc.c , damage these file to see how effect
on compile side (or1k-elf) and sim with fusesoc  but no effect .

please inform me how to do it.

your sincerly

Esmaeel EnsaniMehr
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20160913/a9ab00c8/attachment.html>
