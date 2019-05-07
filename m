From: Richard Henderson <rth@twiddle.net>
Date: Tue, 7 May 2019 08:28:45 -0700
Subject: [OpenRISC] OpenRISC 1.3 spec
In-Reply-To: <20190425211702.GG32284@lianli.shorne-pla.net>
References: <CAAfxs77GkWenpN0s1pM_YeVgNZabBx55fCqLfxoMffTSa-E=cw@mail.gmail.com>
 <afc760d8-0e01-6470-c8d2-6ddc366f3d10@twiddle.net>
 <20190412214843.GB32284@lianli.shorne-pla.net>
 <05413d8c-395c-de51-95f6-cdaa85c834dd@twiddle.net>
 <20190413084708.GC32284@lianli.shorne-pla.net>
 <3D70BAC7A5B64C0E977D84EC118F146E@BAndViG>
 <20190425211702.GG32284@lianli.shorne-pla.net>
Message-ID: <e441bb74-5cea-6002-c33e-4822f082265b@twiddle.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 4/25/19 2:17 PM, Stafford Horne wrote:
> This is implemented in binutils now. See my patches here:
> 
>   - https://github.com/stffrdhrn/binutils-gdb/commits/orfpx64a32-3
> 
> I have not squashed the commits because it makes it a bit easier for reviewing
> what I did to get these flags working.

I've implemented this for qemu,

  https://github.com/rth7680/qemu/commits/tgt-or1k

although untested so far.  I need to regenerate my
cross-testing environment for or1k...


r~
