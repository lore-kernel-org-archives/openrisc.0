From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 22 Mar 2019 10:08:29 -0700
Subject: [OpenRISC] [PATCH v5 3/3] locking/rwsem: Optimize
 down_read_trylock()
In-Reply-To: <20190322143008.21313-4-longman@redhat.com>
References: <20190322143008.21313-1-longman@redhat.com>
 <20190322143008.21313-4-longman@redhat.com>
Message-ID: <CAHk-=wi0wwmY-waC1-2SmBz4-XK-Eru2RTx6PrGzUK=P1nwexQ@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Mar 22, 2019 at 7:30 AM Waiman Long <longman@redhat.com> wrote:
>
> Modify __down_read_trylock() to optimize for an unlocked rwsem and make
> it generate slightly better code.

Oh, that should teach me to read all patches in the series before
starting to comment on them.

So ignore my comment on #1.

                Linus
