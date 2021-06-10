From: Alan Modra <amodra@gmail.com>
Date: Thu, 10 Jun 2021 10:49:46 +0930
Subject: [OpenRISC] [PATCH v2] bfd/elf32-or1k: fix building with gcc
 version < 5
In-Reply-To: <20210609215233.1611478-1-giulio.benetti@benettiengineering.com>
References: <YME2SzQdpj/AVz/2@antec>
 <20210609215233.1611478-1-giulio.benetti@benettiengineering.com>
Message-ID: <YMFosi4vsWnxf9Sj@bubble.grove.modra.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Jun 09, 2021 at 11:52:33PM +0200, Giulio Benetti wrote:
> Gcc version >= 5 has standard C mode not set to -std=gnu11, so if we use
> an old compiler(i.e. gcc 4.9) build fails on:
> ```
> elf32-or1k.c:2251:3: error: 'for' loop initial declarations are only allowed in
> C99 or C11 mode
>     for (size_t i = 0; i < insn_count; i++)
>     ^
> ```

Did you find this problem on current mainline binutils?  The configure
machinery is supposed to supply the appropriate -std=c99 or -std=gnu99
when using older compilers.  That happens for me when I build with
gcc-4.9.  I don't think any patch is needed for mainline.

-- 
Alan Modra
Australia Development Lab, IBM
