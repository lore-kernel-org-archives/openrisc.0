From: Samuel Holland <samuel@sholland.org>
Date: Fri, 7 Sep 2018 17:29:09 -0500
Subject: [OpenRISC] OpenRISC GCC requirements
In-Reply-To: <CAAfxs77YuyjFts4h1ZECHoCV=kw3Y2LGy9k8dVQ_i9v1HobD_A@mail.gmail.com>
References: <CAAfxs77YuyjFts4h1ZECHoCV=kw3Y2LGy9k8dVQ_i9v1HobD_A@mail.gmail.com>
Message-ID: <3bf53e07-2a8b-eae8-6a70-aa81f5c86b32@sholland.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 09/07/18 06:27, Stafford Horne wrote:
> As many of us know OpenRISC has different classes for instructions.
> i.e. Class I and Class II.
> 
> The Class I instructions are required for all implementation and Class
> II instructions are optional.   For the new GCC port I have used a few
> class II instructions.
> 
> Does anyone have any opinion if this would be bad or cause issues?  To
> me I think its OK as I haven't seen a core without these.

I know of at least one currently-produced silicon implementation[1] based on an
old or1200 that has a broken l.cmov.

[1]: https://linux-sunxi.org/AR100

> Class II Instructions used:
>        l.extbs  - sign extend byte
>        l.extbz  - zero extend byte
>        l.exths  - sign extend half-word
>        l.exthz  - zero extend half-word
>        l.cmov  - conditional move

Looking at or1k.md, you used l.msync and l.ror, and l.sf*i as well. And l.cmov
and l.sf*i are also used in the libgcc implementation. Those also need to be
considered.

> The alternative would be to substitute the instructions with something
> else.   But I don't expect there would be many/any cores running C
> code that would be missing these instructions.
> 
> -Stafford

Thanks,
Samuel
