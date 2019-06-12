From: Stafford Horne <shorne@gmail.com>
Date: Wed, 12 Jun 2019 22:11:31 +0900
Subject: [OpenRISC] [PATCH v3 11/11] sim/testsuite/or1k: Add tests for
 unordered compares
In-Reply-To: <20190611214912.GT23204@embecosm.com>
References: <20190610204940.3846-1-shorne@gmail.com>
 <20190610204940.3846-2-shorne@gmail.com>
 <20190611214912.GT23204@embecosm.com>
Message-ID: <20190612131131.GC2358@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Jun 11, 2019 at 10:49:12PM +0100, Andrew Burgess wrote:
> * Stafford Horne <shorne@gmail.com> [2019-06-11 05:49:40 +0900]:
> 
> > Add tests for 32-bit and 64-bit unordered compare instructions.
> > 
> > sim/testsuite/sim/or1k/ChangeLog:
> > 
> > yyyy-mm-dd  Stafford Horne  <shorne@gmail.com>
> > 
> > 	* fpu-unordered.S: New file.
> > 	* fpu64a32-unordered.S: New file.
> 
> This is fine with the nits below fixed.

Sure, I will fix them.  Please note there are other patches for the sim that
have been updated (mostly regens from the binutils updates).

Also, this all depends on a cgen patch as well that is pending review.  So I
will wait to commit until cgen is reviewed.

-Stafford
