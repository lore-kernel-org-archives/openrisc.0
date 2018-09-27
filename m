From: Stafford Horne <shorne@gmail.com>
Date: Thu, 27 Sep 2018 15:07:56 +0900
Subject: [OpenRISC] [PATCH 0/4] OpenRISC binutils updates and new relocs
In-Reply-To: <20b65fc3-5bbb-6e77-f598-4582204ee0e5@redhat.com>
References: <20180821143823.16985-1-shorne@gmail.com>
 <20180908213515.GN4594@lianli.shorne-pla.net>
 <aceede44-4ab0-9267-a949-5cd5f3c5e81e@redhat.com>
 <20180918095234.GP4594@lianli.shorne-pla.net>
 <20b65fc3-5bbb-6e77-f598-4582204ee0e5@redhat.com>
Message-ID: <20180927060756.GB3318@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Nick,

On Tue, Sep 18, 2018 at 12:55:48PM +0100, Nick Clifton wrote:
> One other thing:  There are several places where you add calls to 
> abort().  Now this is not wrong, and certainly not a reason to 
> reject the patch, but I consider it to be unhelpful.  To my mind
> a library, or tool, should generate an error message when something
> goes wrong and not leave the user wondering why they have suddenly
> got a segmentation fault.
> 
> Plus if you have a call to abort() in the code you can bet that some 
> enterprising person with a binary fuzzer will find a way to trigger 
> it, and then file a CVE about it.  (Fixing CVEs is the bane of my 
> life as they involve lots of extra administrivia).

I have been away the last week and am just getting to fixing these abort()'s
now.  However, I have a question.

The aborts I see are:

  bfd/elf32-or1k.c (or1k_final_link_relocate) - 2 places
  cpu/or1k-asm.c (parse_imm16) - 1 place

In these cases we call abort if a switch statement falls through to the default
case. If we get an abort its definitely a bug.

To produce these errors I need to change the code, Using abort we see:

   /home/shorne/work/gnu-toolchain/local/lib/gcc/or1k-elf/9.0.0/../../../../or1k-elf/bin/ld: \
      BFD (GNU Binutils) 2.31.51.20180927 internal error, \
      aborting at ../../binutils-gdb/bfd/elf32-or1k.c:1152 in or1k_final_link_relocate

   /home/shorne/work/gnu-toolchain/local/lib/gcc/or1k-elf/9.0.0/../../../../or1k-elf/bin/ld: \
      Please report this bug.

   collect2: error: ld returned 1 exit status

There is no segmentation fault.  I agree, it is more nice to create a message
inform which error triggered the issue.

Is something like this ok?

    default:
      _bfd_error_handler
	(_("%pB: Unknown complain on overflow value on howto specified %d"),
	 input_bfd, (int) howto->complain_on_overflow);
      abort();

i.e. _bfd_error_handler() followed by abort().  I couldn't really see a way to
_bfd_error_handler() to actually cause the program to exit.

-Stafford
