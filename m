From: Guo Ren <guoren@kernel.org>
Date: Thu, 5 May 2022 11:21:25 +0800
Subject: [PATCH v4 5/7] RISC-V: Move to generic spinlocks
In-Reply-To: <3428595.iIbC2pHGDl@diego>
References: <20220430153626.30660-1-palmer@rivosinc.com>
 <20220430153626.30660-6-palmer@rivosinc.com>
 <3428595.iIbC2pHGDl@diego>
Message-ID: <CAJF2gTSAbjTOjG+BhR-NW4i=Zqtb4eJ=5dTfxU1bU2Oc8V=2Wg@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: openrisc@lists.librecores.org

Reviewed-by: Guo Ren <guoren@kernel.org>

On Wed, May 4, 2022 at 8:02 PM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Am Samstag, 30. April 2022, 17:36:24 CEST schrieb Palmer Dabbelt:
> > From: Palmer Dabbelt <palmer@rivosinc.com>
> >
> > Our existing spinlocks aren't fair and replacing them has been on the
> > TODO list for a long time.  This moves to the recently-introduced ticket
> > spinlocks, which are simple enough that they are likely to be correct
> > and fast on the vast majority of extant implementations.
> >
> > This introduces a horrible hack that allows us to split out the spinlock
> > conversion from the rwlock conversion.  We have to do the spinlocks
> > first because qrwlock needs fair spinlocks, but we don't want to pollute
> > the asm-generic code to support the generic spinlocks without qrwlocks.
> > Thus we pollute the RISC-V code, but just until the next commit as it's
> > all going away.
> >
> > Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>
> on riscv64+riscv32 qemu, beaglev and d1-nezha
>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
>
>


--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
