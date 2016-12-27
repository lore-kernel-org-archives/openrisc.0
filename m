From: Stafford Horne <shorne@gmail.com>
Date: Tue, 27 Dec 2016 22:20:02 +0900
Subject: [OpenRISC] [PATCH v3 1/3] gdb: Add OpenRISC or1k and or1knd
	target support
In-Reply-To: <5c89b62c-1653-3b08-5fde-7f0cb0bcb1aa@codesourcery.com>
References: <cover.1482413820.git.shorne@gmail.com>
 <13c51e2561bb93a3e423c60ecd070cdaf2364330.1482413820.git.shorne@gmail.com>
 <d0a08c89-319f-b262-4a2d-21a83b5a3834@codesourcery.com>
 <20161225013127.GA10307@lianli.shorne-pla.net>
 <5c89b62c-1653-3b08-5fde-7f0cb0bcb1aa@codesourcery.com>
Message-ID: <20161227132002.GB2777@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, Dec 26, 2016 at 10:10:02AM -0600, Luis Machado wrote:
> On 12/24/2016 07:31 PM, Stafford Horne wrote:
> > On Fri, Dec 23, 2016 at 03:20:52PM -0600, Luis Machado wrote:
> > > On 12/22/2016 10:14 AM, Stafford Horne wrote:
> > > > +
> > > > +/* OpenRISC specific includes.  */
> > > > +#include "or1k-tdep.h"
> > > > +

