From: Jonathan Corbet <corbet@lwn.net>
Date: Thu, 03 Dec 2020 22:36:48 -0000
Subject: [OpenRISC] [PATCH 0/6] Add documentation for
 Documentation/features at the built docs
In-Reply-To: <cover.1606748711.git.mchehab+huawei@kernel.org>
References: <cover.1606748711.git.mchehab+huawei@kernel.org>
Message-ID: <20201203153642.594afd85@lwn.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, 30 Nov 2020 16:36:29 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> This series got already submitted last year:
> 
>    https://lore.kernel.org/lkml/cover.1561222784.git.mchehab+samsung at kernel.org/
> 
> Yet, on that time, there were too many other patches related to ReST
> conversion floating around. So, at the end, I guess this one got missed.
> 
> So, I did a rebase on the top of upstream, and added a few new changes.

OK, I've gone ahead and applied these; it gains me a new trivial conflict
with x86, but so be it...

That said, I think that the RST table formatting could be *way* improved.
The current tables are all white space and hard to make sense of.  What if
we condensed the information?  Just looking at the first entry in
Documentation/admin-guide/features.html, perhaps it could look like:

    FEATURE	KCONFIG/DESCRIPTION		STATUS

    cBPF-JIT	HAVE_CBPF_JIT			TODO: alpha, arc, arm...
    						ok: mips, powerpc, ...
		arch supports cBPF JIT
		optimizations

The result would be far more compact and easy to read, IMO.  I may get
around to giving this a try if (hint :) nobody else gets there first.

Thanks,

jon
