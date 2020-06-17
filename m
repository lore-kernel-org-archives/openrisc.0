From: Michel Lespinasse <walken@google.com>
Date: Wed, 17 Jun 2020 05:04:52 -0700
Subject: [OpenRISC] [PATCH] openrisc: Fix boot oops when DEBUG_VM is
 enabled
In-Reply-To: <20200617090247.1680188-1-shorne@gmail.com>
References: <20200617090247.1680188-1-shorne@gmail.com>
Message-ID: <CANN689E_oP3T6J3Rw2rWv1KG3GO3JOJtCdCb3yMLz+u8hFN=Qw@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Jun 17, 2020 at 2:03 AM Stafford Horne <shorne@gmail.com> wrote:
> Since v5.8-rc1 OpenRISC Linux fails to boot when DEBUG_VM is enabled.
> This has been bisected to commit 42fc541404f2 ("mmap locking API: add
> mmap_assert_locked() and mmap_assert_write_locked()").
>
> The added locking checks exposed the issue that OpenRISC was not taking
> this mmap lock when during page walks for DMA operations.  This patch
> locks and unlocks the mmap lock for page walking.
>
> Fixes: 42fc541404f2 ("mmap locking API: add mmap_assert_locked() and mmap_assert_write_locked()"
> Cc: Michel Lespinasse <walken@google.com>
> Signed-off-by: Stafford Horne <shorne@gmail.com>

Thanks for the fix.

Reviewed-by: Michel Lespinasse <walken@google.com>
