From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Wed, 6 Oct 2021 16:27:28 -0500
Subject: [OpenRISC] [PATCH 06/12] openrisc: Use of_get_cpu_hwid()
In-Reply-To: <YV4KkAC2p9D4yCnH@antec>
References: <20211006164332.1981454-1-robh@kernel.org>
 <20211006164332.1981454-7-robh@kernel.org> <YV4KkAC2p9D4yCnH@antec>
Message-ID: <20211006212728.GM10333@gate.crashing.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Oct 07, 2021 at 05:44:00AM +0900, Stafford Horne wrote:
> You have defined of_get_cpu_hwid to return u64, will this create compiler
> warnings when since we are storing a u64 into a u32?
> 
> It seems only if we make with W=3.

Yes.  This is done by -Wconversion, "Warn for implicit conversions that
may alter a value."

> I thought we usually warned on this.

This warning is not in -Wall or -Wextra either, it suffers too much from
false positives.  It is very natural to just ignore the high bits of
modulo types (which is what "unsigned" types *are*).  Or the bits that
"fall off" on a conversion.  The C standard makes this required
behaviour, it is useful, and it is the only convenient way of getting
this!


Segher
