From: Stafford Horne <shorne@gmail.com>
Date: Tue, 18 Apr 2017 23:20:55 +0900
Subject: [OpenRISC] [Qemu-devel] [PATCH 2/7] target/openrisc: add
	shutdown logic
In-Reply-To: <6914f9b7-ece1-973d-2210-871b71319ae0@twiddle.net>
References: <cover.1492384862.git.shorne@gmail.com>
 <fb69c137317a365dcb549dfef1ecd2fbff48e92c.1492384862.git.shorne@gmail.com>
 <6914f9b7-ece1-973d-2210-871b71319ae0@twiddle.net>
Message-ID: <20170418142055.GB2599@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Apr 18, 2017 at 12:52:52AM -0700, Richard Henderson wrote:
> On 04/16/2017 04:23 PM, Stafford Horne wrote:
> > In openrisc simulators we use hooks like 'l.nop 1' to cause the
> > simulator to exit.  Implement that for qemu too.
> > 
> > Reported-by: Waldemar Brodkorb <wbx@openadk.org>
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> 
> As I said the first time this was posted: This is horrible.
> 
> If you want to do something like this, it needs to be buried under a special
> run mode like -semihosting.

Understood,  I will revise this.  I didnt know this was posted before.

> >          case 0x01:    /* l.nop */
> >              LOG_DIS("l.nop %d\n", I16);
> > +            {
> > +                TCGv_i32 arg = tcg_const_i32(I16);
> > +                gen_helper_nop(arg);
> > +            }
> 
> You also really really must special-case l.nop 0 so that it doesn't generate
> a function call.  Just think of all the extra calls you're adding for every
> delay slot that couldn't be filled.

Yeah, that makes sense.  Ill add that for l.nop 0.

-Stafford

> 
> r~