> > > > +
> > > > +/* The target-dependant structure for gdbarch.  */
> > > > +
> > > > +struct gdbarch_tdep
> > > > +{
> > > > +  int bytes_per_word;
> > > > +  int bytes_per_address;
> > > > +  CGEN_CPU_DESC gdb_cgen_cpu_desc;
> > > > +};
> > > > +
> > > > +/* Support functions for the architecture definition.  */
> > > > +
> > > > +/* Get an instruction from memory.  */
> > > > +
> > > > +static ULONGEST
> > > > +or1k_fetch_instruction (struct gdbarch *gdbarch, CORE_ADDR addr)
> > > > +{
> > > > +  enum bfd_endian byte_order = gdbarch_byte_order (gdbarch);
> > > > +  gdb_byte buf[OR1K_INSTLEN];
> > > > +
> > > > +  if (target_read_memory (addr, buf, OR1K_INSTLEN))
> > > > +    {
> > > > +      memory_error (TARGET_XFER_E_IO, addr);
> > > > +    }
> > > > +
> > > 
> > > No need for curly braces for single-statement conditional blocks.
> > 
> > Alright, I missed that part of the gnu style spec. I have been looking
> > at the formatting guide [0].  Is there something better or is there a
> > way to get emacs (or something else) to validate everything including
> > comments and spurious newlines?
> > 
> 
> I'm not sure. Other emacs users in gdb land can chime in. I'm a vim user
> myself, and i use some extensions to make whitespace (trailing/leading)
> issues more obvious, as well as lines with more than 80 cols.

Alright, I'm a vim user as well.  But I installed emacs just to see what
was available, couldn't find much.  I will use what I have and can find.
 
> > > > +/* Generic function to read bits from an instruction.  */
> > > > +
> > > > +static int
> > > > +or1k_analyse_inst (uint32_t inst, const char *format, ...)
> > > > +{
> > > > +  /* Break out each field in turn, validating as we go.  */
> > > > +  va_list ap;
> > > > +
> > > > +  int i;
> > > > +  int iptr = 0;			/* Instruction pointer */
> > > > +
> > > > +  va_start (ap, format);
> > > > +
> > > > +  for (i = 0; 0 != format[i];)
> > > > +    {
> > > > +      const char *start_ptr;
> > > > +      char *end_ptr;
> > > > +
> > > > +      uint32_t bits;		/* Bit substring of interest */
> > > > +      uint32_t width;		/* Substring width */
> > > > +      uint32_t *arg_ptr;
> > > > +
> > > > +      switch (format[i])
> > > > +	{
> > > > +	case ' ':
> > > > +	  i++;
> > > > +	  break;		/* Formatting: ignored */
> > > > +
> > > > +	case '0':
> > > > +	case '1':		/* Constant bit field */
> > > > +	  bits = (inst >> (OR1K_INSTBITLEN - iptr - 1)) & 0x1;
> > > > +
> > > > +	  if ((format[i] - '0') != bits)
> > > > +	    {
> > > > +	      return 0;
> > > > +	    }
> > > 
> > > No need for curly braces. Possibly more occurrences of this.
> > > 
> > > Also, the identation seems a bit off. In special for some of the comments.
> > 
> > Are you meaning the right side comments should be aligned? I think the
> > code indentation looked alright for the most part.
> > 
> 
> The alignment of the comments on the same line as the statement feel a bit
> too far. I'd put them closer to the statement, but that may be a matter of
> personal taste though.

OK, I am going to change to have just 1 space between end of statement
and the comment. 

> I was referring to the identation of the case statements. They appear as if
> they are aligned at the same level as the for statement, so behind the
> switch. Maybe a whitespace/tab problem?
> 
> If they're correct, then nothing needs to be done there.

I think they are correct.  I did find a few other indentation issues.

> > > > +
> > > > +	  iptr++;
> > > > +	  i++;
> > > > +	  break;
> > > > +
> > > > +	case '%':		/* Bit field */
> > > > +	  i++;
> > > > +	  start_ptr = &(format[i]);
> > > > +	  width = strtoul (start_ptr, &end_ptr, 10);
> > > > +
> > > > +	  /* Check we got something, and if so skip on */
> > > 
> > > period and two spaces after end of comment. More occurrences of this
> > > throughout.
> > 
> > I will fix this one and a few more which are sentences.  For short (label)
> > comments I have left them without the period.
> 
> For short comments that is fine.
> 
> > 
> > Let me know if there is an issue with this.  There is not much mentioned
> > about this (short comments) in the style guide [1]
> > 
> > [1] https://www.gnu.org/prep/standards/html_node/Comments.html#Comments
> > 
> > > > +	  if (start_ptr == end_ptr)
> > > > +	    {
> > > > +	      throw_quit
> > > > +		("bitstring \"%s\" at offset %d has no length field.\n",
> > > > +		 format, i);
> > > > +	    }
> > > > +
> > > > +	  i += end_ptr - start_ptr;
> > > > +
> > > > +	  /* Look for and skip the terminating 'b'. If it's not there, we
> > > > +	     still give a fatal error, because these are fixed strings that
> > > > +	     just should not be wrong.  */
> > > 
> > > Two spaces after period. More occurrences throughout.
> > 
> > This one does have 2 spaces after period.  Am I missing something? Or do
> > you mean within the comment (... 'b'._If it's ...)?
> > 
> 
> We require two spaces after period even within the comment block, not just
> at its end.

Understood, those will be fixed.

> > > > +}
> > > > +
> > > > +
> > > > +/* Analyse a l.addi instruction in form: l.addi  rD,rA,I. This is used
> > > > +   to parse add instructions during various prologue analysis routines.  */
> > > > +
> > > > +static int
> > > > +or1k_analyse_l_addi (uint32_t inst,
> > > > +		     unsigned int *rd_ptr,
> > > > +		     unsigned int *ra_ptr, int *simm_ptr)
> > > > +{
> > > > +  /* Instruction fields */
> > > > +  uint32_t rd, ra, i;
> > > > +
> > > > +  if (or1k_analyse_inst (inst, "10 0111 %5b %5b %16b", &rd, &ra, &i))
> > > > +    {
> > > > +      /* Found it. Construct the result fields.  */
> > > > +      *rd_ptr = (unsigned int) rd;
> > > > +      *ra_ptr = (unsigned int) ra;
> > > 
> > > Do we need these explicit cast or can we use types that make the casts go
> > > away?
> > 
> > I had a look, its going to be a bit of work to fix this. The return
> > values ra/rd/i are derived from the input uint32_t so they retain that
> > type.  It would require either changing the instruction type, or
> > changing the types of rd_ptr/ra_ptr which might require casts in
> > less convenient places.
> > 
> > Will spend some more time to see what can be done.  If you have a quick
> > idea let me know.
> > 
> 
> If rd_ptr and ra_ptr are supposed to always point to 32-bit unsigned values,
> then uint32_t sounds more appropriate. The compiler gets to decide what
> "unsigned int" means, so that may be bigger/smaller depending on what the
> compiler is doing.
> 
> In any case, this is more a suggestion to attempt to clean the code up a
> little bit, not a requirement.

I will work on it.  Ill update in v4 the results.

> > > > +  /* Check any target description for validity.  */
> > > > +  if (tdesc_has_registers (info.target_desc))
> > > > +    {
> > > > +      const struct tdesc_feature *feature;
> > > > +      int valid_p;
> > > > +
> > > > +      feature = tdesc_find_feature (info.target_desc, "org.gnu.gdb.or1k.group0");
> > > 
> > > Where is this target description coming from? I don't see an xml file with
> > > the patch series. Is it going to be submitted? Or this something a remote
> > > stub/simulator sends GDB upon connection?
> > 
> > Currently the only target that supplies the XML description is OpenOCD.
> > I have some XML which I generated for testing this without OpenOCD.  I
> > will see if I can clean that up and add to the patch series.
> > 
> 
> It would be useful to have a target description on gdb's side so we can
> fallback to it whenever the target fails to provide a valid target
> description. It can also serve as a base for people implementing debugging
> stubs, since they can always refer to what gdb supports.
> 
> Additionally, it can help support core files in the future, if one needs it.

Understood, Ill try to get it in.  It would be good if the gdb builtin sim
can support most of the ~1000+ registers as well.

> > > > +/* Properties of the architecture. GDB mapping of registers is all the GPRs
> > > > +   and SPRs followed by the PPC, NPC and SR at the end. Red zone is the area
> > > > +   past the end of the stack reserved for exception handlers etc.  */
> > > > +
> > > > +#define OR1K_MAX_GPR_REGS            32
> > > > +#define OR1K_NUM_PSEUDO_REGS         0
> > > > +#define OR1K_NUM_REGS               (OR1K_MAX_GPR_REGS + 3)
> > > > +#define OR1K_STACK_ALIGN             4
> > > > +#define OR1K_INSTLEN                 4
> > > > +#define OR1K_INSTBITLEN             (OR1K_INSTLEN * 8)
> > > > +#define OR1K_NUM_TAP_RECORDS         8
> > > > +#define OR1K_FRAME_RED_ZONE_SIZE     2536
> > > > +
> > > > +#endif /* OR1K_TDEP__H */
> > > > 
> > > 
> > > It would be nice to have all the formatting and cosmetics polished/fixed
> > > before we can give it another look for correctness of the code itself. Right
> > > now there are quite a bit of formatting issues.
> > > 
> > > Patches 2/3 and 3/3 look fine to me.
> > 
> > Thank you for the review.  As this is V3 and a big part of this version
> > was fixing formatting issues I should have done better to make sure we
> > were past that.
> 
> No worries. The formatting bits take a bit of practice to get right and we
> do appreciate your patience in coping with it.
> 
> > 
> > I tried to use 'indent' and regex's to find and fix the issues.  If you
> > have any pointers for automating the cleanup it would be helpful.  But
> > for now I will be going over it manually based on your comments.
> 
> The above will definitely help with fixing things up, but i wouldn't say
> they will be 100% accurate, especially with an existing code base.
> 
> There are only a few types of issues in this patch though, so we the
> comments, newlines, curly braces and identation fixed up we can catch other
> potential offenders as it goes.

Thanks for reviewing again.

-Stafford


