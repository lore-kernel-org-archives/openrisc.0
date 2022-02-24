From: Arnd Bergmann <arnd@kernel.org>
Date: Thu, 24 Feb 2022 08:05:48 +0100
Subject: [OpenRISC] [PATCH v2 07/18] nios2: drop access_ok() check from
 __put_user()
In-Reply-To: <c6f461f1-1dd9-aec1-2c85-a3eda478a1be@kernel.org>
References: <20220216131332.1489939-1-arnd@kernel.org>
 <20220216131332.1489939-8-arnd@kernel.org>
 <c6f461f1-1dd9-aec1-2c85-a3eda478a1be@kernel.org>
Message-ID: <CAK8P3a34OBFhncvg32hO3qb1uH8cvwFb0ro1jEMT4bdOLrtfdw@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Feb 24, 2022 at 12:30 AM Dinh Nguyen <dinguyen@kernel.org> wrote:
> On 2/16/22 07:13, Arnd Bergmann wrote: From: Arnd Bergmann <arnd@arndb.de>
> >
> > Unlike other architectures, the nios2 version of __put_user() has an
> > extra check for access_ok(), preventing it from being used to implement
> > __put_kernel_nofault().
> >
> > Split up put_user() along the same lines as __get_user()/get_user()
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Acked-by: Dinh Nguyen <dinguyen@kernel.org>

Thanks! Could you also have a look at patch 2 (uaccess: fix nios2 and
microblaze get_user_8)? That one is actually more critical, and should
be backported to stable kernels.

       Arnd
