From: Stafford Horne <shorne@gmail.com>
Date: Tue, 22 Dec 2020 22:18:45 +0900
Subject: [OpenRISC] [PATCH v2] openrisc: Add vmlinux.bin target
In-Reply-To: <CAK7LNAS_+VTDspmBNXPZzMKDhzDz9+TyKjrOs_Xho-ZMEPGDKA@mail.gmail.com>
References: <20201222070731.491076-1-joel@jms.id.au>
 <CAK7LNAS_+VTDspmBNXPZzMKDhzDz9+TyKjrOs_Xho-ZMEPGDKA@mail.gmail.com>
Message-ID: <20201222131845.GJ3168563@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, Dec 22, 2020 at 04:22:16PM +0900, Masahiro Yamada wrote:
> On Tue, Dec 22, 2020 at 4:07 PM Joel Stanley <joel@jms.id.au> wrote:
> >
> > Build it by default. This is commonly used by fpga targets.
> >
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > ---
> > v2: Address review from Masahiro
> >
> >  - Add vmlinux.bin to phony target
> >  - simplfy vmlinux.bin rule
> >  - add cleanup rule
> >  - add vmlinux.bin to targets
> >  - Add gitignore
> 
> 
>  Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>
> 

Thanks, I will queue this.  I am just wondering if I should wait for 5.12 or
just go ahead an send it in 5.11 as a fix.

-Stafford
