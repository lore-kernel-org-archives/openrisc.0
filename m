From: Anatoly Pugachev <matorola@gmail.com>
Date: Wed, 17 Mar 2021 17:03:22 +0300
Subject: [OpenRISC] [PATCH v2] mm: Move mem_init_print_info() into
 mm_init()
In-Reply-To: <20210317015210.33641-1-wangkefeng.wang@huawei.com>
References: <4d488195-7281-9238-b30d-9f89a6100fb9@csgroup.eu>
 <20210317015210.33641-1-wangkefeng.wang@huawei.com>
Message-ID: <CADxRZqwFokuZrhA6GFr=whM3s7BqZpzo8yq=TW6YEr=eeEUH0A@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Mar 17, 2021 at 4:51 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
> mem_init_print_info() is called in mem_init() on each architecture,
> and pass NULL argument, so using void argument and move it into mm_init().
>
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
> v2:
> - Cleanup 'str' line suggested by Christophe and ACK

applied patch (5.12.0-rc3-00020-g1df27313f50a-dirty) over linus.git
and tested boot on a sparc64 virtual machine (ldom) - boots.
