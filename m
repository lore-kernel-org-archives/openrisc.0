From: Giulio Benetti <giulio.benetti@benettiengineering.com>
Date: Mon, 3 May 2021 12:33:39 +0200
Subject: [OpenRISC] [PATCH v2 0/4] OpenRISC large binary fixes
In-Reply-To: <20210501210217.2975268-1-shorne@gmail.com>
References: <20210501210217.2975268-1-shorne@gmail.com>
Message-ID: <76d04212-37f6-b5bd-03d6-c4c253ed1aa3@benettiengineering.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Stafford, All,

I've backported this patchset for Buildroot to versions:
- 2.32
- 2.34
- 2.35.2
- 2.36.1

Does it make sense to send them? I don't know if those version will have 
minor versions where these backported patches can be applied.

Best regards
-- 
Giulio Benetti
Benetti Engineering sas

On 5/1/21 11:02 PM, Stafford Horne wrote:
> Changes since v1:
>   - Replaced patches 3/4 with a different approach.  Instead of relying on seeing
>     R_OR1K_GOT_AHI16 relocations to enable large plts, I just track the PLT entry
>     count and switch to large PLT when we detect the overflow will occur.
>   - Patch "Avoid R_OR1K_GOT16 overflow failures in presence of R_OR1K_GOT_AHI16"
>     is the actual bug fix for 21464, which was missed in the original series.  We
>     inhibit truncation detection when the low got() relocation is paired with the
>     new high gotha() relocation.
> 
> These are several fixes to OpenRISC BFD to handle issues mostly related to
> linking large files.
> 
> There will be a GCC patch then depends on this, a new -mcmodel=large argument is
> added to GCC to allow creating GOT relocation values larger than 64k.
> 
> The series fixes 3 issues:
> 
>   * PR 27624 - Assertion failure when dynamic symol is localized
>   * PR 21464 - GOT relocation truncation.
>   * PR 27746 - Issue with silent overlows in PLT code.
> 
> Stafford Horne (4):
>    or1k: Fix issue with plt link failure for local calls
>    or1k: Implement relocation R_OR1K_GOT_AHI16 for gotha()
>    or1k: Avoid R_OR1K_GOT16 overflow failures in presence of
>      R_OR1K_GOT_AHI16
>    or1k: Support large plt_relocs when generating plt entries
> 
>   bfd/bfd-in2.h                    |   1 +
>   bfd/elf32-or1k.c                 | 190 +++++++++++++++++++++++--------
>   bfd/libbfd.h                     |   1 +
>   bfd/reloc.c                      |   2 +
>   cpu/or1k.opc                     |   7 +-
>   gas/testsuite/gas/or1k/reloc-1.d |   4 +-
>   gas/testsuite/gas/or1k/reloc-1.s |   4 +
>   include/elf/or1k.h               |   1 +
>   ld/testsuite/ld-or1k/gotha1.dd   |  34 ++++++
>   ld/testsuite/ld-or1k/gotha1.s    |  24 ++++
>   ld/testsuite/ld-or1k/gotha2.dd   |  21 ++++
>   ld/testsuite/ld-or1k/gotha2.s    |  22 ++++
>   ld/testsuite/ld-or1k/or1k.exp    |   8 ++
>   ld/testsuite/ld-or1k/pltlib.s    |   1 +
>   opcodes/or1k-asm.c               |   7 +-
>   15 files changed, 279 insertions(+), 48 deletions(-)
>   create mode 100644 ld/testsuite/ld-or1k/gotha1.dd
>   create mode 100644 ld/testsuite/ld-or1k/gotha1.s
>   create mode 100644 ld/testsuite/ld-or1k/gotha2.dd
>   create mode 100644 ld/testsuite/ld-or1k/gotha2.s
> 

