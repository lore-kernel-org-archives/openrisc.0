From: Arnd Bergmann <arnd@kernel.org>
Date: Fri, 18 Feb 2022 08:10:25 +0100
Subject: [OpenRISC] [PATCH v2 18/18] uaccess: drop maining CONFIG_SET_FS
 users
In-Reply-To: <20220218063714.GL22576@lst.de>
References: <20220216131332.1489939-1-arnd@kernel.org>
 <20220216131332.1489939-19-arnd@kernel.org>
 <20220218063714.GL22576@lst.de>
Message-ID: <CAK8P3a3ac9Wo6fs+Wbdw3-WHfzF9vu_CZs5EUUTX-1iALUr54w@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Feb 18, 2022 at 7:37 AM Christoph Hellwig <hch@lst.de> wrote:
>
> s/maining/remaining/ ?
>
> Or maybe rather:
>
> uaccess: remove CONFIG_SET_FS
>
> because it is all gone now.
>
> > With CONFIG_SET_FS gone, so drop all remaining references to
> > set_fs()/get_fs(), mm_segment_t and uaccess_kernel().
>
> And this sentence does not parse.

Both fixed now, thanks!

       Arnd
