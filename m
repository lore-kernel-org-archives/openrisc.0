From: jallouli kais <jalloulikais@yahoo.fr>
Date: Sat, 5 Aug 2017 22:32:28 +0000 (UTC)
Subject: [OpenRISC] OpenRISC Digest, Vol 17, Issue 6
In-Reply-To: <mailman.1.1500544801.22613.openrisc@lists.librecores.org>
References: <mailman.1.1500544801.22613.openrisc@lists.librecores.org>
Message-ID: <813040048.534845.1501972348482@mail.yahoo.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

Hi,I have a question,I need your help.I am grateful.
for the installation of the toolchain ,I am using ubuntu 16.04 
Please what is the version of toolchain  I should install 

or1k-elf ? or1k-linux-musl ?  or1k-linux-uclibc ?
 

    Le Jeudi 20 juillet 2017 11h00, "openrisc-request at lists.librecores.org" <openrisc-request@lists.librecores.org> a écrit :
 

 Send OpenRISC mailing list submissions to
    openrisc at lists.librecores.org

To subscribe or unsubscribe via the World Wide Web, visit
    https://lists.librecores.org/listinfo/openrisc
or, via email, send a message with subject or body 'help' to
    openrisc-request at lists.librecores.org

You can reach the person managing the list at
    openrisc-owner at lists.librecores.org

When replying, please edit your Subject line so it is more specific
than "Re: Contents of OpenRISC digest..."


Today's Topics:

  1. Re: OpenRISC Digest, Vol 17, Issue 4 (Philipp Wagner)


----------------------------------------------------------------------

Message: 1
Date: Wed, 19 Jul 2017 13:39:46 +0200
From: Philipp Wagner <lists@philipp-wagner.com>
To: "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>
Subject: Re: [OpenRISC] OpenRISC Digest, Vol 17, Issue 4
Message-ID: <55ecb1f9-6697-791a-ac37-d45265834703@philipp-wagner.com>
Content-Type: text/plain; charset=utf-8; format=flowed

On 07/19/2017 12:49 PM, jallouli kais wrote:
> https://openrisc.io/software
> 
> For building a  software, OpenRISC is supported by a 32-bit GNU 
> toolchain offering C and C++ support. The toolchain is available in 
> several forms, depending on your use case.
> 
>  *
>    or1k-elf <https://openrisc.io/software#mewlib-toolchain> for bare
>    metal use, based on the newlib library.
>  *
>    or1k-linux-uclibc <https://openrisc.io/software#uclibc-ng-toolchain>
>    for Linux <https://openrisc.io/software#linux> application use,
>    based on the uClibc-ng library.
>  *
>    or1k-linux-musl <https://openrisc.io/software#musl-toolchain> also
>    for Linux <https://openrisc.io/software#linux> application use,
>    based on the musl library. (recommended over uClibc)
>  *
>    or1k-rtems <https://openrisc.io/software#rtems-toolchain> for
>    building software that runs on the RTEMS
>    <https://openrisc.io/software#rtems> operating system.
> 
> 
>  Should I instal the  gnu toolchain for compilation ?

Of course. Use the or1k-elf toolchain if you're not using an operating 
system.

And please change your mailing list subscription from digest mode to all 
emails. That makes answering easier and keeps threads together.

Philipp


------------------------------

Subject: Digest Footer

_______________________________________________
OpenRISC mailing list
OpenRISC at lists.librecores.org
https://lists.librecores.org/listinfo/openrisc


------------------------------

End of OpenRISC Digest, Vol 17, Issue 6
***************************************


   
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20170805/e190d279/attachment.html>
