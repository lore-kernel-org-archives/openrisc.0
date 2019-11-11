From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 11 Nov 2019 11:09:05 +0100
Subject: [OpenRISC] [PATCH 10/21] asm-generic: ioremap_uc should behave
 the same with and without MMU
In-Reply-To: <20191029064834.23438-11-hch@lst.de>
References: <20191029064834.23438-1-hch@lst.de>
 <20191029064834.23438-11-hch@lst.de>
Message-ID: <CAK8P3a2o4R+E2hTrHrmNy7K1ki3_98aWE5a-fjkQ_NWW=xd_gQ@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Oct 29, 2019 at 7:49 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Whatever reason there is for the existence of ioremap_uc, and the fact
> that it returns NULL by default on architectures with an MMU applies
> equally to nommu architectures, so don't provide different defaults.

Makes sense.

> In practice the difference is meaningless as the only portable driver
> that uses ioremap_uc is atyfb which probably doesn't show up on nommu
> devices.



> +/*
> + * ioremap_uc is special in that we do require an explicit architecture
> + * implementation.  In general you do now want to use this function in a
> + * driver and use plain ioremap, which is uncached by default.  Similarly
> + * architectures should not implement it unless they have a very good
> + * reason.
> + */
> +#ifndef ioremap_uc
> +#define ioremap_uc ioremap_uc
> +static inline void __iomem *ioremap_uc(phys_addr_t offset, size_t size)
> +{
> +       return NULL;
> +}
> +#endif

Maybe we could move the definition into the atyfb driver itself?

As I understand it, the difference between ioremap()/ioremap_nocache()
and ioremap_uc() only exists on pre-PAT x86-32 systems (i.e. 486, P5,
Ppro, PII, K6, VIA C3), while on more modern systems (all non-x86,
PentiumIII, Athlon, VIA C7)  those three are meant to be synonyms
anyway.

      Arnd
