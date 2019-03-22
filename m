From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 22 Mar 2019 10:07:04 -0700
Subject: [OpenRISC] [PATCH v5 2/3] locking/rwsem: Remove
 rwsem-spinlock.c & use rwsem-xadd.c for all archs
In-Reply-To: <20190322143008.21313-3-longman@redhat.com>
References: <20190322143008.21313-1-longman@redhat.com>
 <20190322143008.21313-3-longman@redhat.com>
Message-ID: <CAHk-=wjujKK-Ey7DPnMExaEmphicuEDLmVn-9+W9VzFzR-Ts=A@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Mar 22, 2019 at 7:30 AM Waiman Long <longman@redhat.com> wrote:
>
> For simplication, we are going to remove rwsem-spinlock.c and make all
> architectures use a single implementation of rwsem - rwsem-xadd.c.

Ack.

               Linus
