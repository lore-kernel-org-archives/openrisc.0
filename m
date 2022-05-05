From: Guo Ren <guoren@kernel.org>
Date: Thu, 5 May 2022 11:20:44 +0800
Subject: [PATCH v4 6/7] RISC-V: Move to queued RW locks
In-Reply-To: <3100713.5fSG56mABF@diego>
References: <20220430153626.30660-1-palmer@rivosinc.com>
 <20220430153626.30660-7-palmer@rivosinc.com>
 <3100713.5fSG56mABF@diego>
Message-ID: <CAJF2gTRspLiaSExBMOXODTokhBofUXrF7sKAT8wp-XnKf3VJ=g@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: openrisc@lists.librecores.org

Reviewed-by: Guo Ren <guoren@kernel.org>

On Wed, May 4, 2022 at 8:03 PM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Am Samstag, 30. April 2022, 17:36:25 CEST schrieb Palmer Dabbelt:
> > From: Palmer Dabbelt <palmer@rivosinc.com>
> >
> > Now that we have fair spinlocks we can use the generic queued rwlocks,
> > so we might as well do so.
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
