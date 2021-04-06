From: Daniel Walker <danielwa@cisco.com>
Date: Tue, 6 Apr 2021 10:38:36 -0700
Subject: [OpenRISC] [PATCH v4 19/20] mips: Convert to GENERIC_CMDLINE
In-Reply-To: <a01b6cdbae01fff77e26f7a5c40ee5260e1952b5.1617375802.git.christophe.leroy@csgroup.eu>
References: <cover.1617375802.git.christophe.leroy@csgroup.eu>
 <a01b6cdbae01fff77e26f7a5c40ee5260e1952b5.1617375802.git.christophe.leroy@csgroup.eu>
Message-ID: <20210406173836.GW2469518@zorba>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Apr 02, 2021 at 03:18:21PM +0000, Christophe Leroy wrote:
> -config CMDLINE_BOOL
> -	bool "Built-in kernel command line"
> -	help
> -	  For most systems, it is firmware or second stage bootloader that
> -	  by default specifies the kernel command line options.  However,
> -	  it might be necessary or advantageous to either override the
> -	  default kernel command line or add a few extra options to it.
> -	  For such cases, this option allows you to hardcode your own
> -	  command line options directly into the kernel.  For that, you
> -	  should choose 'Y' here, and fill in the extra boot arguments
> -	  in CONFIG_CMDLINE.
> -
> -	  The built-in options will be concatenated to the default command
> -	  line if CMDLINE_OVERRIDE is set to 'N'. Otherwise, the default
> -	  command line will be ignored and replaced by the built-in string.
> -
> -	  Most MIPS systems will normally expect 'N' here and rely upon
> -	  the command line from the firmware or the second-stage bootloader.
> -


See how you complained that I have CMDLINE_BOOL in my changed, and you think it
shouldn't exist.

Yet here mips has it, and you just deleted it with no feature parity in your
changes for this.

In my changes I tried to maintain as much feature parity as I could with the
architectures. I did the same huge conversion a long time ago you've done here to be sure all
platforms have the features needed.

Daniel
