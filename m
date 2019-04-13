From: Richard Henderson <rth@twiddle.net>
Date: Fri, 12 Apr 2019 22:11:41 -1000
Subject: [OpenRISC] OpenRISC 1.3 spec
In-Reply-To: <20190412214843.GB32284@lianli.shorne-pla.net>
References: <CAAfxs77GkWenpN0s1pM_YeVgNZabBx55fCqLfxoMffTSa-E=cw@mail.gmail.com>
 <afc760d8-0e01-6470-c8d2-6ddc366f3d10@twiddle.net>
 <20190412214843.GB32284@lianli.shorne-pla.net>
Message-ID: <05413d8c-395c-de51-95f6-cdaa85c834dd@twiddle.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 4/12/19 11:48 AM, Stafford Horne wrote:
> Thanks for your feedback, I think this can be done.  I looked through the
> encodings and {10,9,8} look usable.
> 
>    31  26  21  16  11     8      0
>   [ 0x32 | D | A | B | res | 0x10 ]    lf.add.d
>   [ 0x32 | D | A | B | res | 0x11 ]    lf.sub.d
>                       ...
> 
>    31  26    21  16  11     8      0
>   [ 0x32 | res | A | B | res | 0x18 ]  lf.sfeq.d
>   [ 0x32 | res | A | B | res | 0x19 ]  lf.sfne.d
>                       ...
> 
>    31  26  21  16    11     8      0
>   [ 0x32 | D | A | 0x0 | res | 0x15 ]  lf.ftoi.d
>   [ 0x32 | D | A | 0x0 | res | 0x14 ]  lf.itof.d
> 
> I propose:
> 
>   bit-10 - 1 indicates if rd2 is +2
>   bit-9  - 1 indicates if ra2 is +2
>   bit-8  - 1 indicates if rb2 is +2

Thanks.  LGTM.

This does cancel the second half of P6, where
I was proposing 3 inputs and 1 output from lf.madd;
rd will have to serve as both input and output.

> Its not too late if its before silicon ;)

Hah!


r~
