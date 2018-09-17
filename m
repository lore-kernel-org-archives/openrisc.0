From: Richard Henderson <rth@twiddle.net>
Date: Mon, 17 Sep 2018 09:29:28 -0700
Subject: [OpenRISC] [PATCH 0/4] OpenRISC binutils updates and new relocs
In-Reply-To: <aceede44-4ab0-9267-a949-5cd5f3c5e81e@redhat.com>
References: <20180821143823.16985-1-shorne@gmail.com>
 <20180908213515.GN4594@lianli.shorne-pla.net>
 <aceede44-4ab0-9267-a949-5cd5f3c5e81e@redhat.com>
Message-ID: <0aad2c15-5329-1d01-028f-2e9fcb14a783@twiddle.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 9/17/18 8:07 AM, Nick Clifton wrote:
> I do not see any need to add extra document for the new relocs, unless you
> have created new assembler pseudo-ops to generate them.  (I did not see any
> code to add such operators, but I may have missed something).

There is new syntax for these new relocs, in the form of function-like markup.

E.g:

	l.ori	r3,r4, at lo(foo)		# an existing reloc
	l.ori	r3,r4, at po(foo)		# a new reloc added here

> I do have one question though.  Is there a need to be able to distinguish 
> between binaries that use the new l.adrp instruction and those that don't.
> For example if a library is built using the new instruction but then it is
> linked into an executable which is supposed to run on silicon which does
> not support the new instruction, should the linker issue an error ?  If so,
> how does it detect this situation ?

I have never been a fan of how this is handled e.g. for mips.
To that end, I have done nothing at all.  This is more in line
with how we (do not) handle this situation for x86.


r~
