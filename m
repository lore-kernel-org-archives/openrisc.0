From: Stafford Horne <shorne@gmail.com>
Date: Fri, 7 Jun 2019 07:11:30 +0900
Subject: [OpenRISC] OpenRISC 1.3 spec
In-Reply-To: <A49361B4A05048AD995FF588CC923E61@BAndViG>
References: <20190413084708.GC32284@lianli.shorne-pla.net>
 <3D70BAC7A5B64C0E977D84EC118F146E@BAndViG>
 <20190425211702.GG32284@lianli.shorne-pla.net>
 <e441bb74-5cea-6002-c33e-4822f082265b@twiddle.net>
 <20190507211254.GD11006@lianli.shorne-pla.net>
 <6CFC558D2E0643BAA8C0CFCB1AEE95BB@BAndViG>
 <3ce42625-83fe-4ee2-b48f-23e6362ee616@twiddle.net>
 <AED0C7019AE04A2F87CD0E432FA20A70@BAndViG>
 <20190511100433.GA20465@lianli.shorne-pla.net>
 <A49361B4A05048AD995FF588CC923E61@BAndViG>
Message-ID: <20190606221130.GF3379@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sun, May 12, 2019 at 10:58:53PM +0300, BAndViG wrote:
>>From: Stafford Horne
>>Sent: Saturday, May 11, 2019 1:04 PM
>
>>> On Fri, May 10, 2019 at 10:56:05AM +0300, BAndViG wrote:
>>> I've been thinking about a variants for R0 write protection. R0 could be
>>> zero initialized at cpu_rst by dedicated circuits. And `invalid > 
>>instruction`
>>> exception should be raised if an instruction tries to write to R0. At the
>>> same time such behavior is incompatible with current run-time > 
>>initialization
>>> sequences implemented in OR1K tool chains. The circle is closed.
>
>>We still have the option to drop the validation.  Just as we don't have
>>validation for writing to r0, I think its fine to say r31's pair register is
>>undefined and should be avoided. (i.e. on some machines it might go into the
>>shadow reg space)
>
>On the one hand I'm a kind of perfectionist and would prefer to 
>implement such protections. On the other hand they cost noticeable 
>space and timing. Not trivial choice for me :).
>
>>On the other hand, I have finished the GCC updates for unordered comparisons.
>>You can see the patch here, I built newlib with this enabled and was able to
>>shake out a few bugs.  It seems to work:
>
>>  - https://github.com/stffrdhrn/gcc/commits/or1k-fpu-2
>
>>The new gcc argument is:
>
>>  -munordered-float
>
>I've build two variants of GCC9/NewLIB tool chains. One has got 
>"-mhard-float -munordered-float" options raised by default. And 
>another one has got "-mhard-float -mdouble-float -munordered-float" 
>default options. First variant was used to build single precision 
>Whetstone for mor1kx+FPU32 and second to build single and double 
>precision Whetstone for MAROCCHINO. All variants work.
>We could merge fp_unordered_cmp branches into master. Or should we 
>postpone the merge till your binutils/gcc patches being upstreamed?
>
>WBR
>Andrey


Hello Richard, Andrey, OpenRISCers,

This is the final review for spec version 1.3.  The pdf is here:

 - https://github.com/openrisc/doc/raw/master/openrisc-arch-1.3-rev1.pdf

To see a history of the changes so far check out these pull requests:

 - https://github.com/openrisc/doc/pull/2 - Spec Updates from Stafford
 - https://github.com/openrisc/doc/pull/3 - SPec Updates from Andrey

These PRs are all merged and the last thing we have is to merge the website and
news updates to make it official:

 - https://github.com/openrisc/openrisc.github.io/pull/13

I'll let it sit for a bit to see if we can collect any comments or feedback on
the final document.  So please speak up.

But anyway, if there are any issues after the fact we can always create a
revision 2.

-Stafford
