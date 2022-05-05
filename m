From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 5 May 2022 13:05:11 +0200
Subject: [PATCH v4 2/7] asm-generic: qspinlock: Indicate the use of
 mixed-size atomics
In-Reply-To: <7375410.EvYhyI6sBW@diego>
References: <20220430153626.30660-1-palmer@rivosinc.com>
 <20220430153626.30660-3-palmer@rivosinc.com>
 <7375410.EvYhyI6sBW@diego>
Message-ID: <CAK8P3a2fLg9DJvQeOAFhRQk-O72PAhJ77CLQ+Pz_Vvh1WV1APQ@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: openrisc@lists.librecores.org

On Wed, May 4, 2022 at 2:02 PM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
> > index d74b13825501..95be3f3c28b5 100644
> > --- a/include/asm-generic/qspinlock.h
> > +++ b/include/asm-generic/qspinlock.h
> > @@ -2,6 +2,37 @@
> >  /*
> >   * Queued spinlock
> >   *
> > + * A 'generic' spinlock implementation that is based on MCS locks. An
>
> _For_ an architecture that's ... ?
>
> > + * architecture that's looking for a 'generic' spinlock, please first =
consider
> > + * ticket-lock.h and only come looking here when you've considered all=
 the
> > + * constraints below and can show your hardware does actually perform =
better
> > + * with qspinlock.
> > + *
> > + *
>
> double empty line is probably not necessary
>

I've applied the series to the asm-generic tree now, and edited both the ab=
ove
as you suggested in the process, to save Palmer the v5.

         Arnd
