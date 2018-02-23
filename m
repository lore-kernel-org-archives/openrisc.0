From: Adam Borowski <kilobyte@angband.pl>
Date: Fri, 23 Feb 2018 22:34:23 +0100
Subject: [OpenRISC] Removing architectures without upstream gcc support
In-Reply-To: <1519414328.30443.29.camel@HansenPartnership.com>
References: <CAK8P3a2-6YwRR3j7J78fVHSvDpq8Kf4wRj6d9mnGgAxgkYypxg@mail.gmail.com>
 <20180222234833.GA3047@roeck-us.net>
 <CAK8P3a3Y2b-DivYz1ZqhFGUqQaiF=5SDB6RFLtCknwY2--09OQ@mail.gmail.com>
 <20180223154316.35b26857@alans-desktop>
 <20180223171019.GA1125@roeck-us.net>
 <20180223181943.GF30522@ZenIV.linux.org.uk>
 <1519414328.30443.29.camel@HansenPartnership.com>
Message-ID: <20180223213423.iskp7kmvy6rd52gc@angband.pl>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

On Fri, Feb 23, 2018 at 02:32:08PM -0500, James Bottomley wrote:
> On Fri, 2018-02-23 at 18:19 +0000, Al Viro wrote:
> [...]
> > IIRC, parisc/qemu stuff had been announced a while ago;
> 
> I have, but it didn't work sufficiently for me to either boot a kernel
> using system emulation or start an architecture container using user
> emulation.  I'll try again now that qemu has gone through several
> revisions.

Doesn't seem to work.  Debian package (1:2.11+dfsg-1) ships hppa support but
it doesn't even install binfmt; otherwise, -user is functional enough for a
minimal executable (so arch-test reports it as working[1]), but not for
anything libc:

[/srv/chroots/hppa]# chroot . /usr/bin/qemu-hppa-static /bin/true
qemu-hppa-static: /build/qemu-v8TF72/qemu-2.11+dfsg/target/hppa/translate.c:422: nullify_end: Assertion `status != DISAS_NORETURN && status != DISAS_IAQ_N_UPDATED' failed.
Segmentation fault

This looks bad enough that I didn't even look at qemu-system.


ᛗᛖᛟᚹ!

[1]. On archs without changed baseline, the test is just
write(1,"ok\n",3);_exit(0); unless there's a known issue to look for
such as swpb emulation being nop, etc.
-- 
⢀⣴⠾⠻⢶⣦⠀ 
⣾⠁⢰⠒⠀⣿⡁ Vat kind uf sufficiently advanced technology iz dis!?
⢿⡄⠘⠷⠚⠋⠀                                 -- Genghis Ht'rok'din
⠈⠳⣄⠀⠀⠀⠀ 
