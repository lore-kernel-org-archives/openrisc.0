From: Daniel Walker <danielwa@cisco.com>
Date: Thu, 8 Apr 2021 18:23:49 -0700
Subject: [OpenRISC] [PATCH v4 19/20] mips: Convert to GENERIC_CMDLINE
In-Reply-To: <20210408190408.GA1724284@robh.at.kernel.org>
References: <cover.1617375802.git.christophe.leroy@csgroup.eu>
 <a01b6cdbae01fff77e26f7a5c40ee5260e1952b5.1617375802.git.christophe.leroy@csgroup.eu>
 <20210406173836.GW2469518@zorba>
 <20210408190408.GA1724284@robh.at.kernel.org>
Message-ID: <20210409012349.GG3981976@zorba>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Apr 08, 2021 at 02:04:08PM -0500, Rob Herring wrote:
> On Tue, Apr 06, 2021 at 10:38:36AM -0700, Daniel Walker wrote:
> > On Fri, Apr 02, 2021 at 03:18:21PM +0000, Christophe Leroy wrote:
> > > -config CMDLINE_BOOL
> > > -	bool "Built-in kernel command line"
> > > -	help
> > > -	  For most systems, it is firmware or second stage bootloader that
> > > -	  by default specifies the kernel command line options.  However,
> > > -	  it might be necessary or advantageous to either override the
> > > -	  default kernel command line or add a few extra options to it.
> > > -	  For such cases, this option allows you to hardcode your own
> > > -	  command line options directly into the kernel.  For that, you
> > > -	  should choose 'Y' here, and fill in the extra boot arguments
> > > -	  in CONFIG_CMDLINE.
> > > -
> > > -	  The built-in options will be concatenated to the default command
> > > -	  line if CMDLINE_OVERRIDE is set to 'N'. Otherwise, the default
> > > -	  command line will be ignored and replaced by the built-in string.
> > > -
> > > -	  Most MIPS systems will normally expect 'N' here and rely upon
> > > -	  the command line from the firmware or the second-stage bootloader.
> > > -
> > 
> > 
> > See how you complained that I have CMDLINE_BOOL in my changed, and you think it
> > shouldn't exist.
> > 
> > Yet here mips has it, and you just deleted it with no feature parity in your
> > changes for this.
> 
> AFAICT, CMDLINE_BOOL equates to a non-empty or empty CONFIG_CMDLINE. You 
> seem to need it just because you have CMDLINE_PREPEND and 
> CMDLINE_APPEND. If that's not it, what feature is missing? CMDLINE_BOOL 
> is not a feature, but an implementation detail.

Not true.

It makes it easier to turn it all off inside the Kconfig , so it's for usability
and multiple architecture have it even with just CMDLINE as I was commenting
here.

Daniel
