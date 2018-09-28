From: Nick Clifton <nickc@redhat.com>
Date: Fri, 28 Sep 2018 16:39:03 +0100
Subject: [OpenRISC] [PATCH 0/4] OpenRISC binutils updates and new relocs
In-Reply-To: <20180927060756.GB3318@lianli.shorne-pla.net>
References: <20180821143823.16985-1-shorne@gmail.com>
 <20180908213515.GN4594@lianli.shorne-pla.net>
 <aceede44-4ab0-9267-a949-5cd5f3c5e81e@redhat.com>
 <20180918095234.GP4594@lianli.shorne-pla.net>
 <20b65fc3-5bbb-6e77-f598-4582204ee0e5@redhat.com>
 <20180927060756.GB3318@lianli.shorne-pla.net>
Message-ID: <271e3bfa-4958-0387-9a82-ecfdb58f1e26@redhat.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Stafford,

> To produce these errors I need to change the code, Using abort we see:
> 
>    /home/shorne/work/gnu-toolchain/local/lib/gcc/or1k-elf/9.0.0/../../../../or1k-elf/bin/ld: \
>       BFD (GNU Binutils) 2.31.51.20180927 internal error, \
>       aborting at ../../binutils-gdb/bfd/elf32-or1k.c:1152 in or1k_final_link_relocate

> There is no segmentation fault.

Sorry, you are right - the abort does not trigger a segmentation fault.



> I agree, it is more nice to create a message
> inform which error triggered the issue.
> 
> Is something like this ok?
> 
>     default:
>       _bfd_error_handler
> 	(_("%pB: Unknown complain on overflow value on howto specified %d"),
> 	 input_bfd, (int) howto->complain_on_overflow);
>       abort();
> 
> i.e. _bfd_error_handler() followed by abort().  I couldn't really see a way to
> _bfd_error_handler() to actually cause the program to exit.

Depending upon where you are in your code, if you have access to the link_info
structure you can use its einfo() routine instead of bfd_error_handler.  This
has the advantage that it allows a %X formatting directive, which causes the 
program to terminate with an error exit code.

But otherwise, if there is no reasonable way to return to the caller, then
caryr on using abort.  Adding the error messages still helps though.

Cheers
  Nick


