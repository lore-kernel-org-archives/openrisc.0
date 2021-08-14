From: Giulio Benetti <giulio.benetti@benettiengineering.com>
Date: Sat, 14 Aug 2021 23:01:16 +0200
Subject: [OpenRISC] [PATCH v2 0/2] OpenRISC support for cmodel=large
In-Reply-To: <20210501211145.2980164-1-shorne@gmail.com>
References: <20210501211145.2980164-1-shorne@gmail.com>
Message-ID: <da63081f-fe79-32c2-37f1-f17ce62f967b@benettiengineering.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi All,

On 5/1/21 11:11 PM, Stafford Horne wrote:
> Changes from v1:
>   - Added patch to enabled cmodle=large on crtstuff
> 
> This series fixes some bugs found when linking large binaries, both in buildroot
> and glibc testing.
> 
> Stafford Horne (2):
>    or1k: Add mcmodel option to handle large GOTs
>    or1k: Use cmodel=large when building crtstuff
> 
>   gcc/config/or1k/or1k-opts.h   | 30 ++++++++++++++++++++++++++++++
>   gcc/config/or1k/or1k.c        | 11 +++++++++--
>   gcc/config/or1k/or1k.h        |  7 +++++++
>   gcc/config/or1k/or1k.opt      | 19 +++++++++++++++++++
>   gcc/doc/invoke.texi           | 12 +++++++++++-
>   libgcc/config.host            |  4 ++--
>   libgcc/config/or1k/t-crtstuff |  2 ++
>   7 files changed, 80 insertions(+), 5 deletions(-)
>   create mode 100644 gcc/config/or1k/or1k-opts.h
>   create mode 100644 libgcc/config/or1k/t-crtstuff
> 

I've tested this patchset and works as expected.
It fixed libgeos build failure in conjunction with:
https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;h=3c3de29b048bca6b4aa4235c647b9328e71801b6

Hope this helps to commit it upstream since I still don't see it, or am 
I wrong?

Best regards
-- 
Giulio Benetti
Benetti Engineering sas
