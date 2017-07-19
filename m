From: Philipp Wagner <lists@philipp-wagner.com>
Date: Wed, 19 Jul 2017 13:39:46 +0200
Subject: [OpenRISC] OpenRISC Digest, Vol 17, Issue 4
In-Reply-To: <1979566711.437787.1500461368182@mail.yahoo.com>
References: <mailman.1.1500458401.15711.openrisc@lists.librecores.org>
 <1979566711.437787.1500461368182@mail.yahoo.com>
Message-ID: <55ecb1f9-6697-791a-ac37-d45265834703@philipp-wagner.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 07/19/2017 12:49 PM, jallouli kais wrote:
> https://openrisc.io/software
> 
> For building a  software, OpenRISC is supported by a 32-bit GNU 
> toolchain offering C and C++ support. The toolchain is available in 
> several forms, depending on your use case.
> 
>   *
>     or1k-elf <https://openrisc.io/software#mewlib-toolchain> for bare
>     metal use, based on the newlib library.
>   *
>     or1k-linux-uclibc <https://openrisc.io/software#uclibc-ng-toolchain>
>     for Linux <https://openrisc.io/software#linux> application use,
>     based on the uClibc-ng library.
>   *
>     or1k-linux-musl <https://openrisc.io/software#musl-toolchain> also
>     for Linux <https://openrisc.io/software#linux> application use,
>     based on the musl library. (recommended over uClibc)
>   *
>     or1k-rtems <https://openrisc.io/software#rtems-toolchain> for
>     building software that runs on the RTEMS
>     <https://openrisc.io/software#rtems> operating system.
> 
> 
>   Should I instal the  gnu toolchain for compilation ?

Of course. Use the or1k-elf toolchain if you're not using an operating 
system.

And please change your mailing list subscription from digest mode to all 
emails. That makes answering easier and keeps threads together.

Philipp
