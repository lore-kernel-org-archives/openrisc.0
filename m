From: Stafford Horne <shorne@gmail.com>
Date: Mon, 1 Oct 2018 16:08:46 +0900
Subject: [OpenRISC] [PATCH 0/4] OpenRISC binutils updates and new relocs
In-Reply-To: <271e3bfa-4958-0387-9a82-ecfdb58f1e26@redhat.com>
References: <20180821143823.16985-1-shorne@gmail.com>
 <20180908213515.GN4594@lianli.shorne-pla.net>
 <aceede44-4ab0-9267-a949-5cd5f3c5e81e@redhat.com>
 <20180918095234.GP4594@lianli.shorne-pla.net>
 <20b65fc3-5bbb-6e77-f598-4582204ee0e5@redhat.com>
 <20180927060756.GB3318@lianli.shorne-pla.net>
 <271e3bfa-4958-0387-9a82-ecfdb58f1e26@redhat.com>
Message-ID: <20181001070846.GC3318@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Sep 28, 2018 at 04:39:03PM +0100, Nick Clifton wrote:
> 
> > To produce these errors I need to change the code, Using abort we see:
> > 
> >    /home/shorne/work/gnu-toolchain/local/lib/gcc/or1k-elf/9.0.0/../../../../or1k-elf/bin/ld: \
> >       BFD (GNU Binutils) 2.31.51.20180927 internal error, \
> >       aborting at ../../binutils-gdb/bfd/elf32-or1k.c:1152 in or1k_final_link_relocate
> 
[...] 
> Depending upon where you are in your code, if you have access to the link_info
> structure you can use its einfo() routine instead of bfd_error_handler.  This
> has the advantage that it allows a %X formatting directive, which causes the 
> program to terminate with an error exit code.

OK, thanks for the info.  I tested it out using einfo(), it does exit with an
error code, but it doesn't produce the line numbers and function name that
abort() gives us.  I am sure I could make it do it, but for now I will use the
error message + abort() as it gives me what I would want to see in a bug report
:).

V2 of the patch should be coming up soon.

-Stafford

