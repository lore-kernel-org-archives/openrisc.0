From: Stafford Horne <shorne@gmail.com>
Date: Fri, 13 Oct 2017 21:46:56 +0900
Subject: [OpenRISC] [PATCH v6 0/6] sim port for OpenRISC
In-Reply-To: <20171013123646.8206-1-shorne@gmail.com>
References: <20171013123646.8206-1-shorne@gmail.com>
Message-ID: <20171013124656.GE2958@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Oct 13, 2017 at 09:36:40PM +0900, Stafford Horne wrote:
 
> Peter Gavin (3):
>   sim: cgen: add remainder functions (needed for OR1K lf.rem.[sd])
>   sim: cgen: add MUL2OFSI and MUL1OFSI functions (needed for OR1K
>     l.mul[u])
>   sim: testsuite: add testsuite for or1k sim
> 
> Stafford Horne (3):
>   sim: or1k: add or1k target to sim
>   sim: or1k: add cgen generated files
>   sim: or1k: add autoconf generated files
> 

Hello,

As before the cgen and autoconf generated file patches did not get through, see 
details.

  ezmlm-reject: fatal: Sorry, I don't accept messages larger than 400000 bytes (#5.2.3)

On my system:

  -rw-rw-r--. 1 shorne shorne 787935 Oct 13 08:12 v6-0004-sim-or1k-add-cgen-generated-files.patch
  -rw-rw-r--. 1 shorne shorne 495163 Oct 13 08:12 v6-0005-sim-or1k-add-autoconf-generated-files.patch

If you are interested please pull from:

 https://github.com/stffrdhrn/binutils-gdb.git or1k-upstream-gdb-v8-sim-v6

Else I can sent you private zipped copies.

-Stafford
