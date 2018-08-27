From: H. Peter Anvin <hpa@zytor.com>
Date: Mon, 27 Aug 2018 06:33:27 -0700
Subject: [OpenRISC] [PATCH] treewide: remove current_text_addr
In-Reply-To: <20180827131103.GD24124@hirez.programming.kicks-ass.net>
References: <20180821202900.208417-1-ndesaulniers@google.com>
 <207784db-4fcc-85e7-a0b2-fec26b7dab81@gmx.de>
 <c62e4e00-fb8f-19a6-f3eb-bde60118cb1a@zytor.com>
 <81141365-8168-799b-f34f-da5f92efaaf9@zytor.com>
 <7f49eeab-a5cc-867f-58fb-abd266f9c2c9@zytor.com>
 <6ca8a1d3-ff95-e9f4-f003-0a5af85bcb6f@zytor.com>
 <CA+55aFzuSCKfmgT9efHuwtan+m3+bPh4BpwbZwn5gGX_H=Thuw@mail.gmail.com>
 <CAKwvOd=wAaPBkFHAcWxgMW91a--9gbvu7xrt3j-q8c+-mT=7Lw@mail.gmail.com>
 <20180827073358.GV24124@hirez.programming.kicks-ass.net>
 <f9896d68-4a49-e666-cea5-a9c0522f1658@zytor.com>
 <20180827131103.GD24124@hirez.programming.kicks-ass.net>
Message-ID: <4d1a8f35-e2fc-70d2-ca0e-44b8574c86f1@zytor.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 08/27/18 06:11, Peter Zijlstra wrote:
> On Mon, Aug 27, 2018 at 05:26:53AM -0700, H. Peter Anvin wrote:
> 
>> _THIS_IP_, however, is completely ill-defined, other than being an
>> address *somewhere* in the same global function (not even necessarily
>> the same function if the function is static!)  As my experiment show, in
>> many (nearly) cases gcc will hoist the address all the way to the top of
>> the function, at least for the current generic implementation.
> 
> It seems to have mostly worked so far... did anything change?
> 

Most likely because the major architectures contain a arch-specific
assembly implementation.  The generic implementation used in some places
is completely broken, as my experiments show.

>> For the case where _THIS_IP_ is passed to an out-of-line function in all
>> cases, it is extra pointless because all it does is increase the
>> footprint of every caller: _RET_IP_ is inherently passed to the function
>> anyway, and with tailcall protection it will uniquely identify a callsite.
> 
> So I think we can convert many of the lockdep _THIS_IP_ calls to
> _RET_IP_ on the other side, with a wee bit of care.
> 
> A little something like so perhaps...

I don't have time to look at this right now (I'm on sabbatical, and I'm
dealing with personal legal stuff right at the moment), but I think it
is the right direction.

	-hpa
