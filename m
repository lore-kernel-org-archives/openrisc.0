From: Stafford Horne <shorne@gmail.com>
Date: Sun, 6 Feb 2022 19:04:06 +0900
Subject: [OpenRISC] [PATCH] openrisc: remove CONFIG_SET_FS
In-Reply-To: <CAMuHMdW2bxEtaYaLN28xk2uc=OV0ecUy-N_+Ay193gZq4nH0jw@mail.gmail.com>
References: <20220206013648.3491865-1-shorne@gmail.com>
 <CAMuHMdW2bxEtaYaLN28xk2uc=OV0ecUy-N_+Ay193gZq4nH0jw@mail.gmail.com>
Message-ID: <Yf+dFv1Fj3LFsaot@antec>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

H Geert,

Thanks for looking after it.

On Sun, Feb 06, 2022 at 10:42:46AM +0100, Geert Uytterhoeven wrote:
> Hi Stafford,
> 
> Thanks for your patch!
> 
> On Sun, Feb 6, 2022 at 2:37 AM Stafford Horne <shorne@gmail.com> wrote:
> > Remove the address space override API set_fs() used for User Mode Linux.
> 
> Note: this doesn't have anything to do with UML...

Yes, I agree for UML, I was actually following the text from Christoph's patch
here:

    https://lore.kernel.org/lkml/20211215165612.554426-1-hch at lst.de/T/#m439e32b3ecc8404424d2d8115d49fbf27c6393e9

The wording 'User Mode Linux' was perculiar. Maybe I should remove the
misleading text and just say:

    Remove the address space override API set_fs().

-Stafford

> > User address space is now limited to TASK_SIZE.
> >
> > To support this we implement and wire in __get_kernel_nofault and
> > __set_kernel_nofault.
> >
> > The function user_addr_max is removed as there is a default definition
> > provided when CONFIG_SET_FS is not used.
> >
> > Signed-off-by: Stafford Horne <shorne@gmail.com>

