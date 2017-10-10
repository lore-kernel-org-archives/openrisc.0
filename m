From: Stafford Horne <shorne@gmail.com>
Date: Wed, 11 Oct 2017 08:03:23 +0900
Subject: [OpenRISC] [PATCH v5 3/6] sim: or1k: add or1k target to sim
In-Reply-To: <001a114a9bbe18b046055b2055bc@google.com>
References: <001a114a9bbe18b046055b2055bc@google.com>
Message-ID: <20171010230323.GD2958@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Oct 09, 2017 at 05:15:08PM +0000, Doug Evans wrote:
> Simon Marchi writes:
>  > On 2017-10-05 09:49 AM, Stafford Horne wrote:
>  > > This adds the OpenRISC 32-bit sim target.  The OpenRISC sim is a CGEN
>  > > based sim so the bulk of the code is generated from the .cpu files by
>  > > CGEN.  The engine decode and execute logic in mloop uses scache with
>  > > pseudo-basic-block extraction and supports both full and fast (switch)
>  > > modes.
>  > > 
>  > > The sim does not implement an mmu at the moment.  The sim does implement
>  > > fpu instructions via the common sim-fpu implementation.
>  > > 
>  > > sim/ChangeLog:
>  > > 
>  > > 2017-09-13  Stafford Horne  <shorne@gmail.com>
>  > > 	    Peter Gavin  <pgavin@gmail.com>
>  > > 
>  > > 	* configure.tgt: Add or1k sim.
>  > > 	* or1k/Makefile.in: New file.
>  > > 	* or1k/configure.ac: New file.
>  > > 	* or1k/mloop.in: New file.
>  > > 	* or1k/or1k-sim.h: New file.
>  > > 	* or1k/or1k.c: New file.
>  > > 	* or1k/sim-if.c: New file.
>  > > 	* or1k/sim-main.h: New file.
>  > > 	* or1k/traps.c: New file.
>  > > ...
>  > > 
>  > > +#define CHECK_SPR_FIELD(GROUP, INDEX, FIELD, test)                      \
>  > > +  do {                                                                  \
>  > > +    USI field = GET_H_##SYS##_##INDEX##_##FIELD ();                     \
>  > > +    if (!(test)) {                                                      \
>  > > +      sim_io_eprintf(sd, "WARNING: unsupported %s field in %s register: 0x%x\n", \
>  > 
>  > 80 columns.
> 
> fwiw, I don't mind the odd >80 column limit breaker.
> Moving the string to the next line may just work,
> but if it doesn't it's fine by me to just leave it.

Thanks for this and the other comments.  I will get them fixed up and a new
version sent.

-Stafford
