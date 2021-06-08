From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Tue, 8 Jun 2021 20:44:08 +0530
Subject: [OpenRISC] [PATCH v3 resend 01/15] mm: add
 setup_initial_init_mm() helper
In-Reply-To: <34f88fdc-1842-7954-bccc-0142a8d66eea@csgroup.eu>
References: <20210608083418.137226-1-wangkefeng.wang@huawei.com>
 <20210608083418.137226-2-wangkefeng.wang@huawei.com>
 <CAFqt6zYmCQ=wxEjnOJ6fgJWYQyFajBuxWD=UT_D-WjWUS_4pcw@mail.gmail.com>
 <34f88fdc-1842-7954-bccc-0142a8d66eea@csgroup.eu>
Message-ID: <CAFqt6zbV32+FsEFywqb6vk90tQ442S63CO+bh=2h8OxxutYQEQ@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

On Tue, Jun 8, 2021 at 8:27 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 08/06/2021 à 16:53, Souptick Joarder a écrit :
> > On Tue, Jun 8, 2021 at 1:56 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> >>
> >> Add setup_initial_init_mm() helper to setup kernel text,
> >> data and brk.
> >>
> >> Cc: linux-snps-arc at lists.infradead.org
> >> Cc: linux-arm-kernel at lists.infradead.org
> >> Cc: linux-csky at vger.kernel.org
> >> Cc: uclinux-h8-devel at lists.sourceforge.jp
> >> Cc: linux-m68k at lists.linux-m68k.org
> >> Cc: openrisc at lists.librecores.org
> >> Cc: linuxppc-dev at lists.ozlabs.org
> >> Cc: linux-riscv at lists.infradead.org
> >> Cc: linux-sh at vger.kernel.org
> >> Cc: linux-s390 at vger.kernel.org
> >> Cc: x86 at kernel.org
> >> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> >> ---
> >>   include/linux/mm.h | 3 +++
> >>   mm/init-mm.c       | 9 +++++++++
> >>   2 files changed, 12 insertions(+)
> >>
> >> diff --git a/include/linux/mm.h b/include/linux/mm.h
> >> index c274f75efcf9..02aa057540b7 100644
> >> --- a/include/linux/mm.h
> >> +++ b/include/linux/mm.h
> >> @@ -244,6 +244,9 @@ int __add_to_page_cache_locked(struct page *page, struct address_space *mapping,
> >>
> >>   #define lru_to_page(head) (list_entry((head)->prev, struct page, lru))
> >>
> >> +void setup_initial_init_mm(void *start_code, void *end_code,
> >> +                          void *end_data, void *brk);
> >> +
> >
> > Gentle query -> is there any limitation to add inline functions in
> > setup_arch() functions ?
>
> Kefeng just followed comment from Mike I guess, see
> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20210604070633.32363-2-wangkefeng.wang at huawei.com/#2696253

Ok.
>
> Christophe
>
